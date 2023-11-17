import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/anmiated_loading.dart';
import 'package:flutter_application_1/widgets/circleavtar.dart';
import 'package:lottie/lottie.dart';

import '../paint_screen.dart';
import '../widgets/custom_text_field.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();

  void joinRoom() {
    if (_nameController.text.isNotEmpty &&
        _roomNameController.text.isNotEmpty) {
      Map<String, String> data = {
        "nickname": _nameController.text,
        "name": _roomNameController.text
      };

      showGeneralDialog(
        context: context,
        barrierColor: Colors.black12.withOpacity(0.6), // Background color
        barrierDismissible: false,
        barrierLabel: 'Dialog',
        transitionDuration: Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) {
          return Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: SizedBox.expand(child: Loading()),
              ),
            ],
          );
        },
      );
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
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.green, Color.fromARGB(255, 247, 246, 240)])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Morning!",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Shivam Karoria",
                        style: TextStyle(
                            letterSpacing: 0.3,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/ecommercehack08.appspot.com/o/user.png?alt=media&token=a02a6a19-36e1-4940-9c00-53ea7617da1a"),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Online Event",
                style: TextStyle(
                    letterSpacing: 0.3,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  height: 210,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromARGB(0, 90, 167, 1),
                            Color.fromARGB(255, 253, 228, 1),
                          ]),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.star,
                              color: Colors.amberAccent,
                              size: 40,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 230,
                              child: Text(
                                "How to become Star seller on Uplabes as Contributer",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.maxFinite,
                        child: Text(
                          "the Uplabs Market is the only place powered by a community of passionate designers & developers",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            custom_circle(),
                            ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20.0)), //this right here
                                          child: Container(
                                            height: 250,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    child: CutomTextField(
                                                      contorller:
                                                          _nameController,
                                                      hintText:
                                                          "Enter Your name",
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    child: CutomTextField(
                                                      contorller:
                                                          _roomNameController,
                                                      hintText:
                                                          " Enter Room Name",
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: joinRoom,
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty.all(
                                                                  Colors.blue),
                                                          textStyle: MaterialStateProperty
                                                              .all(TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                          minimumSize:
                                                              MaterialStateProperty.all(Size(
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      5,
                                                                  25))),
                                                      child: const Text(
                                                        "Join",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Text(
                                  "Join Now",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Upcoming Event",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "View all",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    3,
                    (index) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: upcomingCard()),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "View all",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    3,
                    (index) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: categores()),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Lottie.network(
                    "https://assets4.lottiefiles.com/packages/lf20_fq7pwzey.json"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class categores extends StatelessWidget {
  const categores({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 110,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    child: Text(
                      "Educational Area",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/ecommercehack08.appspot.com/o/pencil.png?alt=media&token=55416a7c-cfd6-4e23-82de-e6acab6702c6"),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.chat,
                    color: Colors.grey,
                    size: 14,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "12 rooms",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class upcomingCard extends StatelessWidget {
  const upcomingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 180,
      width: 350,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.pink[200],
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 260,
                height: 50,
                child: Text(
                  "How to become Star seller on Uplabes as Contributer",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(
                Icons.timelapse_sharp,
                color: Colors.grey,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Wednesday, 3 June 2022",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              custom_circle(),
              ElevatedButton(
                  onPressed: () {
                    showGeneralDialog(
                      context: context,
                      barrierColor:
                          Colors.black12.withOpacity(0.6), // Background color
                      barrierDismissible: false,
                      barrierLabel: 'Dialog',
                      transitionDuration: Duration(milliseconds: 400),
                      pageBuilder: (_, __, ___) {
                        return Column(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: SizedBox.expand(child: Loading()),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Add"))
            ],
          ),
        ],
      ),
    );
  }
}
