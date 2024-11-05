class AddressListModel {
  List<Address>? address;
  AddressListModel({
    this.address,
  });

  AddressListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      address = <Address>[];
      json['data'].forEach((v) {
        address?.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (address != null) {
      data['data'] = address?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  int? id;
  String? title,
      city,
      street,
      building,
      addressText,
      latitude,
      longitude,
      flat,
      floor,
      defult;

  Address({
    required this.id,
    required this.title,
    required this.addressText,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.flat,
    required this.floor,
    required this.defult,
    required this.building,
    required this.street,
  });

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['location_name'].toString();
    addressText = json['addres_text'].toString();
    city = json['city'].toString();
    street = json['street'].toString();
    building = json['building'].toString();
    floor = json['floor'].toString();
    flat = json['flat'].toString();
    defult = json['static'].toString();
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['addressText'] = addressText;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['street'] = street;
    data['building'] = building;
    data['floor'] = floor;
    data['city'] = city;
    data['flat'] = flat;
    data['defult'] = defult;
    return data;
  }
}
