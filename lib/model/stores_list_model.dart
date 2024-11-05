class StoresListModel {
  List<Stores>? data;

  StoresListModel({
    this.data,
  });

  StoresListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Stores>[];
      json['data'].forEach((v) {
        data?.add(Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stores {
  int? id, rateCount, userFav;
  String? name, type, cover, desc, logo, fromTime, toTime, time, delevryPrice;
  double? lat, long, km;
  double? kmPrice, rateAvg;

  Stores({
    this.id,
    this.rateAvg,
    this.rateCount,
    this.userFav,
    this.name,
    this.type,
    this.cover,
    this.logo,
    this.km,
    this.fromTime,
    this.toTime,
    this.time,
    this.delevryPrice,
    this.lat,
    this.long,
    this.kmPrice,
  });

  Stores.fromJson(Map<String, dynamic> json) {

    try{
      id = json['id'];
      rateCount = json['rate_count'];
      userFav = json['user_fav'];
      // string
      name = json['name'].toString();
      desc = json['desc'].toString();
      type = json['type'].toString();
      cover = json['cover_url'].toString();
      logo = json['logo_url'].toString();
      fromTime = json['from_time_string'].toString();
      toTime = json['to_time_string'].toString();
      time = json['preparation_time'].toString();

      // doblue
      km = double.parse(json['distance'].toString());
      lat = double.parse(json['latitude'].toString());
      long = double.parse(json['longitude'].toString());
      kmPrice = double.parse(json['km_price'].toString());
      rateAvg = double.parse(json['rate_avg'].toString());

      delevryPrice = json['distance']!=null&&json['km_price']!=null?(double.parse(json['km_price'].toString()) *
          double.parse(json['distance'].toString()))
          .toStringAsFixed(2):null;
    }catch(error){

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rateAvg'] = rateAvg;
    data['rateCount'] = rateCount;
    data['userFav'] = userFav;

    data['name'] = name;
    data['desc'] = desc;
    data['type'] = type;
    data['cover'] = cover;
    data['logo'] = logo;
    data['fromTime'] = fromTime;
    data['toTime'] = toTime;
    data['time'] = time;
    data['delevryPrice'] = delevryPrice;
    data['kmPrice'] = kmPrice;
    data['km'] = km;
    data['lat'] = lat;
    data['long'] = long;

    return data;
  }
}
