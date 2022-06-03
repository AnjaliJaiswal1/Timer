import 'dart:html';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    title: "Timer",
    home: DefaultTabController(length: 2, child: Homepage()),
    debugShowCheckedModeBanner: false,
  ));
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int hour = 0;
  var min = 0, sec = 0;
  bool started = true;
  bool stopped = true;
  String timetodisplay = "";
  int timefortimer = 0;
  bool checktimer = true;

  void start() {
    setState(() {
      started = false;
      stopped = false;
    });
    timefortimer = ((hour * 3600) + (min * 60) + sec);
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timefortimer < 1 || checktimer == false) {
          timer.cancel();
          checktimer = true;
          timetodisplay = "0";
          started = true;
          stopped = true;
          // Navigator.pushReplacement(context, MaterialPageRoute(
          //   builder: (context)=>Homepage()));
        } else if (timefortimer < 3600) {
          int m = timefortimer ~/ 60;
          int s = timefortimer - (m * 60);

          timetodisplay = m.toString() + ":" + s.toString();
          timefortimer = timefortimer - 1;
        } else {
          int h = timefortimer ~/ 3600;
          int t = timefortimer - (3600 * h);
          int m = t ~/ 60;
          int s = t - (m * 60);
          timetodisplay =
              h.toString() + ":" + m.toString() + ":" + s.toString();
          timefortimer = timefortimer - 1;
        }
        // else {
        //   timefortimer = timefortimer - 1;
        // }
        //timetodisplay = timefortimer.toString();
      });
    });
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      checktimer = false;
    });
  }

  Widget timer() {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // time("HH", hour, 23),
                // time("Min", min, 59),
                // time("Sec", sec, 59),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("HH"),
                    ),
                    NumberPicker(
                        minValue: 0,
                        maxValue: 23,
                        value: hour,
                        onChanged: (val) {
                          setState(() {
                            hour = val;
                          });
                        })
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Min"),
                    ),
                    NumberPicker(
                        minValue: 0,
                        maxValue: 59,
                        value: min,
                        onChanged: (val) {
                          setState(() {
                            min = val;
                          });
                        })
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Sec"),
                    ),
                    NumberPicker(
                        minValue: 0,
                        maxValue: 59,
                        value: sec,
                        onChanged: (val) {
                          setState(() {
                            sec = val;
                          });
                        })
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Text(
                timetodisplay,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
          Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: TextButton(
                        onPressed: started ? start : null,
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.green),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "Start",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: TextButton(
                        onPressed: stopped ? null : stop,
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.green),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "Stop",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  )),
                ],
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Watch"),
        centerTitle: true,
        bottom: TabBar(
            labelPadding: EdgeInsets.all(30),
            tabs: [Text("Timer"), Text("StopWatch")]),
      ),
      body: TabBarView(children: [timer(), Text("stopwatch")]),
    );
  }
}
