class User {
  int? id;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;
  String? tooken;

  User(
      {id,
      name,
      email,
      createdAt,
      updatedAt,
      tooken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tooken = json['tooken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['tooken'] = tooken;
    return data;
  }
}