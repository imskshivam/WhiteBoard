import 'package:flutter/material.dart';

class events extends StatefulWidget {
  const events({Key? key}) : super(key: key);

  @override
  State<events> createState() => _eventsState();
}

class _eventsState extends State<events> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upcoming Event",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
