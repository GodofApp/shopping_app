

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/routes/app_routes.dart';
import 'package:shopping_app/utils/text_lan_common.dart';

import '../../model/products_model.dart';

class SingleProductWidget extends StatelessWidget {
  final ProductModel product;

  const SingleProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed(Routes.DETAIL,arguments: product);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.5),
                  offset: Offset(3, 2),
                  blurRadius: 7)
            ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    product.image!,
                    width: Get.width,
                  )),
            ),
            TextLanCommon(
              product.name!,fontWeight: FontWeight.bold,fontSize: 18,
            ),
            TextLanCommon(
              product.brand!,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextLanCommon(
                    "\u{20B9}${product.price}",
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                /*IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      cartController.addProductToCart(product);
                    })*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
