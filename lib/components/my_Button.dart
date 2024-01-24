import 'package:flutter/material.dart';
class MyButton extends StatelessWidget {
  String text;
  VoidCallback onTap;
  bool loading;

  MyButton({super.key,required this.text,required this.onTap,this.loading=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(child: loading?CircularProgressIndicator(strokeWidth: 2,color: Colors.white,) :Text(text)),
      ),
    );
  }
}
