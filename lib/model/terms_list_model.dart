class TermsListModel {
  List<Terms>? terms;
  TermsListModel({
    this.terms,
  });

  TermsListModel.fromJson(Map<String, dynamic> json) {
    if (json['terms_user'] != null) {
      terms = <Terms>[];
      json['terms_user'].forEach((v) {
        terms?.add( Terms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};

    if (terms != null) {
      data['terms_user'] = terms?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Terms {
  String? name, desc;
  Terms({this.name, this.desc});
  Terms.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['desc'] = desc;
    return data;
  }
}
