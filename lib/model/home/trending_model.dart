class HomeTrendingModel {
  int id;
  String name;
  String image;
  String description;
  String summary;

  HomeTrendingModel(
      {this.id, this.name, this.image, this.description, this.summary});

  HomeTrendingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['imagePath'];
    description = json['description'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imagePath'] = this.image;
    data['description'] = this.description;
    data['summary'] = this.summary;
    return data;
  }
}
