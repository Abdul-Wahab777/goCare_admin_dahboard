import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';
import 'package:thinkcreative_technologies/Screens/initialization/adminapp.dart';

import '../../Configs/NumberLimits.dart';
import '../../Widgets/InputBox.dart';
import '../bottomnavbar/BottomNavBarAdminApp.dart';

class AdminLogin extends StatefulWidget {
  var doc;
   AdminLogin({super.key,this.doc});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/app_logo/applogo.png",
            width: MediaQuery.of(context).size.width * 0.4,
          ),
          InpuTextBox(
            title: 'Admin Email',
            titleColor: Colors.white,
            hinttext: 'Enter your email',
            autovalidate: true,
            controller: _emailController,
            keyboardtype: TextInputType.emailAddress,
            inputFormatter: [
              LengthLimitingTextInputFormatter(Numberlimits.adminfullname),
            ],
            // onSaved: (val) {
            //   fullname = val;
            // },
            isboldinput: true,
            validator: (val) {
              if (val!.isEmpty || val == "") {
                return "Enter valid email";
              }
              // if (val!.trim().length < 1) {
              //   return 'Enter your fullname';
              // } else if (val.trim().length >
              //     Numberlimits.adminfullname) {
              //   return 'Max. ${Numberlimits.adminfullname} characters allowed';
              // } else {
              //   return null;
              // }
            },
          ),
          InpuTextBox(
            obscuretext: true,
            title: 'Password',
            titleColor: Colors.white,
            hinttext: 'Enter password',
            autovalidate: true,
            keyboardtype: TextInputType.number,
            controller: _passwordController,
            // inputFormatter: [
            //   LengthLimitingTextInputFormatter(
            //       Numberlimits.adminpin),
            //   FilteringTextInputFormatter.allow(
            //     RegExp("[0-9]"),
            //   ),
            // ],
            // onSaved: (val) {
            //   pin = val;
            // },
            isboldinput: true,
            validator: (val) {
              if (val!.isEmpty || val == "") {
                return "Password must be enter";
              }
              // if (val!.trim().length < 1) {
              //   return 'Keep a secret 6-Digit PIN  from 0 to 9';
              // } else if (val.trim().length >
              //     Numberlimits.adminpin) {
              //   return 'Max. ${Numberlimits.adminpin} characters allowed';
              // } else {
              //   return null;
              // }
            },
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 60,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: CupertinoButton(
              minSize: MediaQuery.of(context).size.width,
              color: Colors.red,
              onPressed: () async {
                if (_emailController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Enter Email");
                } else if (_passwordController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Enter password");
                } else {
                  // await  FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password:_passwordController.text).then((value) {
                  //      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyBottomNavBarAdminApp(isFirstTimeSetup: false),)) ;
                  //   });
                  showLoader(context);
                  try {
                    
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim());
                            // log("${userCredential.credential}");
                            if(userCredential!=null){
                              Navigator.pop(context);
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> AdminApp(doc:widget.doc ),)) ;
                            }
                        // if(userCredential!)
                  } on FirebaseAuthException catch (e) {
                                                  Navigator.pop(context);

                    Fluttertoast.showToast(msg: "${e.code}");
                    // if (e.code == 'user-not-found') {
                    //   print('No user found for that email.');
                    // } else if (e.code == 'wrong-password') {
                    //   print('Wrong password provided for that user.');
                    // }
                  }
                }
              },
              child: Text(
                "Login",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
  showLoader(context){
    return showDialog(context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        content: Center(child: CircularProgressIndicator(color: Mycolors.primary),),
      );
    },
    );
  }
}
