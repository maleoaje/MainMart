class OrderListModel {
  int id;
  String invoice;
  String date;
  String status;
  String name;
  String image;
  double payment;

  OrderListModel(
      {this.id,
      this.invoice,
      this.date,
      this.status,
      this.name,
      this.image,
      this.payment});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoice = json['invoice'];
    date = json['date'];
    status = json['status'];
    name = json['name'];
    image = json['imagePath'];
    payment = json['payment'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice'] = this.invoice;
    data['date'] = this.date;
    data['status'] = this.status;
    data['name'] = this.name;
    data['imagePath'] = this.image;
    data['payment'] = this.payment;
    return data;
  }
}
