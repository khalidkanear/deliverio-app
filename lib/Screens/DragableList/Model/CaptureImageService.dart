import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CaptureImage{


  File _image=File('');

  final picker = ImagePicker();


  Future<File> getImage(ImageSource source) async {

    final pickedFile = await picker.getImage(source: source);



    if (pickedFile != null) {

      _image = File(pickedFile.path);
      print(_image);

      return _image;

    } else {

      print('No image selected.');
      return File('');

    }




  }









}