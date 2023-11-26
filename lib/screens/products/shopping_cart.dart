

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/controller/auth_controller.dart';
import 'package:shopping_app/controller/cart_controller.dart';
import 'package:shopping_app/utils/text_lan_common.dart';

import '../../model/cart_item.dart';
import 'cart_item_widgets.dart';

class ShoppingCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: TextLanCommon(
                "Shopping Cart",
                style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            Obx(() => ListView.builder(
              shrinkWrap: true,
              itemCount: AuthController.instance.userModel.value.cart!.length,
              itemBuilder: (context, index) {
                CartItemModel cartItem = AuthController.instance.userModel.value.cart!.elementAt(index);
                return CartItemWidget(cartItem: cartItem);
              },))
          ],
        ),
        Positioned(
            bottom: 0,
            child: Container(
                width: Get.width,
                height: 50,
                color: Colors.blue,
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                child: Obx(() => TextLanCommon("Pay (\u{20B9}${CartController.instance.totalCartPrice.value.toStringAsFixed(2)})",
                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),)
            ))
      ],
    );
  }
}