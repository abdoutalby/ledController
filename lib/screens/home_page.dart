// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:led_controller/model/models.dart';
import 'package:led_controller/screens/addnewligh.dart';
import 'package:led_controller/utils/components.dart';
import 'package:led_controller/utils/finder.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Lamp> lightlist = [
    Lamp('light 1'),
    Lamp('light 11'),
    Lamp('light 111'),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 4.0,
          title: const Text(
            'My Home',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () => {
                Get.defaultDialog(
                    cancel: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black26),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          overlayColor: MaterialStateProperty.all(Colors.grey),
                          fixedSize:
                              MaterialStateProperty.all(const Size(100, 40)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        onPressed: () => Get.back(),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("cancel"),
                              Icon(Icons.cancel),
                            ])),
                    title: "Add new ",
                    titleStyle: const TextStyle(color: Colors.white),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Components.dbtn("Light", NewLight(),
                            Icons.add_to_home_screen_outlined),
                        const SizedBox(
                          height: 5,
                        ),
                        Components.dbtn("Light", NewLight(),
                            Icons.add_to_home_screen_outlined),
                        const SizedBox(
                          height: 5,
                        ),
                        Components.dbtn("Light", NewLight(),
                            Icons.add_to_home_screen_outlined),
                      ],
                    )),
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () => {Get.to(Finder())},
            )
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Favorites",
                style: Components.textstyle(),
              ),
              Container(
                child: listabuilder(lightlist),
              ),
              Text(
                "Lights",
                style: Components.textstyle(),
              ),
              Container(
                child: listabuilder(lightlist),
              ),
              Text(
                "Groups",
                style: Components.textstyle(),
              ),
              Container(
                child: listabuilder(lightlist),
              ),
            ])),
      ),
    );
  }

  listabuilder(List lista) {
    return Expanded(
        child: ListView.separated(
      itemCount: lista.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Components().light(lista[index].name);
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        width: 10,
      ),
    ));
  }
}
