class ReviewModel {
  int id;
  String name;
  String date;
  double rating;
  String review;

  ReviewModel({this.id, this.name, this.date, this.rating, this.review});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    rating = json['rating'].toDouble();
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date'] = this.date;
    data['rating'] = this.rating;
    data['review'] = this.review;
    return data;
  }
}