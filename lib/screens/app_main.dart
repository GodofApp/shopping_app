

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/login/login_page.dart';
import 'package:shopping_app/screens/products/home_page.dart';
import 'package:shopping_app/utils/assets_path.dart';

class AppMain extends StatelessWidget {
  const AppMain({super.key});

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset(logo, width: 120,)),
          SizedBox(height: 10,),
          CircularProgressIndicator(color: Colors.blue,)
        ],
      ),
    );*/
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return HomePage();
          }else{
            return LoginPage();
          }
        });
  }
}
