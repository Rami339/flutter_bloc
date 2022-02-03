class Character {
  Character({
      bool? status, 
      String? msg, 
      List<Data>? data,}){
    _status = status;
    _msg = msg;
    _data = data;
}

  Character.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _msg;
  List<Data>? _data;

  bool? get status => _status;
  String? get msg => _msg;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      int? id, 
      Name? name, 
      String? icon, 
      String? image, 
      String? slug, 
      int? status, 
      int? top, 
      dynamic createdAt, 
      dynamic updatedAt, 
      String? title, 
      String? imge,}){
    _id = id;
    _name = name;
    _icon = icon;
    _image = image;
    _slug = slug;
    _status = status;
    _top = top;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _title = title;
    _imge = imge;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'] != null ? Name.fromJson(json['name']) : null;
    _icon = json['icon'];
    _image = json['image'];
    _slug = json['slug'];
    _status = json['status'];
    _top = json['top'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _title = json['title'];
    _imge = json['imge'];
  }
  int? _id;
  Name? _name;
  String? _icon;
  String? _image;
  String? _slug;
  int? _status;
  int? _top;
  dynamic _createdAt;
  dynamic _updatedAt;
  String? _title;
  String? _imge;

  int? get id => _id;
  Name? get name => _name;
  String? get icon => _icon;
  String? get image => _image;
  String? get slug => _slug;
  int? get status => _status;
  int? get top => _top;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  String? get title => _title;
  String? get imge => _imge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_name != null) {
      map['name'] = _name?.toJson();
    }
    map['icon'] = _icon;
    map['image'] = _image;
    map['slug'] = _slug;
    map['status'] = _status;
    map['top'] = _top;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['title'] = _title;
    map['imge'] = _imge;
    return map;
  }

}

class Name {
  Name({
      String? ar, 
      String? en,}){
    _ar = ar;
    _en = en;
}

  Name.fromJson(dynamic json) {
    _ar = json['ar'];
    _en = json['en'];
  }
  String? _ar;
  String? _en;

  String? get ar => _ar;
  String? get en => _en;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ar'] = _ar;
    map['en'] = _en;
    return map;
  }

}