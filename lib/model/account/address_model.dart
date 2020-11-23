class AddressModel {
  int id;
  String title;
  String recipientName;
  String phoneNumber;
  String addressLine1;
  String addressLine2;
  String state;
  String postalCode;
  bool defaultAddress;

  AddressModel({this.id, this.title, this.recipientName, this.phoneNumber, this.addressLine1, this.addressLine2, this.state, this.postalCode, this.defaultAddress});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    recipientName = json['recipientName'];
    phoneNumber = json['phoneNumber'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    state = json['state'];
    postalCode = json['postalCode'];
    defaultAddress = json['defaultAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['recipientName'] = this.recipientName;
    data['phoneNumber'] = this.phoneNumber;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['state'] = this.state;
    data['postalCode'] = this.postalCode;
    data['defaultAddress'] = this.defaultAddress;
    return data;
  }
}