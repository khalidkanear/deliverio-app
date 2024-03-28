
import 'package:dio/dio.dart';
import '../Constants.dart';



class UpdateLocation{

  String? lat;
  String ?long;

  Response<String> _responseUpdateLoc = Response();


  UpdateLocation({
    this.lat,
    this.long
  });


  Future<Map<String,dynamic>> updateReq() async {


    Dio dioLogin = Dio();



    print(lat);
    print(long);

    dioLogin.options.headers["Authorization"] = "Bearer $bearerToken";

    _responseUpdateLoc = await dioLogin.post(

      "$baseUrl/api/RidersApi/UpdateLocation",

      data: {
        "riderId": int.parse(riderId.toString()),
        "lat": lat,
        "long": long
      },



      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return int.parse('$status') < 500;
          }),

    );





      return {"response": _responseUpdateLoc.data, "status": _responseUpdateLoc.statusCode};




  }


}


