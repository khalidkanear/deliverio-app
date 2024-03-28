import 'package:flutter/cupertino.dart';

import '../../../Constants.dart';






class OrderStatusListener extends ChangeNotifier{

  int orderStatus = 0;
  List<String> statuses = english ? ["Mark Picked","Mark Delivered","Order Completed"]  : ["Tanda Ambil Di","Tanda Berjaya Dihantar","Tanda Pesanan Selesai"];



  void updateStatus(int val){
    orderStatus = val;
    notifyListeners();
  }




}