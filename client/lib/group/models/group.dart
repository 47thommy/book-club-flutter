import 'package:client/user/models/user.dart';

class Group {
  int? id;
  String? name;
  String? description;
  User? creator;
  // List<Role>? roles;

  Group({this.id, this.name, this.description, this.creator});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      creator:
          json.containsKey('creator') ? User.fromJson(json['creator']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    if (id != null) map['id'] = id;
    if (name != null) map['name'] = name;
    if (description != null) map['description'] = description;
    if (creator != null) map['creator'] = creator?.toMap();

    return map;
  }

  @override
  String toString() {
    return "Group : {$id, $name}";
  }
}
