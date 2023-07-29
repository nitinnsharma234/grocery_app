import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocery_app/login_flow/loginProvider.dart';
import 'package:grocery_app/login_flow/login_screnn.dart';
import 'package:grocery_app/login_flow/registration_screen.dart';
import 'package:grocery_app/screens/edit_pref_screen.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/utils/appData.dart';
import 'package:grocery_app/welcom-screen.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

late FirebaseDatabase database;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if(FirebaseAuth.instance.currentUser!=null){
    var data=await LoginViewModel().getUserInfo(FirebaseAuth.instance.currentUser?.uid);
    AppData().user=data.data;
  }
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
    MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.pink,
        primaryColor: Colors.pinkAccent,

      ),
      home:FirebaseAuth.instance.currentUser!=null?HomeScreen(user:AppData().user ,):const WelcomeScreen(),
      routes:
        {
          EditPrefScreen.route: (context) => const EditPrefScreen(),
          RegistrationScreen.route: (context) => const RegistrationScreen(),
        }
    );
  }
}








