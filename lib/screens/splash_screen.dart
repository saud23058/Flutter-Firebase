import 'package:flutter/material.dart';
import 'package:flutter_firebase/Fire_Base_%20Services/splashe_services.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  SplashServices splashServices=SplashServices();
  void initState() {
    super.initState();
    splashServices.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Loading......')),
    );
  }
}
