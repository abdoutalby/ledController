class Lamp {
  late String name;
  late bool on;
  Lamp(String _name) {
    name = _name;
    on = false;
  }
}

class Device {
  String ipAddress = "";

  Device(this.ipAddress);
}
