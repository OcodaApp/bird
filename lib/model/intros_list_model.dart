class IntrosListModel {
  List<Intros>? intros;
  IntrosListModel({
    this.intros,
  });

  IntrosListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      intros = <Intros>[];
      json['data'].forEach((v) {
        intros?.add( Intros.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};

    if (intros != null) {
      data['data'] = intros?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Intros {
  String? title, desc, cover;
  Intros({this.title, this.desc, this.cover});
  Intros.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['title'] = title;
    data['desc'] = desc;
    data['cover'] = cover;
    return data;
  }
}
