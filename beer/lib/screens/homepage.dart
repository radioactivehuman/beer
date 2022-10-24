// import 'dart:html';
import 'dart:ui';
import 'dart:io' as i;

import 'package:beer/screens/chatscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final _mybox = Hive.box('username');
  final _profpic = Hive.box('picture');
  final ImagePicker _picker = ImagePicker();

  i.File? _image;
  i.File? isimage;

  Future pickImage() async {
    final _image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_image == null) return;
    dynamic imageTemp = i.File(_image.path);
    setState(() => this.isimage = imageTemp);
    _profpic.put('profilepic', this.isimage);
  }
  // Future pickimage() async {
  //   final _Image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (_Image != null) {
  //     setState(() {
  //       final imagtemp = i.File(_Image.path);
  //       isimage = imagtemp;
  //     });
  //   } else {
  //     print('no files selected');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                  onPressed: () {
                    pickImage();
                  },
                  icon: Icon(CupertinoIcons.add)),
            ),
            Container(
                alignment: Alignment.center,
                height: 300,
                width: 300,
                color: Colors.black.withOpacity(0.3),
                child:
                    // _profpic.get('profilepic') != null
                    // ? Image.file(_profpic.get('profilepic'))
                    Text(_mybox.get('username'))

                // Image.file(_profpic.get('profilepic'))
                //
                //isimage != null
                //     ? Image.file(
                //         isimage!,
                //         width: 100,
                //         height: 100,
                //         fit: BoxFit.fitHeight,
                //       )
                //     : Text('imageFile is null'),
                )
          ],
        ),
      )),
    );
  }
}
