import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

class LoginAnimatedText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: DefaultTextStyle(
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 60
              ),
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Door Shop',
                    cursor: '|',
                    curve: Curves.decelerate,
                    textAlign: TextAlign.start,
                    speed: Duration(milliseconds: 150),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            child: DefaultTextStyle(
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),
              child: DelayedDisplay(
                  delay: Duration(milliseconds: 3650),
                  child: Text('Admin')
              ),
            ),
          ),
        ],
      ),
    );
  }
}
