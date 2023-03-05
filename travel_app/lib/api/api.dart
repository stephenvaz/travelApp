import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_app/api/network_util.dart';
import 'package:travel_app/components/community.dart';
import 'package:travel_app/utils/MLocalStorage.dart';

class Api {
  NetworkUtil _netUtil = new NetworkUtil();

  //  static var BASE_URL = MLocalStorage().getBaseUrl();
  static var BASE_URL =
      "https://eff7-2409-40c0-c-5392-1cd4-d7f6-7a73-826.in.ngrok.io";

  static final LOGIN_URL = BASE_URL + "/login";
  static final CREATE_ACC = BASE_URL + "/create_acc";
  // static final CREATE_PROFILE = BASE_URL + "/create_profile";
  static final CREATE_PROFILE = BASE_URL + "/profile";
  static final LOGOUT_URL = BASE_URL + "/users/logout";
  static final CHANGE_STATE_URL = BASE_URL + "/game" + "/change_state";
  static final GET_CLUE_FROM_CID = BASE_URL + "/game" + "/get_clue_from_cid";
  static final GET_NEXT_CLUE_URL = BASE_URL + "/game" + "/get_next_clue";
  static final POWERUPS_URL = BASE_URL + "/game" + "/powerups";
  static final GET_HINT = BASE_URL + "/game" + "/get_hint";
  static final ADD_TRIP = BASE_URL + "/add-trip";
  static final CREATE_COMMUNITY = BASE_URL + "/create";
  static final GET_COMMUNITY = BASE_URL + "/get-comm";
  static final NEARBY = BASE_URL + "/get-nearby";
  static final SEND = BASE_URL + "/friend_req_send";
  static final RECVREQ = BASE_URL + "/get_recv_list";
  static final ACCEPT = BASE_URL + "/friend_req_accept";
  static final REJECT = BASE_URL + "/friend_remove";
  static final PEND = BASE_URL + "/get_pending_list";
  static final TRIP = BASE_URL + "/get-trips";

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

  Future<dynamic> pending(String email) {
//no do it their side
    formData = FormData.fromMap({"email": email});
    print(formData);

    return _netUtil.post(PEND, formData).then((dynamic res) {
      print(res.toString());
      return res;
    });
  }

  Future<dynamic> recvreq(String email) {
//no do it their side
    formData = FormData.fromMap({"email": email});
    print(formData);

    return _netUtil.post(RECVREQ, formData).then((dynamic res) {
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

  Future<dynamic> createProfile(
      String bio,
      List<String> interests,
      String city,
      String dob,
      String gender,
      List<String> emergency_phone_number,
      String imgStr) {
    formData = FormData.fromMap({
      "email": MLocalStorage().getEmailId(),
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
    print('performing post');
    // print(jsonEncode(data));
    // formData = FormData.fromMap({"email": data});
    formData = FormData.fromMap(data);
    print(formData);
    return _netUtil.post(CREATE_COMMUNITY, formData).then((dynamic res) {
      print(res.toString());
      return res;
    });
  }

  Future<dynamic> getNearby(String email) {
    print('performing post');
    // print(jsonEncode(data));
    formData = FormData.fromMap({"email": email});
    // formData = FormData.fromMap(data);
    // print(formData);
    return _netUtil.post(NEARBY, formData).then((dynamic res) {
      // print(res.toString());
      print(res);
      return res;
    });
  }

  Future<dynamic> send(String e1, String e2) {
    formData = FormData.fromMap({"to": e1, "from": e2});
    return _netUtil.post(SEND, formData).then((dynamic res) {
      // print(res.toString());
      print(res);
      return res;
    });
  }

  Future<dynamic> accept(String e1, String e2) {
    formData = FormData.fromMap({"target": e1, "user": e2});
    return _netUtil.post(ACCEPT, formData).then((dynamic res) {
      // print(res.toString());
      print(res);
      return res;
    });
  }

  Future<dynamic> reject(String e1, String e2) {
    formData = FormData.fromMap({"target": e1, "user": e2});
    return _netUtil.post(REJECT, formData).then((dynamic res) {
      // print(res.toString());
      print(res);
      return res;
    });
  }

  Future<dynamic> trips(String email) {
    // print('performing post');
    // print(jsonEncode(data));
    formData = FormData.fromMap({"email": email});
    print(formData);
    return _netUtil.post(TRIP, formData).then((dynamic res) {
      print(res.toString());
      return res;
    });
  }

  Future<dynamic> getCommunitites(String email) {
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
