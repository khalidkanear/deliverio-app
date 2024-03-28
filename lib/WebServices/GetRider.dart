import 'dart:convert';

import 'package:flutter/services.dart';

import '../Screens/Profile/Model/ProfileModel.dart';
import '../WebServices/GetVehicle.dart';
import 'package:dio/dio.dart';
import '/Constants.dart';

/// SEND HTTPS REQUEST WITH FILES
/// SEND HTTPS REQUEST WITH FILES
/// SEND HTTPS REQUEST WITH FILES
Future<Map<String, dynamic>> getRiderByIdReq(
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
      ProfileModel profile;

      print(response.data);
      int vehicleId = jsonDecode(response.data.toString())["vehicleId"];

      profile =  ProfileModel(
        firstName: jsonDecode(response.data.toString())["firstName"].toString(),
        lastName: jsonDecode(response.data.toString())["lastName"].toString(),
        profileImage: jsonDecode(response.data.toString())["imageUrl"].toString(),
        address: jsonDecode(response.data.toString())["address"].toString(),
        phoneNo: jsonDecode(response.data.toString())["phoneNumber"].toString(),
        email: jsonDecode(response.data.toString())["email"].toString(),
        nric: jsonDecode(response.data.toString())["nric"].toString(),
        licenceNo: jsonDecode(response.data.toString())["licenceNumber"].toString(),
        bankAccountNo:
            jsonDecode(response.data.toString())["bankAccountNumber"].toString(),
        riderId: jsonDecode(response.data.toString())["id"].toString(),
        isOnline: jsonDecode(response.data.toString())["isOnline"],
      );

      Map<String, dynamic> responseGetVehicle =
          await getVehicleByIdReq(vehicleId);

      if (responseGetVehicle["status"] == 200) {
        profile.vehicle = Vehicle(
            make:
                jsonDecode(responseGetVehicle["response"])["make"].toString(),
            model:
                jsonDecode(responseGetVehicle["response"])["model"].toString(),
            regNo: jsonDecode(responseGetVehicle["response"])["regNumber"]
                .toString(),
            vehicleId: vehicleId.toString());

        return {"response": profile, "status": 200};
      } else {
        return {"response": profile, "status": 202};
      }
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
