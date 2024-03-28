import 'package:flutter/services.dart';

import '/Screens/Profile/Model/ProfileModel.dart';
import 'package:dio/dio.dart';
import '/Constants.dart';

/// SEND HTTPS REQUEST WITH FILES
/// SEND HTTPS REQUEST WITH FILES
/// SEND HTTPS REQUEST WITH FILES
Future<Map<String, dynamic>> sendEditVehicleReq(ProfileModel? profile) async {
  Response<String> response;

  Dio dio = Dio();

  try {
    dio.options.headers["Authorization"] = "Bearer $bearerToken";

    response = await dio.put(
      "$baseUrl/api/VehiclesApi/EditVehicle",
      data: {
        "id": int.parse('${profile?.vehicle?.vehicleId}'),
        "make": '${profile?.vehicle?.make}',
        "model": '${profile?.vehicle?.model}',
        "regNumber": '${profile?.vehicle?.regNo}',
        "vehicleType": 2,
        "riderId": int.parse('${profile?.riderId}'),
        "franchiseId": null,
      },
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
      return {"response": "Please turn on Wifi or Mobile Data", "status": 101};
    } else if (error.message.contains("110")) {
      return {"response": "Poor Internet, Please try again", "status": 110};
    }
    throw PlatformException(code: '404',message: 'Platform Exception');
  }
}
