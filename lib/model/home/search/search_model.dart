class SearchModel {
  int id;
  String words;

  SearchModel({this.id, this.words});

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    words = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.words;
    return data;
  }
}
