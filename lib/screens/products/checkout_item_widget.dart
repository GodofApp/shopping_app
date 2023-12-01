

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controller/cart_controller.dart';
import '../../model/cart_item.dart';
import '../../utils/text_lan_common.dart';

class CheckoutItemWidget extends StatelessWidget {

  final CartItemModel cartItem;

  const CheckoutItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xfff8f8f9),
            borderRadius: BorderRadius.circular(16),
            boxShadow:  const [
              BoxShadow(
                  color: Color(0x26000000),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 0)
            ]),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Padding(
              padding:
              const EdgeInsets.all(8.0),
              child: Image.network(
                cartItem.image!,
                width: 80,
                fit: BoxFit.fitHeight,
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
