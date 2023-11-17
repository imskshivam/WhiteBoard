import 'package:flutter/material.dart';
import 'package:flutter_application_1/paint_screen.dart';
import 'package:flutter_application_1/widgets/custom_text_field.dart';
import 'package:lottie/lottie.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({Key? key}) : super(key: key);

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();

  void joinRoom() {
    if (_nameController.text.isNotEmpty &&
        _roomNameController.text.isNotEmpty) {
      Map<String, String> data = {
        "nickname": _nameController.text,
        "name": _roomNameController.text
      };

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              PaintScreen(data: data, screenForm: 'joinRoom')));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _roomNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            child: Lottie.network(
                "https://assets2.lottiefiles.com/packages/lf20_zjwaxpdr.json"),
          ),
          const Text(
            "Join Room",
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CutomTextField(
              contorller: _nameController,
              hintText: "Enter Your name",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CutomTextField(
              contorller: _roomNameController,
              hintText: " Enter Room Name",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: joinRoom,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  textStyle:
                      MaterialStateProperty.all(TextStyle(color: Colors.white)),
                  minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width / 2.5, 50))),
              child: const Text(
                "Join",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ))
        ],
      ),
    );
  }
}
