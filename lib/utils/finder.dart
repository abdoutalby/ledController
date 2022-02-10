import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:led_controller/utils/deviceitemlist.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../model/models.dart';

class Finder extends StatefulWidget {
  Finder({Key? key}) : super(key: key);

  @override
  State<Finder> createState() => _FinderState();
}

class _FinderState extends State<Finder> {
  List<Device> devices = [];

  Future<Null> _scanDevices() async {
    final NetworkInfo _networkInfo = NetworkInfo();
    final ip = await _networkInfo.getWifiIP();
    print(ip.toString());
    final String subnet = ip!.substring(0, ip.lastIndexOf('.'));
    final int port = 80;

    final stream = NetworkAnalyzer.discover(subnet, port);
    http.Client client = http.Client();
    stream.listen((NetworkAddress addr) async {
      print(addr.ip);
      _testConnection(client, addr.ip);
    });

    return null;
  }

  void _testConnection(final http.Client client, final String ip) async {
    try {
      final response = await client.get(Uri.parse('http://$ip/isitesp'));

      if (response.statusCode == 200) {
        if (response.body.contains("esp32")) {
          if (!devices.contains(ip)) {
            print("oui cest un esp");
            print('Found a device with ip $ip! Adding it to list of devices');
            List<Device> containedDevices = [];
            for (Device device in devices) {
              if (device.ipAddress.compareTo(ip) == 0) {
                containedDevices.add(device);
              }
            }

            if (containedDevices.isEmpty) {
              setState(() {
                devices.add(
                  Device(ip),
                );
              });
            }
          }
        }
      }
    } on SocketException catch (e) {
      //NOP
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scanDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("finder "),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () async {
              await _scanDevices();
            },
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 242, 244, 243),
      body: RefreshIndicator(
        onRefresh: () async {
          await _scanDevices();
        },
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: devices.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return DeviceListItem(devices[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
