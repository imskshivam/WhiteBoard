import 'package:flutter/material.dart';
import 'package:flutter_application_1/paint_screen.dart';
import 'package:flutter_application_1/widgets/custom_text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({Key? key}) : super(key: key);

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  bool _lights = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();

  String _maxRoomsize = "Selext Max size";
  String _category = "Selext Max size";
  String dataform = "";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _roomNameController.dispose();
  }

  void createRoom() {
    if (_nameController.text.isNotEmpty &&
        _roomNameController.text.isNotEmpty &&
        _maxRoomsize != "Selext Max size") {
      Map<String, String> data = {
        "username": _nameController.text,
        "Rname": _roomNameController.text,
        "occupancy": _maxRoomsize
      };

      setState(() {
        dataform = _nameController.text +
            "/" +
            _roomNameController.text +
            "/" +
            _maxRoomsize;
      });

      Navigator.push(context, MaterialPageRoute(builder: ((context) {
        return PaintScreen(data: data, screenForm: "createRoom");
      })));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
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
                  "Create Room",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
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
                DropdownButton<String>(
                  focusColor: Color(0xffF5F6FA),
                  onChanged: (String? value) {
                    setState(() {
                      _maxRoomsize = value.toString();
                    });
                  },
                  items: <String>["2", "5", "10", "15"]
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              )))
                      .toList(),
                  hint: Text(
                    _maxRoomsize,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButton<String>(
                  focusColor: Color(0xffF5F6FA),
                  onChanged: (String? value) {
                    setState(() {
                      _category = value.toString();
                    });
                  },
                  items: <String>["ClassRoom", "Entertainment"]
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              )))
                      .toList(),
                  hint: Text(
                    _category,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    Switch.adaptive(
                        value: _lights,
                        onChanged: (bool value) {
                          setState(() {
                            _lights = value;
                          });
                        })
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: createRoom,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: Colors.white)),
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width / 2.5, 50))),
                    child: const Text(
                      "Create",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                // Container(
                //   child: QrImage(
                //     data: dataform,
                //     backgroundColor: Colors.white,
                //     size: 200,
                //   ),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
