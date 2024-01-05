class BrandModel {
   int? cid;
  String name;
  BrandModel({required this.name , this.cid});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    return data;
    }
    
//! from json 
  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      cid:json['id'],
      name: json['name']);
  }
}
