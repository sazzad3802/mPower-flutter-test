class MyApp {
  int? id;
  String? applicantName;
  String? weblink;
  String? linkType;
  String? linkTypeName;
  String? packageName;
  String? applicationType;
  String? applicationTypeName;
  String? paymentType;
  String? paymentTypeName;
  String? serveType;
  String? serviceTypeName;
  String? logoImg;
  String? introduction;
  String? createdBy;
  String? createdUserName;
  String? createdAt;

  MyApp(
      {this.id,
      this.applicantName,
      this.weblink,
      this.linkType,
      this.linkTypeName,
      this.packageName,
      this.applicationType,
      this.applicationTypeName,
      this.paymentType,
      this.paymentTypeName,
      this.serveType,
      this.serviceTypeName,
      this.logoImg,
      this.introduction,
      this.createdBy,
      this.createdUserName,
      this.createdAt});

  MyApp.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    applicantName = json['applicant_name'];
    weblink = json['weblink'];
    linkType = json['link_type'];
    linkTypeName = json['link_type_name'];
    packageName = json['package_name'];
    applicationType = json['application_type'];
    applicationTypeName = json['application_type_name'];
    paymentType = json['payment_type'];
    paymentTypeName = json['payment_type_name'];
    serveType = json['serve_type'];
    serviceTypeName = json['service_type_name'];
    logoImg = json['logo_img'];
    introduction = json['introduction'];
    createdBy = json['created_by'];
    createdUserName = json['created_user_name'];
    createdAt = json['created_at'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['id'] = id;
    data['applicant_name'] = applicantName;
    data['weblink'] = weblink;
    data['link_type'] = linkType;
    data['link_type_name'] = linkTypeName;
    data['package_name'] = packageName;
    data['application_type'] = applicationType;
    data['application_type_name'] = applicationTypeName;
    data['payment_type'] = paymentType;
    data['payment_type_name'] = paymentTypeName;
    data['serve_type'] = serveType;
    data['service_type_name'] = serviceTypeName;
    data['logo_img'] = logoImg;
    data['introduction'] = introduction;
    data['created_by'] = createdBy;
    data['created_user_name'] = createdUserName;
    data['created_at'] = createdAt;
    return data;
  }
}
