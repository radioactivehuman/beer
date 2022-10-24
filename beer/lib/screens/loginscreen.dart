// ignore_for_file: unnecessary_import

import 'dart:ui';
// import 'dart:html';
import 'package:beer/screens/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  final _ctrl = TextEditingController();
  final _mybox = Hive.box('username');

  void add_username() {
    _mybox.put('username', _ctrl.text);

    print(_mybox.get('username'));
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        decoration: new BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/img7.jpeg'),
                fit: BoxFit.cover)),
        alignment: Alignment.center,
        // color: Colors.amber,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
              height: 500,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      height: 250,
                      child: Image.asset('assets/images/logo.png')),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: TextField(
                      controller: _ctrl,
                      decoration: InputDecoration(
                        // focusColor: Colors.blueGrey,
                        prefixIconColor: Colors.blueGrey,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.purple,
                        ),
                        hintText: 'username',
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5)),
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Text(
                          " Login... ",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(184)),
                        height: 40,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => homepage(
                                          username: 'idk',
                                        )),
                              );
                              add_username();
                            },
                            child: Icon(
                              CupertinoIcons.arrow_right_circle_fill,
                              color: Colors.black.withOpacity(0.7),
                            )
                            // Text(
                            //   'Login',
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w600,
                            //       fontSize: 14,
                            //       fontFamily: 'Roboto'),
                            // ),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]));
  }
}
