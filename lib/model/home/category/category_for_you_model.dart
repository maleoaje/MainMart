import 'package:ijshopflutter/config/constants.dart';

class CategoryForYouModel {
  int id;
  String image;

  CategoryForYouModel({this.id, this.image});

  CategoryForYouModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}

List<CategoryForYouModel> categoryForYouData =[
  CategoryForYouModel(
    id: 7,
    image: GLOBAL_URL+'/assets/images/category_for_you/1.jpg',
  ),
  CategoryForYouModel(
    id: 3,
    image: GLOBAL_URL+'/assets/images/category_for_you/2.jpg'
  ),
  CategoryForYouModel(
    id: 5,
    image: GLOBAL_URL+'/assets/images/category_for_you/3.jpg'
  ),
  CategoryForYouModel(
    id: 2,
    image: GLOBAL_URL+'/assets/images/category_for_you/4.jpg'
  ),
  CategoryForYouModel(
    id: 8,
    image: GLOBAL_URL+'/assets/images/category_for_you/5.jpg'
  ),
];