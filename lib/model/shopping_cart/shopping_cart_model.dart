class ShoppingCartModel {
  int id;
  String name;
  String image;
  double price;
  int qty;

  ShoppingCartModel({this.id, this.image, this.name, this.price, this.qty});

  void setQty(int i) {
    if (i < 1) {
      qty = 1;
    } else {
      qty = i;
    }
  }
}
