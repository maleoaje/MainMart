class FlashsaleModel {
  int id;
  String name;
  double price;
  String image;
  double discount;
  String description;
  String summary;

  FlashsaleModel({
    this.id,
    this.name,
    this.price,
    this.image,
    this.discount,
    this.description,
    this.summary,
  });

  FlashsaleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'].toDouble();
    image = json['imagePath'];
    discount = json['markup'];
    description = json['description'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['imagePath'] = this.image;
    data['markup'] = this.discount;
    data['description'] = this.description;
    data['summary'] = this.summary;
    return data;
  }
}
