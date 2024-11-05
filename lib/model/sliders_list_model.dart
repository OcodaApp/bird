// ignore_for_file: prefer_typing_uninitialized_variables

class SlidersListModel {
  List<Sliders>? sliders;
  SlidersListModel({
    this.sliders,
  });

  SlidersListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      sliders = <Sliders>[];
      json['data'].forEach((v) {
        sliders?.add( Sliders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};

    if (sliders != null) {
      data['data'] = sliders?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sliders {
  int? id;
  String? type, img,typeId;
  var store;

  Sliders({this.id, this.type, this.img,this.typeId,this.store});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'].toString();
    typeId = json['type_id'].toString();
    img = json['image_url'].toString();
    store = json['store'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['typeId'] = typeId;
    data['img'] = img;
    data['store'] = store;
    return data;
  }
}
