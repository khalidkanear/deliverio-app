import 'dart:io';

import '/Components/AppBar.dart';
import '/Components/SnackBar.dart';
import '/Components/flatTextButton.dart';
import '/Config.dart';
import '/Constants.dart';
import '/Screens/DragableList/Model/CaptureImageService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';




class MarkPicked extends StatefulWidget {

  @override
  _MarkPickedState createState() => _MarkPickedState();


}

class _MarkPickedState extends State<MarkPicked> {

  Color buttonColor = kOrange;

  bool imageSelected = false;

  File _image =File('');

  String button = "Select Image";


  final GlobalKey<ScaffoldState> _key = GlobalKey();


  @override
  Widget build(BuildContext context) {

    return Scaffold(


      backgroundColor: Colors.white,

      appBar: appBar("Invoice Image", context, Colors.white, Colors.black),

      body: Container(
        decoration: circularEdges(20, 20, 0, 0, kGrey),
        child: Stack(

          alignment: Alignment.bottomCenter,
          children: [

          imageSelected ?

          SizedBox(
              width: SizeConfig.imageSizeMultiplier * 100,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(_image, fit: BoxFit.fitWidth,)
              )

          ) : Container(),

          Padding(
            padding: EdgeInsets.all(kDefaultPadding * 2),

            child: InkWell(

              onTap: ()=> selectImage(),

                child: FlatTextButton(context, button, double.infinity, buttonColor)

            ),
          )


        ],),
      ),

    );


  }


  selectImage()async {


    _image = await CaptureImage().getImage(ImageSource.camera);

    setState(() {

      if(_image != null){

        buttonColor = kBase;
        button = "Mark Picked";
        imageSelected = true;

      }else{
        // To-Do Show SnackBar
        showSnackBar("No image selected, please try again.", _key);

      }


    });

  }


}
