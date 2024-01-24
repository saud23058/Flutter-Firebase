
import 'package:flutter/material.dart';
import 'package:flutter_firebase/components/my_Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/utilities/utiles.dart';

import 'login.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>(); // Corrected the type of GlobalKey

  final emailContoller = TextEditingController();
  final passwordContoller = TextEditingController();
  bool loading =false;
  final FirebaseAuth _auth= FirebaseAuth.instance;

  @override
  void dispose() {
    emailContoller.dispose();
    passwordContoller.dispose();
    super.dispose();
  }

  void signup(){
    setState(() {
      loading=true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailContoller.text.toString(),
        password: passwordContoller.text.toString()
    ).then((value){
      setState(() {
        loading=false;
      });
    }).onError((error, stackTrace) {
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
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Sign up',
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

              text: 'Sign up',
              loading: loading,
              onTap: () {
                if (formKey.currentState!.validate()) {
                 signup();
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account"),
                TextButton(onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>RegistrationScreen()));
                }, child: const Text('Login ',style: TextStyle(color: Colors.blue),))
              ],
            ),

          ],
        ),
      ),
    );
  }
}
