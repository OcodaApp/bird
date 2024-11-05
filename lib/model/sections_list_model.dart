class SectionsListModel {
  List<Data>? data;
  SectionsListModel({
    this.data,
  });

  SectionsListModel.fromJson(Map<String, dynamic> json) {
    if (json['sections'] != null) {
      data = <Data>[];
      json['sections'].forEach((v) {
        data?.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};

    if (this.data != null) {
      data['sections'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title,type,icon;

  Data({this.id, this.title, this.icon, this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    icon = json['icon_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['icon'] = icon;
    return data;
  }
}
