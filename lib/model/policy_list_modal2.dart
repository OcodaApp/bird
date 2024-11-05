class PolicyListModel2 {
  List<Policy>? plicy;
  PolicyListModel2({
    this.plicy,
  });

  PolicyListModel2.fromJson(Map<String, dynamic> json) {
    if (json['policy_delegate'] != null) {
      plicy = <Policy>[];
      json['policy_delegate'].forEach((v) {
        plicy?.add( Policy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};

    if (plicy != null) {
      data['policy_delegate'] = plicy?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Policy {
  String? name, desc;
  Policy({this.name, this.desc});
  Policy.fromJson(Map<String, dynamic> json) {
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
