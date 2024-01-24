import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/login.dart';
import 'package:flutter_firebase/utilities/utiles.dart';
class postScreen extends StatefulWidget {
  const postScreen({super.key});

  @override
  State<postScreen> createState() => _postScreenState();
}

class _postScreenState extends State<postScreen> {
  final _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        title:const Text('Post Screen'),
        actions: [
          IconButton(onPressed: (){
            _auth.signOut().then((value){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
            }).onError((error, stackTrace){
              Utilities().toasMessage(error.toString());
            });
          }, icon:const Icon(Icons.logout,color: Colors.black,))
        ],
      ),
    );
  }
}
