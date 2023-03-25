import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Configs/Dbkeys.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Screens/authentication/initialize.dart';
import 'package:thinkcreative_technologies/Screens/splashScreen/SplashScreen.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Mycolors.primary, //or set color with: Color(0xFF0000FF)
  ));
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  binding.renderView.automaticSystemUiAdjustment = false;

  // await Firebase.initializeApp();
  // final appleSignInAvailable = await AppleSignInAvailable.check();
  runApp(AppWrapper());
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({Key? key}) : super(key: key);

  @override
  _AppWrapperState createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  // Locale? _locale;
  // setLocale(Locale locale) {
  //   setState(() {
  //     _locale = locale;
  //   });
  // }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MaterialApp(
                debugShowCheckedModeBanner: false, home: Splashscreen());
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
                future: SharedPreferences.getInstance(),
                builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
                  if (snapshot.hasData) {
                    
                    return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        home: Initialize(
                          app: K11,
                          doc: K9,
                          prefs: snapshot.data!,
                        ));
                  }
                  return MaterialApp(
                      debugShowCheckedModeBanner: false, home: Splashscreen());
                });
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Splashscreen(),
          );
        });
  }
}
