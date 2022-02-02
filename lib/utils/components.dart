import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:led_controller/screens/picker.dart';

import 'circular_btn.dart';

class Components {
  static textstyle() {
    return TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
  }

  static textstyle1() {
    return TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
  }

  MyDecoration() {
    return BoxDecoration();
  }

  // ignore: non_constant_identifier_names
  static MyBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
    );
  }

  static btn(String name) {
    return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.grey.withAlpha(55)),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0))),
        ),
        onPressed: () => Get.to(picker()),
        child: Row(children: [
          Text(name),
          const Icon(
            Icons.arrow_right,
          ),
        ]));
  }

  Widget light(String name) {
    return Center(
        child: Column(children: [
      circleBtn(),
      Components.btn(name),
    ]));
  }

  static dbtn(String name, _win, _icon) {
    return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black26),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          overlayColor: MaterialStateProperty.all(Colors.grey),
          fixedSize: MaterialStateProperty.all(const Size(100, 40)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
        ),
        onPressed: () => Get.to(_win),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(name),
          Icon(_icon),
        ]));
  }
}
