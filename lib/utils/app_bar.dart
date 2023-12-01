import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/utils/text_lan_common.dart';

import '../controller/auth_controller.dart';
import '../screens/products/shopping_cart.dart';
import 'constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final bool showCartIcon;

  const CustomAppBar({super.key, required this.title, required this.showCartIcon});

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextLanCommon(title,fontSize: 24,fontWeight: FontWeight.bold,),
      backgroundColor: Colors.blue,
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0,
      actions: [
        Visibility(
          visible: showCartIcon,
          child: IconButton(
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
        ),
        IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              AuthController.instance.signOut(context).then((value){
                Constants.userId = "";
                Constants.cartValues.clear();
              });
            }),
      ],
    );
  }


}
