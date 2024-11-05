class ComplainsListModel {
  List<Complain>? complain;
  ComplainsListModel({
    this.complain,
  });

  ComplainsListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      complain = <Complain>[];
      json['data'].forEach((v) {
        complain?.add(Complain.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (complain != null) {
      data['data'] = complain?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Complain {
  int? id;
  String? firstname,lastname,
      phone,email,date,msg;

  Complain({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.date,
    required this.msg,
    required this.phone,
  });

  Complain.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['first_name'].toString();
    lastname = json['last_name'].toString();
    phone = json['phone'].toString();
    email = json['email'].toString();
    msg = json['msg'].toString();
    date = json['date'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['phone'] = phone;
    data['email'] = email;
    data['msg'] = msg;
    data['date'] = date;
    return data;
  }
}
