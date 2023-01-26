import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/pages/account_register_page.dart';
import 'package:untitled/pages/add_new_moment_page.dart';
import 'package:untitled/pages/chat_page.dart';
import 'package:untitled/pages/contact_page.dart';
import 'package:untitled/pages/conversation_page.dart';
import 'package:untitled/pages/create_new_group_page.dart';
import 'package:untitled/pages/moments_page.dart';
import 'package:untitled/pages/profile_page.dart';
import 'package:untitled/pages/splash_page.dart';
import 'package:firebase_installations/firebase_installations.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var firebaseInstallationId = await FirebaseInstallations.id ?? "Unknown installation id";
  debugPrint("Firebase Installation id ======> $firebaseInstallationId");
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'YorkieDemo',
      ),
      home:  SplashPage(),
    );
  }
}



