import 'package:hive/hive.dart';

part 'brand_model.g.dart';

@HiveType(typeId: 1)
class BrandModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String name;
  BrandModel({required this.name, this.id});
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
    return BrandModel(id: json['id'], name: json['name']);
  }
}
