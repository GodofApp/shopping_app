

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/products/products.dart';
import 'package:shopping_app/screens/products/shopping_cart.dart';
import 'package:shopping_app/utils/constants.dart';
import 'package:shopping_app/utils/text_lan_common.dart';

import '../../controller/auth_controller.dart';
import '../../utils/rounded_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextLanCommon(Constants.productText,fontSize: 24,fontWeight: FontWeight.bold,),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    color: Colors.white,
                    child: ShoppingCartWidget(),
                  ),
                );
              }),
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                AuthController.instance.signOut(context).then((value){
                  Constants.userId = "";
                  Constants.cartValues.clear();
                });
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Container(
          color: Colors.white30,
          child: ProductsWidget(),
        ),
      ),
    );
  }
}
