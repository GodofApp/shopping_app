

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/utils/constants.dart';
import 'package:shopping_app/utils/text_lan_common.dart';

import '../../routes/app_routes.dart';
import '../../utils/rounded_button.dart';
import '../../controller/auth_controller.dart';

class LoginPage extends StatelessWidget {
  TextEditingController phoneMailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextLanCommon("Login",color: Colors.black,),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Text(
              Constants.emailText,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(
              height: 25,
            ),

            Container(
              height: 55,
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child:  TextField(
                controller: phoneMailEditingController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  counterText: "",
                  border: InputBorder.none,
                  hintText: "Email",
                ),
                maxLength: 30,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            Container(
              height: 55,
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius:  BorderRadius.circular(10)),
              child:   TextField(
                controller: passwordEditingController,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                RoundedButton(
                  colour: Colors.lightBlueAccent,
                  title: Constants.loginText,
                  onPressed: () {
                    if(phoneMailEditingController.text.isNotEmpty && passwordEditingController.text.isNotEmpty){
                      if(AuthController.instance.isEmailVerified(phoneMailEditingController.text)){
                        AuthController.instance.login(phoneMailEditingController.text, passwordEditingController.text).then((value) => {
                          if(value.additionalUserInfo != null){
                            AuthController.instance.userModel.bindStream(AuthController.instance.listenToUser()),
                            Get.offAllNamed(Routes.HOME),
                          }
                        });
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter valid email")));
                      }
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fields must not be empty")));
                    }
                  },
                ),

                RoundedButton(
                  colour: Colors.lightBlueAccent,
                  title: Constants.registerText,
                  onPressed: () {
                    Get.toNamed(Routes.REGISTER);
                  },
                ),
              ],
            ),

            RoundedButton(
              colour: Colors.lightBlueAccent,
              title: Constants.loginGoogleText,
              onPressed: () {
                AuthController.instance.signInWithGoogle();
              },
            ),
          ],
        ),
      ),
    );
  }
}
