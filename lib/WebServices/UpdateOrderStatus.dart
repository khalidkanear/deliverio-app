import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../Constants.dart';



class UpdateOrderStatus{

  int? status;
  bool? cashCollected;

  Response<String> _responseStatusUpdate = Response();


  UpdateOrderStatus({
    this.status,
    this.cashCollected,
  });


  Future<Map<String,dynamic>> statusUpadateReq() async {



    Dio dioStatus = Dio();


    debugPrint("Accept Order Service : $orderId");
    debugPrint("Accept Order Service : $riderId");


    try {

      dioStatus.options.headers["Authorization"] = "Bearer $bearerToken";

      _responseStatusUpdate = await dioStatus.put(

        "$baseUrl/api/OrdersApi/UpdateDeliveryStatus",

        data: {
          "riderId": int.parse(riderId.toString()),
          "orderId": int.parse(orderId.toString()),
          "deliveryStatus": status,
          "cashCollected": cashCollected
        },


        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return int.parse('$status') < 500;
            }),



      );



      return {"response": _responseStatusUpdate.data, "status": _responseStatusUpdate.statusCode};


    }on DioError catch(error){



      if(error.message.contains("101")){

        return {"response":"Please turn on Wifi or Mobile Data", "status": 101 };
      }
      else if(error.message.contains("110")){

        return {"response":"Poor Internet, Please try again", "status": 110 };

      }


    }

throw PlatformException(code: '404',message: 'PlatformException');

  }


}


