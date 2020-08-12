import 'dart:async';

import 'package:openemr_app/models/patient.dart';
import 'package:openemr_app/utils/network.dart';
import 'package:openemr_app/models/user.dart';
import 'package:openemr_app/const/strings.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();

  Future<User> login(String username, String password, String url) {
    url = url == null ? "" : url;
    return _netUtil.post(url + loginendpoint, body: {
      "grant_type": "password",
      "username": username,
      "password": password,
      "scope": "default"
    }).then((dynamic res) {
      if (res == null) throw new Exception("Invalid Login Credentials");
      res['username'] = username;
      res['baseUrl'] = url;
      res['password'] = password;
      return new User.map(res);
    });
  }

  Future<List<Patient>> getPatientList(baseUrl, token) {
    print(baseUrl);
    Map<String, String> headers = {"Authorization": token};
    return _netUtil
        .get(baseUrl + patientendpoint, headers: headers)
        .then((dynamic res) {
      if (res == null) throw new Exception("Error fetching data");
      var patientList = new List<Patient>();
      res.forEach((patient) => {patientList.add(Patient.map(patient))});
      return patientList;
    });
  }
}
