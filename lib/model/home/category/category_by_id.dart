class CategoryByIdModel {
  int id;
  String name;
  double price;
  String image;
  String description;
  String summary;

  CategoryByIdModel(
      {this.id,
      this.name,
      this.price,
      this.image,
      this.description,
      this.summary});

  CategoryByIdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
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
    data['description'] = this.description;
    data['summary'] = this.summary;
    return data;
  }
}
