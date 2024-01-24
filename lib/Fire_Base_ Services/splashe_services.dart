
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/posts/post_screen.dart';
import 'package:flutter_firebase/screens/login.dart';

class SplashServices{
  void isLogin(BuildContext context){
    final _auth= FirebaseAuth.instance;
    final user =_auth.currentUser;
    if(user!=null){
      Timer(Duration(seconds: 3), () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>postScreen()));
      });
    }
    else{
      Timer(Duration(seconds: 3), () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>RegistrationScreen()));
      });
    }
  }
}