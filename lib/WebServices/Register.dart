import 'package:flutter/services.dart';

import '../Screens/Profile/Model/ProfileModel.dart';
import 'package:dio/dio.dart';
import '/Constants.dart';

/// SEND HTTPS REQUEST WITH FILES
/// SEND HTTPS REQUEST WITH FILES
/// SEND HTTPS REQUEST WITH FILES

Future<Map<String, dynamic>> sendRegistrationRequest(
  ProfileModel profile,
  String password,
) async {
  Response<String> response;

  Dio dio = Dio();
  print("${profile.profileImage}    +++++++++++++++");

  FormData data = FormData.fromMap({
    "profileImage": await MultipartFile.fromFile('${profile.profileImage}'),
    "licenceUrl": await MultipartFile.fromFile('${profile.licenceUrl}'),
    "nricUrl": await MultipartFile.fromFile('${profile.nricUrl}'),
    "rider": {
      "id": 0,
      "firstName": profile.firstName,
      "lastName": profile.lastName,
      "profileImage": "testing",
      "address": profile.address,
      "phoneNumber": profile.phoneNo,
      "email": profile.email,
      "nric": profile.nric,
      "password": password,
      "licenceNumber": profile.licenceNo,
      "bankAccountNumber": profile.bankAccountNo,
      "riderType": 2,
    },
    "vehicle": {
      "id": 0,
      "make": profile.vehicle?.make,
      "model": profile.vehicle?.model,
      "regNumber": profile.vehicle?.regNo,
      "vehicleType": 2,
    }
  });

  print(data.fields.toString());

  try {
    response = await dio.post(
      "$baseUrl/api/RidersApi/RegisterMobilityRider",
      data: data,
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
    throw PlatformException(code: '404',message: 'PlatformEception');
  }
}
