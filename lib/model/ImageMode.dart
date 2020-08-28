class ImageModel {
  int resCode;
  String resMessage;
  ResData resData;

  ImageModel({this.resCode, this.resMessage, this.resData});

  ImageModel.fromJson(Map<String, dynamic> json) {
    resCode = json['res_code'];
    resMessage = json['res_message'];
    resData = json['res_data'] != null
        ? new ResData.fromJson(json['res_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['res_code'] = this.resCode;
    data['res_message'] = this.resMessage;
    if (this.resData != null) {
      data['res_data'] = this.resData.toJson();
    }
    return data;
  }
}

class ResData {
  List<ImageDetails> imageDetails;

  ResData({this.imageDetails});

  ResData.fromJson(Map<String, dynamic> json) {
    if (json['image_details'] != null) {
      imageDetails = new List<ImageDetails>();
      json['image_details'].forEach((v) {
        imageDetails.add(new ImageDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.imageDetails != null) {
      data['image_details'] = this.imageDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageDetails {
  String posterId;
  String festivalId;
  String imageName;
  String imagePath;
  String createdDate;
  String updatedDate;

  ImageDetails(
      {this.posterId,
        this.festivalId,
        this.imageName,
        this.imagePath,
        this.createdDate,
        this.updatedDate});

  ImageDetails.fromJson(Map<String, dynamic> json) {
    posterId = json['poster_id'];
    festivalId = json['festival_id'];
    imageName = json['image_name'];
    imagePath = json['image_path'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poster_id'] = this.posterId;
    data['festival_id'] = this.festivalId;
    data['image_name'] = this.imageName;
    data['image_path'] = this.imagePath;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    return data;
  }
}