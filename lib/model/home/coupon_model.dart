class CouponModel {
  int id;
  String name;
  String day;
  String term;

  CouponModel({this.id, this.name, this.day, this.term});

  CouponModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    day = json['day'];
    term = json['term'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['day'] = this.day;
    data['term'] = this.term;
    return data;
  }
}