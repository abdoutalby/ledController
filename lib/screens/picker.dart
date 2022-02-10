 
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

class picker extends StatefulWidget {
  picker({Key? key}) : super(key: key);

  @override
  State<picker> createState() => _pickerState();
}

class _pickerState extends State<picker> {
  Color _currentColor = Colors.blue;
  bool _onoff = false;
  final _controller = CircleColorPickerController(
    initialColor: Colors.blue,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 2,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 48),
          Center(
            child: CircleColorPicker(
              strokeWidth: 10,
              size: const Size(300, 300),
              controller: _controller,
              onChanged: (color) {
                setState(() => _currentColor = color);
              },
            ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => _controller.color = Colors.blue,
                child: const Text('BLUE', style: TextStyle(color: Colors.blue)),
              ),
              TextButton(
                onPressed: () => _controller.color = Colors.green,
                child:
                    const Text('GREEN', style: TextStyle(color: Colors.green)),
              ),
              TextButton(
                onPressed: () => _controller.color = Colors.red,
                child: const Text('RED', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
          SizedBox(height: 12),
          IconButton(
              color: _onoff ? _currentColor : Colors.grey,
              iconSize: 40,
              onPressed: () {
                setState(() {
                  _onoff = !_onoff;
                });
              },
              icon: const Icon(Icons.power_settings_new_outlined))
        ],
      ),
    );
  }
}
