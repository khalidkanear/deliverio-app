



import 'package:flutter/cupertino.dart';

class SelectedItem extends ChangeNotifier{


  List<bool> selectedItems = [];
  bool allSelected = false;


  void reset(){

    selectedItems = [];
    allSelected = false;

  }

  void initialize(int length){


      selectedItems = [];

      for(int i = 0 ; i <= length ; i++){
        selectedItems.add(false);
      }
      notifyListeners();


  }


  selectAll(){


    if(allSelected == true){
      for (var item in selectedItems) {
        selectedItems[selectedItems.indexOf(item)] = false;
      }
      allSelected = false;
    }else{
      for (var item in selectedItems) {
        selectedItems[selectedItems.indexOf(item)] = true;
      }
      allSelected = true;
    }

    notifyListeners();

  }

  updateStatus( int index){


    selectedItems[index] =! selectedItems[index];
    notifyListeners();


  }








}