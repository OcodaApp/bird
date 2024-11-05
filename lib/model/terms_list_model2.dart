class TermsListModel2 {
  List<Terms>? terms;
  TermsListModel2({
    this.terms,
  });

  TermsListModel2.fromJson(Map<String, dynamic> json) {
    if (json['terms_delegate'] != null) {
      terms = <Terms>[];
      json['terms_delegate'].forEach((v) {
        terms?.add( Terms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};

    if (terms != null) {
      data['terms_delegate'] = terms?.map((v) => v.toJson()).toList();
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
