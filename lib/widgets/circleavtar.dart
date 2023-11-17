import 'package:flutter/material.dart';

class custom_circle extends StatelessWidget {
  const custom_circle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      child: Stack(
        children: [
          Positioned(
            top: 5,
            left: 10,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.red[200],
            ),
          ),
          Positioned(
            top: 5,
            left: 25,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.green[200],
            ),
          ),
          Positioned(
            top: 5,
            left: 40,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.blue[200],
            ),
          ),
          Positioned(
            top: 5,
            left: 55,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.green[200],
            ),
          ),
          Positioned(
            top: 5,
            left: 70,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.red[200],
            ),
          ),
        ],
      ),
    );
  }
}
