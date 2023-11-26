

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_app/controller/auth_controller.dart';
import 'package:uuid/uuid.dart';

import '../model/cart_item.dart';
import '../model/products_model.dart';
import '../model/user_model.dart';

class CartController extends GetxController{
  static CartController instance = Get.find();
  RxDouble totalCartPrice = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    ever(AuthController.instance.userModel, changeCartTotalPrice);
  }

  void addProductToCart(ProductModel product) {
    try {
      if (_isItemAlreadyAdded(product)) {
        Get.snackbar("Check your cart", "${product.name} is already added");
      } else {
        String itemId = const Uuid().v1().toString();
        AuthController.instance.updateUserData({
          "cart": FieldValue.arrayUnion([
            {
              "id": itemId,
              "productId": product.id,
              "name": product.name,
              "quantity": 1,
              "price": double.parse(product.price!),
              "image": product.image,
              "cost": double.parse(product.price!)
            }
          ])
        });
        Get.snackbar("Item added", "${product.name} was added to your cart");
      }
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
    }
  }

  void removeCartItem(CartItemModel cartItem) {
    try {
      AuthController.instance.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });
    } catch (e) {
      Get.snackbar("Error", "Cannot remove this item");
    }
  }

  changeCartTotalPrice(UserModel userModel) {
    totalCartPrice.value = 0.0;
    if (userModel.cart!.isNotEmpty) {
      userModel.cart!.forEach((cartItem) {
        totalCartPrice.value += cartItem.cost!;
      });
    }
  }

  bool _isItemAlreadyAdded(ProductModel product) =>
      AuthController.instance.userModel.value.cart!
          .where((item) => item.productId == product.id)
          .isNotEmpty;

  void decreaseQuantity(CartItemModel item){
    if(item.quantity == 1){
      removeCartItem(item);
    }else{
      // removeCartItem(item);
      item.quantity = item.quantity! - 1;
      AuthController.instance.updateQuantity(item.id,item.quantity,item.price);
    }
  }

  void increaseQuantity(CartItemModel item){
     // removeCartItem(item);
    item.quantity = item.quantity! + 1;
    AuthController.instance.updateQuantity(item.id,item.quantity,item.price);
  }
}