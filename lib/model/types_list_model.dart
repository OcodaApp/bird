class TypesListModel {
  List<Types>? data;
  TypesListModel({
    this.data,
  });

  TypesListModel.fromJson(Map<String, dynamic> json) {
    if (json['types'] != null) {
      data = <Types>[];
      json['types'].forEach((v) {
        data?.add( Types.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};

    if (this.data != null) {
      data['types'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Types {
  int? id;
  String? title,type;

  Types({this.id, this.title, this.type});

  Types.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    return data;
  }
}
