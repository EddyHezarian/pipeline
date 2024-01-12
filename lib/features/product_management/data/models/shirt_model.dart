import 'package:hive_flutter/hive_flutter.dart';
part 'shirt_model.g.dart';
@HiveType(typeId: 2)
class ShirtModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String size;
  ShirtModel({required this.size,this.id});
    Map<String, dynamic> toMap() {
    return {
      'size': size,
    };
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size'] = size;
    return data;
    }
    
//! from json 
  factory ShirtModel.fromJson(Map<String, dynamic> json) {
    return ShirtModel(
      id:json['id'],
      size: json['size']);
  }

}
