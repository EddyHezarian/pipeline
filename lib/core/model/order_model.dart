class OrderModel {
  int? id;
  String customerName;
  String customerPhone;
  int purchase;
  String brandName;
  DateTime createdAt;
  String description;
  String status;
  String shirtSize;
  String scarfSize;
  String pantsSize;
  int shirtQTY;
  int scarfQTY;
  int pantsQTY;

  OrderModel({
    this.id,
    required this.customerName,
    required this.customerPhone,
    required this.brandName,
    required this.purchase,
    required this.status,
    required this.description,
    required this.createdAt,
    required this.shirtSize,
    required this.shirtQTY,
    required this.pantsSize,
    required this.pantsQTY,
    required this.scarfSize,
    required this.scarfQTY,
  });

  Map<String, dynamic> toMap() {
    return {
  
      'date': createdAt.toIso8601String(),
      'name': customerName,
      'phone': customerPhone,
      'purchase': purchase,
      'status': status,
      'brand_name': brandName,
      'shirt': shirtSize,
      'shirtQTY': shirtQTY,
      'pants': pantsSize,
      'pantsQTY': pantsQTY,
      'scarf': scarfSize,
      'scarfQTY': scarfQTY,
      'description': description
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = createdAt;
    data['name'] = customerName;
    data['phone'] = customerPhone;
    data['purchase'] = purchase;
    data['status'] = status;
    data['brand_name'] = brandName;
    data['shirt'] = shirtSize;
    data['shirtQTY'] = shirtQTY;
    data['pants'] = pantsSize;
    data['pantsQTY'] = pantsQTY;
    data['scarf'] = scarfSize;
    data['scarfQTY'] = scarfQTY;
    data['description'] = description;
    return data;
  }

//! from json
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json['id'],
        customerName: json['name'],
        customerPhone: json['phone'],
        brandName: json['brand_name'],
        purchase: json['purchase'],
        status: json['status'],
        description: json['description'],
        createdAt: json['date'],
        shirtSize: json['shirt'],
        shirtQTY: json['shirtQTY'],
        pantsSize: json['pants'],
        pantsQTY: json['pantsQTY'],
        scarfSize: json['scarf'],
        scarfQTY: json['scarfQTY']);
  }
}
