// ignore_for_file: prefer_typing_uninitialized_variables

class ChatListModel {
  List<Chats>? chats;
  ChatListModel({
    this.chats,
  });

  ChatListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      chats = <Chats>[];
      json['data'].forEach((v) {
        chats?.add(  Chats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (chats != null) {
      data['data'] = chats?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chats {
  int? id, userId, orderId;
  String? body, dateString, image, title, type,bodyType;

  Chats({
    this.id,
    this.body,
    this.dateString,
    this.userId,
    this.image,
    this.title,
    this.orderId,
    this.type,
    this.bodyType,
  });

  Chats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    type = json['type'].toString();
    body = json['body'].toString();
    bodyType = json['body_type'].toString();
    dateString = json['date_string'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['body'] = body;
    data['type'] = type;
    data['dateString'] = dateString;
    data['orderId'] = orderId;
    data['bodyType'] = bodyType;
    return data;
  }
}
