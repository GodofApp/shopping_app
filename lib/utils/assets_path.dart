final String imageAssetsRoot = "images/";
final String logo = _getImagePath("shopping_cart.png");

String _getImagePath(String fileName){
  return imageAssetsRoot + fileName;
}