class LastSeenModel {
  int id;
  String name;
  double price;
  String image;
  double rating;
  int review;
  int sale;
  String location;

  LastSeenModel(
      {this.id,
      this.name,
      this.price,
      this.image,
      this.rating,
      this.review,
      this.sale,
      this.location});

  LastSeenModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'].toDouble();
    image = json['imagePath'];
    rating = json['rating'].toDouble();
    review = json['review'];
    sale = json['sale'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['imagePath'] = this.image;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['sale'] = this.sale;
    data['location'] = this.location;
    return data;
  }
}
