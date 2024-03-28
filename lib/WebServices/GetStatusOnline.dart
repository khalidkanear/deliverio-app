import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';

/// SEND HTTPS REQUEST WITH FILES
/// SEND HTTPS REQUEST WITH FILES
/// SEND HTTPS REQUEST WITH FILES
Future<Map<String, dynamic>> getStatusOnlineReq(
  int riderId,
) async {
  Response<String> response;

  Dio dio = Dio();

  try {
    dio.options.headers["Authorization"] = "Bearer $bearerToken";

    response = await dio.get(
      "$baseUrl/api/RidersApi/GetRiderById/$riderId",
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return int.parse('$status') < 500;
          }),
    );

    print(response.data);
    print(response.statusCode);

    if (response.statusCode == 200) {
      if (jsonDecode(response.data.toString())["isOnRide"]) {
        SharedPreferences pref = await SharedPreferences.getInstance();

        var order = jsonDecode(response.data.toString())["orderInProcess"];

        print(order);

        pref.setString("orderDetails", order.toString());

        pref.setString("orderId", order["id"].toString());

        orderDetailGlobal = jsonEncode(order);
        orderId = order["id"].toString();

        return {
          "response": jsonDecode(response.data.toString())["isOnline"],
          "status": 201
        };
      } else {
        return {
          "response": jsonDecode(response.data.toString())["isOnline"],
          "status": 200
        };
      }

      // return {
      //   "response" : jsonDecode(response.data)["isOnline"],
      //   "status" : 200
      // };

    } else {
      return {"response": response.data, "status": response.statusCode};
    }
  } on DioError catch (error) {
    if (error.message.contains("101")) {
      return {"response": "Please turn on Wifi or Mobile Data", "status": 101};
    } else if (error.message.contains("110")) {
      return {"response": "No Internet", "status": 110};
    }
    throw PlatformException(code: '404',message: 'PlatformEception');
  }
}
