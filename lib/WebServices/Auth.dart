import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '/Constants.dart';

class Authenticate {
   String? id;
   String? pass;
   Response<String> responseAuth;
  Authenticate( this.id, this.pass, this.responseAuth);



  Dio dioAuth = Dio();

  Future<Map<String, dynamic>> getAuthToken() async {
    String token;
    print(id);
    print(pass);
    try {
      responseAuth = await dioAuth.post(
        "$baseUrl/authenticate",
        data: {"username": id, "password": pass, "check": 1},
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return int.parse('$status') < 500;
            }),
      );

      if (responseAuth.statusCode == 200) {
        token = json.decode(responseAuth.data.toString())["jwt"];
        print("Auth Status Code : ${responseAuth.statusCode}");
        return {"authResponse": token, "status": 200};
      } else if (responseAuth.statusCode == 302) {
        token = "Error 302";
        return {"authResponse": token, "status": 302};
      }
    } on DioError catch (error) {
      print(
          "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
      print("Auth Service Error : ${error.message}");
      if (error.message.contains("101")) {
        return {"authResponse": error, "status": 101};
      } else if (error.message.contains("110")) {
        return {"authResponse": error, "status": 110};
      }
    }
    throw PlatformException(code: '404',message: 'Error Occurred');
  }

}
