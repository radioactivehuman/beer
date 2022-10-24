import 'package:beer/screens/chatscreen.dart';
import 'package:beer/screens/homepage.dart';
import 'package:beer/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('picture');
  await Hive.openBox('username');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final _mybox = Hive.box('username');
    final _username = _mybox.get('username');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: chatscreen_(title: 'title')
        // _username != null
        //     ? homepage(username: 'username')
        //     : login_screen()
        );
  }
}
