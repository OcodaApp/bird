// ignore_for_file: file_names, implementation_imports
import 'dart:convert';
import 'package:google_place/google_place.dart';
import 'package:google_place/src/utils/network_utility.dart';
import 'package:get/get.dart';
import '../../../../model/map_cities_list_model.dart';
import '../../../controller/lang_controller.dart';

class SeaConController extends GetxController {
  final LangController _langController = Get.put(LangController());
  List predictions = [].obs;
  var citiesListData = <MapCities>[].obs;
  var googlePlace = GooglePlace("AIzaSyATuEq0qRHi33CVV_q9_RwuQ6JRm7C0fWY");
  late DetailsResult detailsResult;

  chacngeData(word) async {
    const authority = 'maps.googleapis.com';
    const unencodedPath = 'maps/api/place/autocomplete/json';
    var queryParameters = {
      'input': word,
      'key': "AIzaSyATuEq0qRHi33CVV_q9_RwuQ6JRm7C0fWY",
      'language': _langController.appLocale,
    };
    var uri = Uri.https(authority, unencodedPath, queryParameters);
    var response = await NetworkUtility.fetchUrl(uri);
    if(response != null){
      var data = json.decode(response);
      
    if (data != null && data['predictions'] != null) {
      predictions = data['predictions'];
    }
    }
    return predictions;
  }

  void getDetils(String placeId) async {
    var result = await googlePlace.details.get(
          placeId,
          language: _langController.appLocale,
        );
    if (result != null && result.result != null) {
      detailsResult = result.result!;

      // Locations().setlatitude(double.parse(detailsResult.geometry!.viewport!.southwest!.lat.toString()));
      // Locations().setlongitude(double.parse(detailsResult.geometry!.viewport!.southwest!.lng.toString()));
      // Locations().setcityName(
      //   result.result!.name!,
      // );
      // Locations().setcityNameApp(
      //   result.result!.name!,
      // );

      // Locations().getLocationsData().then((value) {
      //   Get.back();
      //   Get.back();
      // });
    }
  }

  Future<List<double>?> getLatLong(String placeId) async {
    var result = await googlePlace.details.get(
          placeId,
          language: _langController.appLocale,
        );
    if (result != null && result.result != null) {
      detailsResult = result.result!;
      return [double.parse(detailsResult.geometry!.viewport!.southwest!.lat.toString()),double.parse(detailsResult.geometry!.viewport!.southwest!.lng.toString())];
    }else{
      return null;
    }
  }
}
