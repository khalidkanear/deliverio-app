import 'package:flutter/services.dart';

import '/Screens/Profile/Model/ProfileModel.dart';
import 'package:dio/dio.dart';
import '/Constants.dart';

/// SEND HTTPS REQUEST WITH FILES
/// SEND HTTPS REQUEST WITH FILES
/// SEND HTTPS REQUEST WITH FILES
Future<Map<String, dynamic>> sendEditProfileReq(
  ProfileModel? profile,
) async {
  Response<String> response;

  Dio dio = Dio();

  FormData data = FormData.fromMap({
    "ProfileImage": await MultipartFile.fromFile('${profile?.profileImage}'),
    "id": int.parse('${profile?.riderId}'),
    "firstName": profile?.firstName,
    "lastName": profile?.lastName,
    "address": profile?.address,
    "phoneNumber": profile?.phoneNo,
    "nric": profile?.nric,
    "licenceNumber": profile?.licenceNo,
    "bankAccountNumber": profile?.bankAccountNo,
  });

  try {
    dio.options.headers["Authorization"] = "Bearer $bearerToken";

    response = await dio.put(
      "$baseUrl/api/RidersApi/EditRider",
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
    throw PlatformException(code:'404',message:'Error Occured');
  }
}
