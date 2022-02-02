import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:led_controller/utils/components.dart';

// ignore: camel_case_types, use_key_in_widget_constructors
class circleBtn extends StatefulWidget {
  @override
  _circleBtnState createState() => _circleBtnState();
}

class _circleBtnState extends State<circleBtn>
    with SingleTickerProviderStateMixin {
  bool isLight = false;
  late AnimationController _controller;
  late Animation _colorAnimation;
  Color _iconColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _colorAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _controller.addListener(() {
      setState(() {});
      print("${_controller.value} controller ");
      print("${_colorAnimation.value}  colorController");
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isLight = true;
          _iconColor = Colors.white.withOpacity(0.9);
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isLight = false;
          _iconColor = Colors.grey;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, _) {
          return Center(
            child: Column(children: [
              Container(
                width: 100,
                height: 100,
                child: Stack(
                  children: [
                    ShaderMask(
                      shaderCallback: (rect) {
                        return SweepGradient(
                            startAngle: 0.0,
                            endAngle: 3.14 * 2,
                            stops: [
                              _colorAnimation.value,
                              _colorAnimation.value
                            ],
                            // 0.0 , 0.5 , 0.5 , 1.0
                            center: Alignment.center,
                            colors: [
                              Colors.white,
                              Colors.grey.withAlpha(55)
                            ]).createShader(rect);
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: _iconColor),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 100 - 20,
                        height: 100 - 20,
                        decoration: const BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        child: Center(
                          child: IconButton(
                            iconSize: 50,
                            icon: Icon(
                              Icons.light_mode,
                              color: _iconColor,
                            ),
                            onPressed: () {
                              isLight
                                  ? _controller.reverse()
                                  : _controller.forward();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ]),
          );
        });
  }
}
