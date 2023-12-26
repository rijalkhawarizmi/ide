class ModelData {
  String? bannerName;
  String? bannerImage;
  bool? isActive;

  ModelData({this.bannerName, this.bannerImage, this.isActive});

  ModelData.fromJson(Map<String, dynamic> json) {
    bannerName = json['banner_name'];
    bannerImage = json['banner_image'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_name'] = this.bannerName;
    data['banner_image'] = this.bannerImage;
    data['is_active'] = this.isActive;
    return data;
  }
}
