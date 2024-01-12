
import 'package:hive_flutter/hive_flutter.dart';
part 'scarf_model.g.dart';
@HiveType(typeId: 3)
class ScarfModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String size;
  ScarfModel({required this.size,this.id});
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
  factory ScarfModel.fromJson(Map<String, dynamic> json) {
    return ScarfModel(
      id:json['id'],
      size: json['size']);
  }

}
