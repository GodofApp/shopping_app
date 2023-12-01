

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/products/products.dart';
import 'package:shopping_app/screens/products/shopping_cart.dart';
import 'package:shopping_app/utils/app_bar.dart';
import 'package:shopping_app/utils/constants.dart';
import 'package:shopping_app/utils/text_lan_common.dart';

import '../../controller/auth_controller.dart';
import '../../utils/rounded_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Constants.productText,showCartIcon: true,),
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
