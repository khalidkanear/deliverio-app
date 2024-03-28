
import 'package:dio/dio.dart';
import '../Constants.dart';



class AlertRider{

  String? id;

  Response<String> _responseLogin = Response();


  AlertRider({
    this.id,
  });


  Future<Map<String,dynamic>> sendLoginReq() async {




    Dio dioLogin = Dio();



    print(id);

    _responseLogin = await dioLogin.post(

      "$baseUrl/api/RidersApi/AlertRidersForNewOrder/",

      data: { "orderId": 7,  },



      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return int.parse('$status') < 500;
          }),

    );




    return {"response": _responseLogin.data, "status": _responseLogin.statusCode};



  }


}


