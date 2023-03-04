import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_app/api/network_util.dart';
import 'package:travel_app/utils/MLocalStorage.dart';

class Api {
  NetworkUtil _netUtil = new NetworkUtil();

  static var BASE_URL = MLocalStorage().getBaseUrl();

  static final LOGIN_URL = BASE_URL + "/login";
  static final LOGOUT_URL = BASE_URL + "/users/logout";
  static final CHANGE_STATE_URL = BASE_URL + "/game" + "/change_state";
  static final GET_CLUE_FROM_CID = BASE_URL + "/game" + "/get_clue_from_cid";
  static final GET_NEXT_CLUE_URL = BASE_URL + "/game" + "/get_next_clue";
  static final POWERUPS_URL = BASE_URL + "/game" + "/powerups";
  static final GET_HINT = BASE_URL + "/game" + "/get_hint";
  var formData;

  Future<dynamic> login(String email, String password) {
//no do it their side
    formData = FormData.fromMap({
      "email": email,
      "password": password
    });
    print(formData);

    return _netUtil.post(LOGIN_URL, formData).then((dynamic res) {
      print(res.toString());
      return res;
    });
  }

  Future<dynamic> signUp(String email, String password, List<String> interestArr) {
//no do it their side
    formData = FormData.fromMap({
      "email": email,
      "password": password
    });
    print(formData);

    return _netUtil.post(LOGIN_URL, formData).then((dynamic res) {
      print(res.toString());
      return res;
    });
  }


  Future<dynamic> logout({logout_loc_lat = "-999", logout_loc_lng = "-999"}) {
    return _netUtil
        .postf(
            LOGOUT_URL,
            FormData.fromMap({
              "logout_loc_lat": logout_loc_lat,
              "logout_loc_lng": logout_loc_lng
            }))
        .then((dynamic res) {
      print(res.toString());
      final box = GetStorage();
      box.erase();
      final tet = box.read("markers_stored");
      return res;
    });
  }
}
