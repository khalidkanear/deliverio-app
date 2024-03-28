import 'dart:io';
import 'package:flutter/cupertino.dart';
import '/Screens/Profile/Model/ProfileModel.dart';




class ProfileChangeNotifier extends ChangeNotifier{

  late ProfileModel profile;
  late bool imageSelected = false;
  late bool nricSelected = false;
  late bool licenceSelected = false;
  late File image;
  late File nricImage;
  late File licenceImage;


  bool hidePassword = true;

  bool? terms = false;


  void updateTerms(bool? val){

    terms = val;
    notifyListeners();

  }


  void invertHide(){

    hidePassword = !hidePassword;
    notifyListeners();

  }

  void updateProfile(ProfileModel profile){

    profile = profile;

    notifyListeners();

  }


  void updateImage(File image, int images){

    if (images == 0){

      image = image;
      imageSelected = true;

    }else if(images == 1){

      nricImage = image;
      nricSelected = true;

    }else{

      licenceImage = image;
      licenceSelected = true;

    }

    notifyListeners();

  }


  void reset(){
    image = File('');
    imageSelected = false;
    licenceSelected = false;
    nricSelected = false;

  }


}