import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/routes/app_routes.dart';
import 'package:shopping_app/utils/constants.dart';
import 'package:shopping_app/utils/text_lan_common.dart';

import '../../utils/rounded_button.dart';
import '../../controller/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController fisrtName = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();
  final TextEditingController phoneOrEmail = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextLanCommon(Constants.registerText),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(
                height: 25,
              ),

              Container(
                height: 55,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child:   TextField(
                  controller: fisrtName,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: Constants.firstNameText
                  ),

                ),
              ),
              const SizedBox(height: 25,),

              Container(
                height: 55,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child:   TextField(
                  controller: phoneOrEmail,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: Constants.emailTextInput
                  ),

                ),
              ),
              const SizedBox(height: 25,),


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
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: Constants.passwordTextInput,
                  ),
                ),
              ),

              RoundedButton(
                colour: Colors.lightBlueAccent,
                title: 'Sign Up',
                onPressed: () {
                  if(fisrtName.text.isNotEmpty && phoneOrEmail.text.isNotEmpty && passwordEditingController.text.isNotEmpty) {
                    if (AuthController.instance.isEmailVerified(
                        phoneOrEmail.text)) {
                      AuthController.instance.register(
                          phoneOrEmail.text, passwordEditingController.text).then((value) => {
                        if(value.additionalUserInfo != null){
                          AuthController.instance.saveUserInfoToFirebase(value.user),
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

            ],
          ),
        ),
      ),
    );
  }
}