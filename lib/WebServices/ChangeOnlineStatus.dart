import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../Constants.dart';
import '../string.dart';



class ChangeOnlineStatus{


  Response<String> _resChangeStatus = Response(requestOptions: RequestOptions(path: ''));



  Future<Map<String,dynamic>> changeStatusReq() async {
    Dio dioLogin = Dio();


    try {
      dioLogin.options.headers["Authorization"] = "Bearer $bearerToken";

      _resChangeStatus = await dioLogin.post(

        "$baseUrl/api/RidersApi/ChangeOnlineStatus?riderId=$riderId",


        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return int.parse('$status') < 500;
            }),

      );




      return {
        "response": _resChangeStatus.data,
        "status": _resChangeStatus.statusCode
      };



    } on DioError catch (error) {


      if(error.message.contains("101")){

        return {"response": english ? "Please turn on Wifi or Mobile Data" : m["Please turn on Wifi or Mobile Data"], "status": 101 };
      }
      else if(error.message.contains("110")){

        return {"response":"Poor Internet, Please try again", "status": 110 };

      }
    }

throw PlatformException(code:'404',message: 'Error Ocurred');

  }



}


