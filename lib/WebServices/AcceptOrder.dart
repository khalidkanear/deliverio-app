import 'package:dio/dio.dart';
import '../Constants.dart';



class AcceptOrder{



  Response<String> _responseAcceptOrder = Response(requestOptions: RequestOptions(path: ''));



  Future<Map<String,dynamic>> orderAcceptReq() async {



    Dio acceptOrder = Dio();


    print("Accept Order Service : " '$orderId');
    print("Accept Order Service : " '$riderId');


    acceptOrder.options.headers["Authorization"] = "Bearer $bearerToken";

    accepted = true ;

    _responseAcceptOrder = await acceptOrder.post(

      "$baseUrl/api/OrdersApi/AssignOrderToRider",

      data: { "orderId": int.parse('$orderId') , "riderId": int.parse('$riderId') },



      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return int.parse('$status') < 500;
          }),
    );



    return {"response": _responseAcceptOrder.data, "status": _responseAcceptOrder.statusCode};


  }


}


