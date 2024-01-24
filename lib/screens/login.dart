import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Fire_Base_%20Services/phone_number_screen.dart';
import 'package:flutter_firebase/components/my_Button.dart';
import 'package:flutter_firebase/screens/signUp_screen.dart';
import 'package:flutter_firebase/utilities/utiles.dart';

import '../posts/post_screen.dart';

 class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
   bool loading =false;
  final formKey = GlobalKey<FormState>(); // Corrected the type of GlobalKey
  final _auth= FirebaseAuth.instance;
  final emailContoller = TextEditingController();
  final passwordContoller = TextEditingController();

  @override
  void dispose() {
    emailContoller.dispose();
    passwordContoller.dispose();
    super.dispose();
  }

  void logiin(){
    setState(() {
      loading=true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailContoller.text.toString(),
        password: passwordContoller.text.toString()).then((value) {
        Utilities().toasMessage(value.user!.email.toString());
        Navigator.push(context, MaterialPageRoute(builder: (context)=>postScreen()));
        setState(() {
          loading=false;
        });
    }
    ).onError((error, stackTrace){
      Utilities().toasMessage(error.toString());
      setState(() {
        loading=false;
      });
  });
        }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailContoller,
                    decoration: InputDecoration(
                      hintText: 'email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.teal),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordContoller,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'password',
                      prefixIcon: const Icon(Icons.password_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              text: 'Login', // Corrected the button text
              loading: loading,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  logiin();
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                }, child: Text('Sign up ',style: TextStyle(color: Colors.blue),))
              ],
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneNumberScreen()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.black
                    )
                ),
                child: Center(child: Text('Login using phone number')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
