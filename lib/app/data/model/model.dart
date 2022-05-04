class MyRegionModel {
  late String code;
  late String name;
  MyRegionModel({
    code,
    name,
  });
  MyRegionModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}

class MyRegionDetailModel {
  late String code;
  late String name;
  MyRegionDetailModel({
    code,
    name,
  });
  MyRegionDetailModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}

class MyUnivModel {
  late String university_name;
  late List major_name;
  MyUnivModel({
    university_name,
    major_name,
  });
  MyUnivModel.fromJson(Map<String, dynamic> json) {
    university_name = json['university_name'];
    major_name = json['major_name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['university_name'] = this.university_name;
    data['major_name'] = this.major_name;
    return data;
  }
}