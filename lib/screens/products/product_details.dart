

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shopping_app/controller/cart_controller.dart';
import 'package:shopping_app/utils/rounded_button.dart';

import '../../controller/auth_controller.dart';
import '../../model/products_model.dart';
import '../../utils/constants.dart';
import '../../utils/text_lan_common.dart';

class ProductDetails extends StatelessWidget {

  late ProductModel product;

  ProductDetails({super.key}){
    product = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextLanCommon(Constants.productDetailsText,fontSize: 24,fontWeight: FontWeight.bold,),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.network(
                  product.image!,
                  fit: BoxFit.fill,
                  height: 300,
                  width: Get.width,
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextLanCommon(
                            "Name : ",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          TextLanCommon(
                            product.name!,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ],
                      ),

                      SizedBox(height: Constants.textPadding,),

                      Row(
                        children: [
                          TextLanCommon(
                            "Price : ",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          TextLanCommon(
                            "\u{20B9} ${product.price!}",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ],
                      ),

                      SizedBox(height: Constants.textPadding,),

                      Row(
                        children: [
                          TextLanCommon(
                            "Brand : ",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          TextLanCommon(
                            product.brand!,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ],
                      ),

                      SizedBox(height: Constants.textPadding,),

                      TextLanCommon(product.description!,textAlign: TextAlign.justify,
                          style: const TextStyle(height: 1.5, color: Color(0xFF6F8398))),
                    ],
                  ),
                ),
              ],
            ),
          ),

          InkWell(
            onTap: (){
              CartController.instance.addProductToCart(product);
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: Get.width,
                  height: 50,
                color: Colors.blue,
                alignment: Alignment.center,
                child: TextLanCommon(
                  Constants.cartText,
                  style: TextStyle(height: 1.5, color: Colors.white,fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
