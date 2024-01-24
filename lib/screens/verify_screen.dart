import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/components/my_Button.dart';
import 'package:flutter_firebase/screens/verify_screen.dart';
import 'package:flutter_firebase/utilities/utiles.dart';

import '../posts/post_screen.dart';
class VerifyScreen extends StatefulWidget {
 final String verificationId;
 VerifyScreen({super.key,required this.verificationId});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {

  bool loading=false;
  final phoneNumberController=TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify'),backgroundColor: Colors.teal,centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: '6 digit code',
              ),
            ),
            SizedBox(height: 40,),
            MyButton(text: 'verify', loading: loading,onTap:()async {
              setState(() {
                loading=true;
              });
            final credential = PhoneAuthProvider.credential(
              verificationId:widget.verificationId ,
              smsCode: phoneNumberController.text.toString()
            );
            try{
              await _auth.signInWithCredential(credential);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>postScreen()));
            }catch(e){
              setState(() {
                loading=true;
              });
              Utilities().toasMessage(e.toString());
            }
            })
          ],
        ),
      ),
    );
  }
}
