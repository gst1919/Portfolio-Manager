import 'package:flutter/material.dart';
import 'package:PM/login.dart';
import 'package:PM/Screen1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'ForgotPassword.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final storage = new FlutterSecureStorage();
  Future<bool> checkLoginStatus() async{
    String? value = await storage.read(key: "uid");
    if(value == null){
      return false;
    }
    return true;
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FutureBuilder(
      future: checkLoginStatus(),
      builder:(BuildContext context, AsyncSnapshot<bool> snapshot){
        if(snapshot.data == false){
          return MyLogin();
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Container(
            color: Colors.white,
              child: Center(child: CircularProgressIndicator()
              )
          );
        }
        return FirstScreen();
      },
    ),
    routes: {
      'login': (context) => MyLogin(),
      'screen1': (context) => FirstScreen(),
      'reset': (context) => Reset(),
    },
  ));
}






