class CouponsListModel {
  List<Coupon>? coupon;
  CouponsListModel({
    this.coupon,
  });

  CouponsListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      coupon = <Coupon>[];
      json['data'].forEach((v) {
        coupon?.add(Coupon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (coupon != null) {
      data['data'] = coupon?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coupon {
  int? id,active,max,min,sale;
  String? title,desc,status,fnish,type,couponId;

  Coupon({
    required this.id,
    required this.active,
    required this.max,
    required this.min,
    required this.sale,
    required this.title,
    required this.desc,
    required this.status,
    required this.fnish,
    required this.type,
    required this.couponId,
  });

  Coupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    max = json['max_price'];
    min = json['min_order'];
    sale = json['coupon_value'];
    title = json['name'].toString();
    desc = json['desc'].toString();
    status = json['status'].toString();
    fnish = json['fnish_date'].toString();
    type = json['type'].toString();
    couponId = json['coupon_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['active'] = active;
    data['max'] = max;
    data['min'] = min;
    data['sale'] = sale;
    data['title'] = title;
    data['desc'] = desc;
    data['status'] = status;
    data['fnish'] = fnish;
    data['type'] = type;
    data['couponId'] = couponId;
    return data;
  }
}
