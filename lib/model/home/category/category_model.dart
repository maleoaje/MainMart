import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ijshopflutter/config/constants.dart';

class CategoryModel {
  int id;
  String name;

  CategoryModel({
    this.id,
    this.name,
  });

  Icon getIcon(String name) {
    IconData iconData = Icons.local_mall;
    Color iconColor = Colors.orange;

    if (name == 'agriculture') {
      iconData = Icons.agriculture;
      iconColor = Colors.lightGreen;
    } else if (name == 'home and office') {
      iconData = Icons.home;
      iconColor = CHARCOAL;
    } else if (name == 'babies kids and toys') {
      iconData = Icons.child_care;
      iconColor = Colors.blueGrey[300];
    } else if (name == 'gaming') {
      iconData = Icons.games;
      iconColor = Color(0xFF0a4349);
    } else if (name == 'phones and tablets') {
      iconData = Icons.smartphone;
      iconColor = SOFT_BLUE;
    } else if (name == 'supermarket') {
      iconData = Icons.shop;
      iconColor = Colors.red[700];
    } else if (name == 'fashion') {
      iconData = Icons.local_mall;
      iconColor = Colors.blueGrey[600];
    } else if (name == 'electronics') {
      iconData = Icons.tv;
      iconColor = Colors.amber;
    } else if (name == 'health and beauty') {
      iconData = Icons.shopping_bag;
      iconColor = Colors.deepPurple;
    } else if (name == 'sporting goods') {
      iconData = Icons.sports_soccer;
      iconColor = Colors.greenAccent;
    } else if (name == 'computing') {
      iconData = Icons.computer;
      iconColor = Colors.lightBlue;
    } else if (name == 'automobile') {
      iconData = Icons.car_repair;
      iconColor = Colors.red;
    } else if (name == 'other category') {
      iconData = Icons.shopping_basket;
      iconColor = Colors.black;
    }

    return Icon(iconData, size: 40, color: iconColor);
  }

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }
}
