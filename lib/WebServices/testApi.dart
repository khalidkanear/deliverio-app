import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import '../Constants.dart';



class TestApi{


  Response<String> _resChangeStatus = Response();



  Future<Map<String,dynamic>> sendReq() async {
    Dio dioLogin = Dio();


    try {
      dioLogin.options.headers["Authorization"] = "Bearer $bearerToken";




      _resChangeStatus = await dioLogin.post(

        "http://13.76.227.169:8088/wakaf/api/login",

        data : {
          "email":"shoaibmalik2611@gmail.com",
          "password":"kkkkkk19"
        },

        options: Options(
            headers: {"Accept" : "application/json"},
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

        return {"response":"Please turn on Wifi or Mobile Data", "status": 101 };
      }
      else if(error.message.contains("110")){

        return {"response":"Poor Internet, Please try again", "status": 110 };

      }
    }
    throw PlatformException(code: '404',message: 'PlatformEception');


  }


}


