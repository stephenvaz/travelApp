import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_app/api/network_util.dart';
import 'package:travel_app/utils/MLocalStorage.dart';

class Api {
  NetworkUtil _netUtil = new NetworkUtil();

  //  static var BASE_URL = MLocalStorage().getBaseUrl();
  static var BASE_URL =
  "https://dd15-2402-3a80-1646-8b92-346c-4f9-e9a-bf56.in.ngrok.io";

  static final LOGIN_URL = BASE_URL + "/login";
  static final CREATE_ACC = BASE_URL + "/create_acc";
  static final CREATE_PROFILE = BASE_URL + "/create_profile";
  static final LOGOUT_URL = BASE_URL + "/users/logout";
  static final CHANGE_STATE_URL = BASE_URL + "/game" + "/change_state";
  static final GET_CLUE_FROM_CID = BASE_URL + "/game" + "/get_clue_from_cid";
  static final GET_NEXT_CLUE_URL = BASE_URL + "/game" + "/get_next_clue";
  static final POWERUPS_URL = BASE_URL + "/game" + "/powerups";
  static final GET_HINT = BASE_URL + "/game" + "/get_hint";
  static final ADD_TRIP = BASE_URL + "/add-trip";
  static final CREATE_COMMUNITY = BASE_URL + "/create";
  static final GET_COMMUNITY = BASE_URL + "/get-comm";
  var formData;

  Future<dynamic> login(String email, String password) {
//no do it their side
    formData = FormData.fromMap({"email": email, "password": password});
    print(formData);

    return _netUtil.post(LOGIN_URL, formData).then((dynamic res) {
      print(res.toString());
      return res;
    });
  }

  Future<dynamic> createAccount(
      String name, String phone_number, String email, String password) {
    formData = FormData.fromMap({
      "name": name,
      "phone_number": phone_number,
      "email": email,
      "password": password
    });
    print(formData);

    return _netUtil.post(CREATE_ACC, formData).then((dynamic res) {
      print(res.toString());
      return res;
    });
  }

  Future<dynamic> createProfile(String bio, List<String> interests, String city,
      String dob, String gender, String emergency_phone_number, String imgStr) {
    formData = FormData.fromMap({
      "bio": bio,
      "interests": interests,
      "city": city,
      "dob": dob,
      "gender": gender,
      "emergency_phone_number": emergency_phone_number,
      "profile_photo": imgStr
    });

    return _netUtil.post(CREATE_PROFILE, formData).then((dynamic res) {
      print(res.toString());
      return res;
    });
  }

    Future<dynamic> addTrip(var data) {
    // print('performing post');
    // print(jsonEncode(data));
    formData = FormData.fromMap(data);
    print(formData);
    return _netUtil.post(ADD_TRIP, formData).then((dynamic res) {
      print(res.toString());
      return res;
    });
  }

  Future<dynamic> createCommunity(var data) {
    // print('performing post');
    // print(jsonEncode(data));
    formData = FormData.fromMap(data);
    print(formData);
    return _netUtil.post(CREATE_COMMUNITY, formData).then((dynamic res) {
      print(res.toString());
      return res;
    });
  }

  Future<dynamic> getCommunitites() {
    // print('performing post');
    // print(jsonEncode(data));
    // formData = FormData.fromMap(data);
    print(formData);
    return _netUtil.post(GET_COMMUNITY, formData).then((dynamic res) {
      print(res.toString());
      return res;
    });
  }

  Future<dynamic> signUp(
      String email, String password, List<String> interestArr) {
//no do it their side
    formData = FormData.fromMap({"email": email, "password": password});
    print(formData);

    return _netUtil.post(CREATE_PROFILE, formData).then((dynamic res) {
      print(res.toString());
      return res;
    });
  }

  // Future<dynamic> signUp(
  //     String email, String password, List<String> interestArr) {
  //   formData = FormData.fromMap({"email": email, "password": password});
  //   print(formData);
  //
  //   return _netUtil.post(LOGIN_URL, formData).then((dynamic res) {
  //     print(res.toString());
  //     return res;
  //   });
  // }


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
