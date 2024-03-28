
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Constants.dart';



class LoginRequest{

  String ?id;
  String? pass;


  Response<String> _responseLogin = Response();


  LoginRequest({
    this.id,
    this.pass,
  });


  Future<Map<String,dynamic>> sendLoginReq() async {



    await Firebase.initializeApp();

    String? tokenNotification = await FirebaseMessaging.instance.getToken();

    debugPrint("+====================+");
    debugPrint(tokenNotification);
    debugPrint("+====================+");


    Dio dioLogin = Dio();


      try{


        _responseLogin = await dioLogin.post(

          "$baseUrl/LoginUser",

          data: { "username": id, "password": pass , "deviceAddress": tokenNotification , "rememberMe": true  },



          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return int.parse('$status') < 500;
              }),

        );


        return {"response": _responseLogin.data, "status": _responseLogin.statusCode};



      }on DioError catch (error) {


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


