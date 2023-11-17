import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/chat_page.dart';
import 'package:flutter_application_1/screens/MessageScreeen.dart';
import 'package:flutter_application_1/widgets/my_custom_paint.dart';
import 'package:flutter_application_1/widgets/touch_points.dart';
import 'package:lottie/lottie.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:math';

class PaintScreen extends StatefulWidget {
  final Map data;
  final String screenForm;

  const PaintScreen({Key? key, required this.data, required this.screenForm})
      : super(key: key);

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  double value = 0;
  late IO.Socket _socket;
  double strokewidth = 1;
  Color selectedcolor = Colors.blueAccent;
  double opacity = 1;
  Map dataofRoom = {};
  List<TouchPoints> points = [];
  List<Color> colors = [
    Colors.blue,
    Colors.amber,
    Colors.pink,
    Colors.red,
    Colors.black,
    Colors.green,
    Colors.brown
  ];

  StrokeCap strokeCap = StrokeCap.round;
  double itemWidth = 60.0;
  int itemCount = 10;
  int selected = 50;
  FixedExtentScrollController _scrollController =
      FixedExtentScrollController(initialItem: 50);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
    print(widget.data);
  }

  void connect() {
    _socket = IO.io("http://172.20.10.2:3000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });

    _socket.connect();

    if (widget.screenForm == 'createRoom') {
      _socket.emit('create-Room', widget.data);
    } else {
      _socket.emit('join-Room', widget.data);
    }

    _socket.onConnect((data) {
      print("connected");
      _socket.on('updateRoom', (roomdata) {
        setState(() {
          dataofRoom = roomdata;
        });

        if (roomdata['isjoin'] != true) {}
      });

      _socket.on('points', (point) {
        if (point['details'] != null) {
          setState(() {
            points.add(TouchPoints(
                paint: Paint()
                  ..strokeCap = strokeCap
                  ..isAntiAlias = true
                  ..color = selectedcolor.withOpacity(opacity)
                  ..strokeWidth = strokewidth,
                points: Offset((point['details']['dx']).toDouble(),
                    (point['details']['dy']).toDouble())));
          });
        }
      });

      _socket.on('RoomnameWrong',
          (data) => {ScaffoldMessenger.of(context).showSnackBar(data)});

      _socket.on('color-change', (data) {
        setState(() {
          selectedcolor = colors[data['index']];
        });
      });

      _socket.on('eraser', (data) {
        setState(() {
          points.clear();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        InkWell(
          onDoubleTap: () {
            setState(() {
              value == 0 ? value = 1 : value = 0;
            });
          },
          child: Scaffold(
              backgroundColor: Colors.grey.withOpacity(0.1),
              body: ChatDetailPage()),
        ),
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: value),
          duration: Duration(milliseconds: 600),
          builder: (context, double val, child) {
            return (Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..setEntry(0, 3, 200 * val)
                ..rotateY((pi / 1.8) * val),
              child: Scaffold(
                body: Stack(
                  children: [
                    Container(
                      width: width,
                      height: height,
                      child: GestureDetector(
                        onTap: () {
                          print("object");
                        },
                        onPanUpdate: (details) {
                          print(details.localPosition.dx);
                          _socket.emit('paint', {
                            'details': {
                              'dx': details.localPosition.dx,
                              'dy': details.localPosition.dy
                            },
                            'Rname': widget.data['name'],
                          });
                        },
                        onPanStart: (details) {
                          _socket.emit('paint', {
                            'details': {
                              'dx': details.localPosition.dx,
                              'dy': details.localPosition.dy
                            },
                            'Rname': widget.data['name'],
                          });
                        },
                        onPanEnd: (details) {
                          print("end");
                          _socket.emit('paint', {
                            'details': null,
                            'Rname': widget.data['name'],
                          });
                        },
                        child: SizedBox.expand(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: RepaintBoundary(
                              child: CustomPaint(
                                size: Size.infinite,
                                painter: MycustomPainter(pointList: points),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                          height: 100,
                          width: double.infinity,
                          child: RotatedBox(
                              quarterTurns: -1,
                              child: ListWheelScrollView(
                                magnification: 2.0,
                                onSelectedItemChanged: (x) {
                                  setState(() {
                                    selected = x;
                                    Map map = {
                                      'index': x,
                                      'roomname': dataofRoom['Rname']
                                    };

                                    _socket.emit('color-change', map);
                                  });
                                  print(selected);
                                },
                                controller: _scrollController,
                                children: List.generate(
                                    colors.length,
                                    (x) => RotatedBox(
                                        quarterTurns: 1,
                                        child: AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 400),
                                            width: x == selected ? 50 : 40,
                                            height: x == selected ? 50 : 40,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: x == selected
                                                    ? colors[x]
                                                    : colors[x]
                                                        .withOpacity(0.2),
                                                shape: BoxShape.circle),
                                            child: Text('$x')))),
                                itemExtent: itemWidth,
                              ))),
                    ),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          height: 30,
                          width: 30,
                          child: Lottie.network(
                              "https://assets5.lottiefiles.com/packages/lf20_m43z9rzg.json"),
                        )),
                    Positioned(
                        bottom: 20,
                        left: 20,
                        child: InkWell(
                          onTap: () {
                            _socket.emit('eraser', dataofRoom['Rname']);
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/ecommercehack08.appspot.com/o/eraser.png?alt=media&token=1df400a5-6cd8-4754-84df-0bcff9b76b1f"),
                          ),
                        )),
                    Positioned(
                        bottom: 20,
                        left: 80,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              value == 0 ? value = 1 : value = 0;
                            });
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/ecommercehack08.appspot.com/o/chat.png?alt=media&token=245a3728-f141-408f-928e-4dbde8db7bef"),
                          ),
                        )),
                    Positioned(
                        bottom: 20,
                        left: 130,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 25,
                            width: 25,
                            child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/ecommercehack08.appspot.com/o/crowd-of-users.png?alt=media&token=59aeb57b-35e5-4f42-85ff-e04a34154d19"),
                          ),
                        )),
                    Positioned(
                        bottom: 20,
                        right: 70,
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0)), //this right here
                                      child: Container(
                                        height: 250,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  child: Text(
                                                      "Do you Really Want to Quit")),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {},
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
                                                        "Yes",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      )),
                                                  ElevatedButton(
                                                      onPressed: () {},
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
                                                        "No",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(color: Colors.white)),
                                minimumSize: MaterialStateProperty.all(Size(
                                    MediaQuery.of(context).size.width / 3.5,
                                    50))),
                            child: const Text(
                              "Leave",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ))),
                  ],
                ),
              ),
            ));
          },
        ),
        // GestureDetector(
        //   onHorizontalDragUpdate: (details) {
        //     if (details.delta.dx > 0) {
        //       setState(() {
        //         value = 1;
        //       });
        //     } else {
        //       setState(() {
        //         value = 0;
        //       });
        //     }
        //   },
        // )
      ],
    ));
  }
}
