

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shopping_app/controller/cart_controller.dart';
import 'package:shopping_app/screens/products/checkout_item_widget.dart';

import '../../controller/auth_controller.dart';
import '../../model/cart_item.dart';
import '../../utils/app_bar.dart';
import '../../utils/constants.dart';
import '../../utils/text_lan_common.dart';
import 'cart_item_widgets.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: Constants.checkoutText,showCartIcon: false,),
        body: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: 10,
                ),

                Obx(() => ListView.builder(
                  shrinkWrap: true,
                  itemCount: AuthController.instance.userModel.value.cart!.length,
                  itemBuilder: (context, index) {
                    CartItemModel cartItem = AuthController.instance.userModel.value.cart!.elementAt(index);
                    return CheckoutItemWidget(cartItem: cartItem);
                  },))
              ],
            ),
            Positioned(
                bottom: 0,
                child: InkWell(
                  onTap: (){

                  },
                  child: Container(
                    width: Get.width,
                    height: 50,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8),
                    child: Obx(() => TextLanCommon("Pay total (\$${CartController.instance.totalCartPrice.value.toStringAsFixed(2)})",
                      style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    )),
                  ),
                ))
          ],
        ),
    );
  }
}
