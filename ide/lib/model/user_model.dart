class UserModel {
  int? id;
  String? email;
  String? name;
  String? staticToken;
  bool? isActive;
  String? clientId;
  String? clientSecret;
  String? accessToken;

  UserModel(
      {this.id,
      this.email,
      this.name,
      this.staticToken,
      this.isActive,
      this.clientId,
      this.clientSecret,
      this.accessToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    staticToken = json['static_token'];
    isActive = json['is_active'];
    clientId = json['client_id'];
    clientSecret = json['client_secret'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['static_token'] = this.staticToken;
    data['is_active'] = this.isActive;
    data['client_id'] = this.clientId;
    data['client_secret'] = this.clientSecret;
    data['access_token'] = this.accessToken;
    return data;
  }
}
