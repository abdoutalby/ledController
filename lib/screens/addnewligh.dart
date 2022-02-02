import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';

class NewLight extends StatefulWidget {
  NewLight({Key? key}) : super(key: key);

  @override
  State<NewLight> createState() => _NewLightState();
}

class _NewLightState extends State<NewLight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add new light"),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            ElevatedButton(onPressed: getIps, child: const Text("find "))
          ],
        ),
      ),
    );
  }
}

getIps() async {
  final ip = await Ipify.ipv4();
  print(ip);
  final String subnet = ip.substring(0, ip.lastIndexOf('.'));
  final int port = 80;

  final stream = NetworkAnalyzer.discover2(
    ip,
    port,
    timeout: Duration(milliseconds: 5000),
  );

  int found = 0;
  stream.listen((NetworkAddress addr) {
    // print('${addr.ip}:$port');
    if (addr.exists) {
      found++;
      print('Found device: ${addr.ip}:$port');
    }
  }).onDone(() => print('Finish. Found $found device(s)'));
}
