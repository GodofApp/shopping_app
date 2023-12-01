

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shopping_app/controller/product_controller.dart';
import 'package:shopping_app/model/products_model.dart';
import 'package:shopping_app/screens/products/single_product.dart';
import 'package:shopping_app/utils/load_skeleton.dart';

class ProductsWidget extends StatelessWidget {

  ProductController productController = Get.put(ProductController());

  ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(()=> productController.isLoading.value ?
         Center(child: GridView.builder(
           itemCount: 10,
           padding: const EdgeInsets.all(10),
           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisCount: 2, // Number of columns
             mainAxisSpacing: 4.0,
             crossAxisSpacing: 10,
             childAspectRatio: .70,
         ), itemBuilder: (context,index){
           return const LoadingSkeleton();
         }))
        : GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: .70,
        padding: const EdgeInsets.all(10),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 10,
        children: productController.products.map((ProductModel product) {
          return SingleProductWidget(product: product,);
          // return LoadingSkeleton();
        }).toList())
    );
  }
}
