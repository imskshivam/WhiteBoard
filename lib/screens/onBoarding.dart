import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List<Color> colors = [Colors.blue, Colors.green, Colors.pink];

  List<Widget> page = [
    Column(
      children: [
        Container(
          height: 250,
          width: 250,
          child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/ecommercehack08.appspot.com/o/13678507_5172140-removebg-preview.png?alt=media&token=8be1b8d0-c7c2-45c7-88fa-e56cd9f5a497"),
        )
      ],
    ),
    Column(
      children: [
        Container(
          height: 250,
          width: 250,
          child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/ecommercehack08.appspot.com/o/13678535_5239429-removebg-preview.png?alt=media&token=0aa88384-bc44-41d3-aecb-1b6da9660cb0"),
        )
      ],
    ),
    Column(
      children: [
        Container(
          height: 250,
          width: 250,
          child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/ecommercehack08.appspot.com/o/13678535_5239429-removebg-preview.png?alt=media&token=0aa88384-bc44-41d3-aecb-1b6da9660cb0"),
        )
      ],
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: LiquidSwipe(
        pages: page,
        enableLoop: true,
        fullTransitionValue: 400,
        waveType: WaveType.liquidReveal,
        positionSlideIcon: 0.5,
      ),
    );
  }
}
