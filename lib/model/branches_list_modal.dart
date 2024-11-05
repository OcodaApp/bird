class BranchesListModel {
  List<Branche>? branche;
  BranchesListModel({
    this.branche,
  });

  BranchesListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      branche = <Branche>[];
      json['data'].forEach((v) {
        branche?.add(Branche.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (branche != null) {
      data['data'] = branche?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Branche {
  int? id;
  String? title,
      phone,
      latitude,
      longitude;

  Branche({
    required this.id,
    required this.title,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });

  Branche.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    phone = json['phone'].toString();
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['phone'] = phone;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
