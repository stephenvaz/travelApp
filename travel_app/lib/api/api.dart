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

  Future<dynamic> login(
      String teamId, String password, double curr_lat, double curr_lng) {
    formData = FormData.fromMap({
      "tid": teamId,
      "password": password,
      "curr_lat": curr_lat,
      "curr_lng": curr_lng
    });

    return _netUtil.post(LOGIN_URL, formData).then((dynamic res) {
      print(res.toString());
      return res;
    });
  }

  // Future<dynamic> getClueFromCid(String cid) {
  Future<dynamic> getClueFromCid(String cid) {
    // randomly assign a route number. send route number too
    formData = FormData.fromMap({"cid": cid}); // directly set cid
    return _netUtil.postf(GET_CLUE_FROM_CID, formData).then((dynamic res) {
      print(res.toString());
      return res;
    });
  }

  Future<dynamic> getNextClue(int updatedBal, int newClueNo,
      int milisSinceEpochOfPrevClueSolveTimestamp) {
    formData = FormData.fromMap({
      "tid": "025",
      //this is entailed in bearer token
      "balance": updatedBal,
      "clue_no": newClueNo,
      "prev_clue_solved_timestamp": milisSinceEpochOfPrevClueSolveTimestamp
    });

    return _netUtil.postf(GET_NEXT_CLUE_URL, formData).then((dynamic res) {
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

  Future<dynamic> changeStateToPlaying() {
    return _netUtil
        .postf(CHANGE_STATE_URL, FormData.fromMap({"new_state": "Playing"}))
        .then((dynamic res) {
      print(res.toString());
      final box = GetStorage();
      box.erase();
      return res;
    });
  }

  Future<dynamic> getHint(String cid, int updateBalance) {
    formData = FormData.fromMap({"cid": cid, "updated_balance": updateBalance});
    return _netUtil.postf(GET_HINT, formData).then((dynamic res) {
      return res;
    });
  }
}
