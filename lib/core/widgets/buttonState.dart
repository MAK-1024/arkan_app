import 'dart:async';
import 'package:flutter/material.dart';

class CircleButton extends StatefulWidget {
  @override
  _CircleButtonState createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  bool _isAnimating = false;
  bool _showProgress = false;
  bool _showCheck = false;

  void _startAnimation() {
    setState(() {
      _isAnimating = true;
    });

    Timer(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimating = false;
        _showProgress = true;
      });

      Timer(Duration(seconds: 2), () {
        setState(() {
          _showProgress = false;
          _showCheck = true;
          _isAnimating = true; // Re-animating back to the initial state
        });

        Timer(Duration(seconds: 1), () {
          setState(() {
            _showCheck = false;
            _isAnimating = false; // Return to the original button state
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_showProgress && !_showCheck) {
          _startAnimation();
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: _isAnimating ? 50 : 300,
        height: _isAnimating ? 50 : 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_isAnimating ? 25 : 8),
          color: Colors.black,
        ),
        child: Center(
          child: _showProgress
              ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : _showCheck
              ? Icon(
            Icons.check,
            color: Colors.green,
            size: 30,
          )
              : AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: _isAnimating ? 0.0 : 1.0,
            child: Text(
              'Add To Cart',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}


