import 'package:dio/dio.dart';
import '../Constants.dart';






Future<Map<String,dynamic>> orderAcceptReq() async {


    Response<String> responseAcceptOrder = Response(requestOptions: RequestOptions(path: ''));

    Dio dio = Dio();


    print("Accept Order Service : $orderId");
    print("Accept Order Service : $riderId");


    dio.options.headers["Authorization"] = "Bearer $bearerToken";

    accepted = true ;

    responseAcceptOrder = await dio.get(

      "$baseUrl/api/OrdersApi/AssignOrderToRider",



      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return  int.parse('$status') < 500;
          }),
    );



    return {"response": responseAcceptOrder.data, "status": responseAcceptOrder.statusCode};





}

