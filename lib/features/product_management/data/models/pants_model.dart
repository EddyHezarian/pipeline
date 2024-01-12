import 'package:hive_flutter/hive_flutter.dart';
part 'pants_model.g.dart';
@HiveType(typeId: 4)
class PantsModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String size;
  PantsModel({required this.size,this.id});
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
  factory PantsModel.fromJson(Map<String, dynamic> json) {
    return PantsModel(
      id:json['id'],
      size: json['size']);
  }

}
