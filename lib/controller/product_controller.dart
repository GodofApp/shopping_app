

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/products_model.dart';

class ProductController extends GetxController{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static ProductController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  String collection = "products";

  RxBool isLoading = true.obs;

  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
  }

  Stream<List<ProductModel>> getAllProducts() =>
      firebaseFirestore.collection(collection).snapshots().map((query) {
        isLoading.value = false;
        return query.docs.map((item) {
          return ProductModel.fromMap(item.data());
        }).toList();
      });

}

