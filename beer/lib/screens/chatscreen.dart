// ignore: duplicate_ignore
// ignore: unnecessary_import
// ignore_for_file: camel_case_types, unnecessary_import, prefer_const_constructors
// import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_for_web/image_picker_for_web.dart';
// import 'package:image_picker_android/image_picker_android.dart';

class chatscreen_ extends StatefulWidget {
  const chatscreen_({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<chatscreen_> createState() => _chatscreen_State();
}

class _chatscreen_State extends State<chatscreen_> {
  late IO.Socket _socket;
  final _cntrl = TextEditingController();
  // final ImagePicker _picker = ImagePicker();

  List chats_ = [];

  // void connect() {
  //   Socket socket = io('http://localhost:3000/',
  //       OptionBuilder().setTransports(['websocket']).build());
  //   socket.emit('receive_message', _cntrl.text);
  //   socket.on('receive_message', (data) => {print(data), add_message(data)});
  //   socket.connect();
  // }
  connectSocket() {
    _socket.onConnect((data) => print('connected to server'));
    _socket.onDisconnect((data) => print('disconnected'));
    _socket.on('message', (data) {
      setState(() {
        chats_.add({'id': 0, 'text': data, 'time': DateTime.now()});
      });
    });
  }

  _sendMessage() {
    _socket.emit('message', _cntrl.text);
    setState(() {
      chats_.add({'id': 1, 'text': _cntrl.text, 'time': DateTime.now()});
      _cntrl.clear();
    });
  }

  // Future pickimage() async {
  //   final _Image = ImagePicker().pickImage(source: ImageSource.gallery);
  // }

  // add_() {
  //   socket.emit('receive_message', _cntrl.text);
  //   socket.on('receive_message', (data) => {print(data), add_message(data)});
  // }

  @override
  void initState() {
    super.initState();
    _socket = IO.io('http://localhost:3000/',
        IO.OptionBuilder().setTransports(['websocket']).build());
    connectSocket();
  }

  @override
  Widget build(BuildContext context) {
    // add_message(message) {
    //   setState(() {
    //     chats_.add({'id': 1, 'text': message, 'time': DateTime.now()});
    //   });

    //   _cntrl.clear();
    // }

    // chats_.add({'id': 1, 'text': 'message', 'time': DateTime.now()});

    var height_ = MediaQuery.of(context).size.height;
    var width_ = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: -15,
        leadingWidth: 50,
        leading: Icon(Icons.arrow_back_rounded),
        backgroundColor: Colors.white,
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('/images/profile.jpg'),
          ),
          title: Text(
            widget.title,
          ),
        ),
        actions: <Widget>[
          Icon(Icons.more_vert),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: chats_.length,
                    itemBuilder: ((context, index) => Container(
                          padding: chats_[index]['id'] == 0
                              ? EdgeInsets.only(right: 150, top: 2)
                              : EdgeInsets.only(left: 150, top: 2),
                          child: chats_[index]['id'] == 0
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 10, top: 2),
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.indigo.shade50,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          )),
                                      child: Text(
                                        chats_[index]['text'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, right: 10, top: 2),
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 10),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 155, 163, 255),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          )),
                                      child: Text(
                                        chats_[index]['text'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        )))),
            SizedBox(
              child: Container(
                  height: height_ * 0.07,
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    child: ListTile(
                      minLeadingWidth: 1,
                      contentPadding: EdgeInsets.symmetric(horizontal: 1),
                      leading: Icon(
                        CupertinoIcons.camera_fill,
                        color: Colors.blueGrey.shade300,
                      ),
                      title: TextField(
                        controller: _cntrl,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                // pickimage();
                              },
                              icon: Icon(
                                CupertinoIcons.add,
                                color: Colors.blueGrey.shade300,
                              )),
                          suffixIconColor: Colors.blueGrey,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'type a message...',
                        ),
                        cursorColor: Colors.black,
                      ),
                      trailing: IconButton(
                        onPressed: (() {
                          _sendMessage();

                          // connect();
                        }),
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 30,
                          color: Colors.blueGrey.shade300,
                        ),
                      ),
                    ),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

// class chatbox extends StatefulWidget {
//   const chatbox({Key? key}) : super(key: key);

//   @override
//   State<chatbox> createState() => _chatboxState();
// }

// class _chatboxState extends State<chatbox> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.amber,

//     );
//   }
// }

class imagecard extends StatefulWidget {
  const imagecard({Key? key}) : super(key: key);

  @override
  State<imagecard> createState() => _imagecardState();
}

class _imagecardState extends State<imagecard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
