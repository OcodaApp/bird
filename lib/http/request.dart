// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:convert';
import '../src/controller/lang_controller.dart';
import 'package:get/get.dart';
import '../http/url.dart';
import 'package:http/http.dart' as http;
import '../utility/General.dart';

class Request {
  final String url;
  dynamic body;

  Request({required this.url, required this.body});
  final LangController _langController = Get.put(LangController());

   Future post() async {
    var req = await http.post(Uri.parse(urlBase + url), body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
      "Accept-Language": _langController.appLocale,
      // ignore: missing_return
    });
    print(req.body);
    final int statusCode = req.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      return null;
    } else {
      var body = json.decode(req.body);
      return body;
    }
  }

   Future postAuth() async {
    var req = await http.post(Uri.parse(urlBase + url), body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
      "Accept-Language": _langController.appLocale,
      // "Authorization": General.token,
      // ignore: missing_return
    });
    print(req.body);
    final int statusCode = req.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      return null;
    } else {
      var body = json.decode(req.body);
      return body;
    }
  }
  Future get() async {
    var req = await http.get(Uri.parse(urlBase + url), headers: {
      "Accept-Language": _langController.appLocale,
      "Content-Type": "application/json",
    });
    final int statusCode = req.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      return null;
    } else {
      var body = json.decode(req.body);
      return body;
    }
  }

   Future getAuth() async {
    var req = await http.get(Uri.parse(urlBase + url), headers: {
      "Content-Type": "application/json",
      "Accept-Language": _langController.appLocale,
      // "Authorization": General.token,
    });
    final int statusCode = req.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      return null;
    } else {
      var body = json.decode(req.body);
      return body;
    }
  }
}
