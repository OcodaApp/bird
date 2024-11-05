class MapCitiesListModel {
  List<MapCities>? mapcity;
  MapCitiesListModel({
    this.mapcity,
  });

  MapCitiesListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      mapcity = <MapCities>[];
      json['data'].forEach((v) {
        mapcity?.add( MapCities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};

    if (mapcity != null) {
      data['data'] = mapcity?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MapCities {
  String? description, placeId;

  MapCities({this.description, this.placeId});

  MapCities.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    placeId = json['placeId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['description'] = description;
    data['placeId'] = placeId;
    return data;
  }
}
