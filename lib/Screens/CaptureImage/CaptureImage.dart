import 'dart:io';

import 'package:flutter/scheduler.dart';

import '/Components/Loading.dart';
import '/Components/SnackBar.dart';
import '/Components/flatTextButton.dart';
import '/Config.dart';
import '/Constants.dart';
import '/Screens/DragableList/Model/CaptureImageService.dart';
import '/WebServices/UploadOrderImage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaptureImageScreen extends StatefulWidget {
  @override
  _CaptureImageState createState() => _CaptureImageState();
}

class _CaptureImageState extends State<CaptureImageScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => _captureImage());

    // WidgetsBinding.instance.addPostFrameCallback((_) => _captureImage());
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  File capturedImage=File('');
  bool imageSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        body: Stack(
          children: [
            SizedBox(
              height: SizeConfig.heightMultiplier * 100,
              width: SizeConfig.imageSizeMultiplier * 100,
              child: imageSelected
                  ? Image.file(capturedImage)
                  : Center(
                      child: GestureDetector(
                          onTap: _captureImage,
                          child: const Text("Tap to Select Image")),
                    ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    padding: EdgeInsets.only(
                        bottom: kDefaultPadding * 4,
                        left: kDefaultPadding,
                        right: kDefaultPadding),
                    child: GestureDetector(
                        onTap: uploadImage,
                        child: FlatTextButton(
                            context,
                            imageSelected ? "Upload Image" : "Select Image",
                            double.infinity,
                            kBase))),
              ],
            )
          ],
        ));
  }

  Future<void> _captureImage() async {
    capturedImage = await CaptureImage().getImage(ImageSource.camera);

    setState(() {
      if (capturedImage != null) {

        imageSelected = true;
      } else {
        imageSelected = false;
      }
    });
  }

  Future<void> uploadImage() async {
    if (imageSelected) {
      ///Loading
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return loading;
          });

      var res = await uploadOrderImage(capturedImage.path);

      Navigator.pop(context);

      if (res["status"] == 200) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.remove("orderDetails");
        showSnackBar("Order Complete", _key);
        Navigator.pushReplacementNamed(context, "/thankyou");
      } else {
        showSnackBar(res["response"], _key);
      }
    }
  }
}
