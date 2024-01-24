import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/components/my_Button.dart';
import 'package:flutter_firebase/screens/verify_screen.dart';
import 'package:flutter_firebase/utilities/utiles.dart';
class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
   bool loading=false;
  final phoneNumberController=TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
void phoneVerify(){
  setState(() {
    loading = true;
  });
_auth.verifyPhoneNumber(
     phoneNumber:phoneNumberController.text ,
    verificationCompleted: (_){
      setState(() {
        loading = false;
      });
    },
    verificationFailed: (e){
  setState(() {
  loading = false;
  });
       Utilities().toasMessage(e.toString());
    },
    codeSent: (String verificationId, int? token){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyScreen(verificationId: verificationId,)));
       setState(() {
         loading = false;
       });
       },
    codeAutoRetrievalTimeout: (e){
      setState(() {
        loading = false;
      });
      Utilities().toasMessage(e.toString());
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'),backgroundColor: Colors.teal,centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: 'Enter phone number',
              ),
            ),
            SizedBox(height: 40,),
            MyButton(text: 'Login', loading: loading,onTap:(){
              phoneVerify();
            })
          ],
        ),
      ),
    );
  }
}
