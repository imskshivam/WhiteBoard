import 'package:flutter/material.dart';
import 'package:flutter_application_1/create_room_screen.dart';
import 'package:flutter_application_1/join_room_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Create/Join a room ",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreateRoomScreen()));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(color: Colors.white)),
                      minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width / 2.5, 50))),
                  child: Text(
                    "Create",
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => JoinRoomScreen()));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(color: Colors.white)),
                      minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width / 2.5, 50))),
                  child: Text(
                    "Join",
                  )),
            ],
          )
        ],
      ),
    );
  }
}
