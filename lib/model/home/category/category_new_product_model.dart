class CategoryNewProductModel {
  int id;
  String name;
  double price;
  String image;
  double rating;
  int review;
  String description;
  String summary;

  CategoryNewProductModel(
      {this.id,
      this.name,
      this.price,
      this.image,
      this.rating,
      this.review,
      this.description,
      this.summary});

  CategoryNewProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'].toDouble();
    image = json['imagePath'];
    description = json['description'];
    summary = json['summary'];
    rating = json['rating'].toDouble();
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['imagePath'] = this.image;
    data['description'] = this.description;
    data['summary'] = this.summary;
    data['rating'] = this.rating;
    data['review'] = this.review;
    return data;
  }
}
