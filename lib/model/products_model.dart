

class ProductModel{
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const BRAND = "brand";
  static const PRICE = "price";
  static const DESC = "description";

  String? id;
  String? image;
  String? name;
  String? brand;
  String? price;
  String? description;

  ProductModel({this.id, this.image, this.name, this.brand, this.price, this.description});

  ProductModel.fromMap(Map<String, dynamic> data){
    id = data[ID];
    image = data[IMAGE];
    name = data[NAME];
    brand = data[BRAND];
    price = data[PRICE];
    description = data[DESC];
  }
}