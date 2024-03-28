import 'package:flutter/services.dart';

import 'package:dio/dio.dart';
import '/Constants.dart';

/// SEND HTTPS REQUEST WITH FILES
/// SEND HTTPS REQUEST WITH FILES
/// SEND HTTPS REQUEST WITH FILES
Future<Map<String, dynamic>> getVehicleByIdReq(
  int vehicleId,
) async {
  Response<String> response;

  Dio dio = Dio();

  try {
    dio.options.headers["Authorization"] = "Bearer $bearerToken";

    response = await dio.get(
      "$baseUrl/api/VehiclesApi/GetVehicleById/$vehicleId",
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return int.parse('$status') < 500;
          }),
    );

    print(response.data);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return {"response": response.data, "status": response.statusCode};
    } else {
      return {"response": response.data, "status": response.statusCode};
    }
  } on DioError catch (error) {
    if (error.message.contains("101")) {
    } else if (error.message.contains("110")) {}
  }
  throw PlatformException(code: '404',message: 'PlatformEception');

}