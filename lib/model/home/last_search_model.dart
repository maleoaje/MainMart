class LastSearchModel {
  int id;
  String name;
  double price;
  String image;
  String description;
  String summary;

  LastSearchModel(
      {this.id,
      this.name,
      this.price,
      this.image,
      this.description,
      this.summary});

  LastSearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'].toDouble();
    image = json['imagePath'];
    description = json['description'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['imagePath'] = this.image;
    data['description'] = this.image;
    data['summary'] = this.summary;
    return data;
  }
}
