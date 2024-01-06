class ShirtModel {
  int? id;
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

class PantsModel {
  int? id;
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

class ScarfModel {
  int? id;
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
