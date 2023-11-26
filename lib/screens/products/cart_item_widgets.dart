import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/controller/cart_controller.dart';
import 'package:shopping_app/utils/text_lan_common.dart';

import '../../model/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel cartItem;

  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: [
        Padding(
          padding:
          const EdgeInsets.all(8.0),
          child: Image.network(
            cartItem.image!,
            width: 80,
          ),
        ),
        Expanded(
            child: Wrap(
              direction: Axis.vertical,
              children: [
                Container(
                    padding: EdgeInsets.only(left: 14),
                    child: TextLanCommon(
                      cartItem.name!,
                    )),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: const Icon(
                            Icons.chevron_left),
                        onPressed: () {
                          CartController.instance.decreaseQuantity(cartItem);
                        }),
                    Padding(
                      padding:
                      const EdgeInsets.all(
                          8.0),
                      child: TextLanCommon(
                        cartItem.quantity.toString(),
                      ),
                    ),
                    IconButton(
                        icon: const Icon(Icons
                            .chevron_right),
                        onPressed: () {
                          CartController.instance.increaseQuantity(cartItem);
                        }),
                  ],
                )
              ],
            )),


        Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.all(14),
              child: TextLanCommon(
                "\u{20B9}${cartItem.cost}",
                style: const TextStyle(fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            
            InkWell(
                onTap: (){
                  CartController.instance.removeCartItem(cartItem);
                },
                child: TextLanCommon("Remove",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                )
            )
          ],
        )
      ],
    );
  }
}