import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0.2)
          ])),
      child: Center(
        child: SizedBox(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DNA(
                index: 20,
                color: Colors.amber,
              ),
              DNA(
                index: 18,
                color: Colors.orange,
              ),
              DNA(
                index: 16,
                color: Colors.pink,
              ),
              DNA(
                index: 14,
                color: Colors.red,
              ),
              DNA(
                index: 12,
                color: Colors.purple,
              ),
              DNA(
                index: 10,
                color: Colors.amber,
              ),
              DNA(
                index: 8,
                color: Colors.orange,
              ),
              DNA(
                index: 6,
                color: Colors.pink,
              ),
              DNA(
                index: 4,
                color: Colors.red,
              ),
              DNA(
                index: 2,
                color: Colors.purple,
              ),
              DNA(
                index: 2,
                color: Colors.amber,
              ),
              DNA(
                index: 4,
                color: Colors.orange,
              ),
              DNA(
                index: 6,
                color: Colors.pink,
              ),
              DNA(
                index: 8,
                color: Colors.red,
              ),
              DNA(
                index: 10,
                color: Colors.purple,
              ),
              DNA(
                index: 12,
                color: Colors.amber,
              ),
              DNA(
                index: 14,
                color: Colors.orange,
              ),
              DNA(
                index: 16,
                color: Colors.pink,
              ),
              DNA(
                index: 18,
                color: Colors.red,
              ),
              DNA(
                index: 20,
                color: Colors.purple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DNA extends StatefulWidget {
  final int index;
  final Color color;
  const DNA({Key? key, required this.index, required this.color})
      : super(key: key);

  @override
  State<DNA> createState() => _DNAState();
}

class _DNAState extends State<DNA> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _scaleAnimation = Tween<double>(begin: 2.0, end: 40.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    super.initState();

    Future.delayed(Duration(milliseconds: widget.index * 80), () {
      _animationController.forward();
    });

    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      } else if (_animationController.isDismissed) {
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Container(
            height: _scaleAnimation.value,
            width: 4.0,
            decoration: BoxDecoration(
                color: widget.color, borderRadius: BorderRadius.circular(5.0)),
          );
        },
      ),
    );
  }
}
