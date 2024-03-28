import 'dart:io';


import '/Components/AppBar.dart';
import '/Components/Loading.dart';
import '/Components/SnackBar.dart';
import '/Components/flatTextButton.dart';
import '/Config.dart';
import '/Constants.dart';
import '/Screens/DragableList/Model/CaptureImageService.dart';
import '/Screens/Profile/Model/ProfileModel.dart';
import '/Screens/SignUp/Components/Form.dart';
import '/Screens/SignUp/Model/ProfileChangeNotifier.dart';
import '/Screens/SignUp/VehicleDetails.dart';
import '/WebServices/EditRiderProfile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../string.dart';



class SignUp extends StatelessWidget {
  ProfileModel? profile;
  bool ?edit ;
  String ? title = english ? "Next" : m["Next"];

  GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

 late String profileImage ;
 late File _image;
 late String nricUrl ;
 late File _imageNRIC;
 late String licenceImage ;
 late File _imageLicence;

  bool imageSelected = false;



 final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNumber =  TextEditingController();
  TextEditingController nric =  TextEditingController();
  TextEditingController licenceNumber =  TextEditingController();
  TextEditingController bankAccountNumber =  TextEditingController();
  TextEditingController vehicleRegNo = TextEditingController();


    SignUp(this.edit,this.profile ){




    if(edit==true){

      firstName.text = '${profile?.firstName}';
      lastName.text = '${profile?.lastName}';
      profileImage = '${profile?.profileImage}';
      address.text = '${profile?.address}';
      phoneNumber.text = '${profile?.phoneNo}';
      nric.text = '${profile?.nric}';
      licenceNumber.text = '${profile?.licenceNo}';
      bankAccountNumber.text = '${profile?.bankAccountNo}';

      title = "Update Profile";

    }

  }



  @override
  Widget build(BuildContext context) {


    Provider.of<ProfileChangeNotifier>(context, listen: false).reset();

    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,

      appBar: appBar(edit==true? title : english ? "Signup" : m["Signup"], context, Colors.white, Colors.black),
      body: SingleChildScrollView(
        child: Column(children: [

          SizedBox(height: SizeConfig.heightMultiplier ),

          Column(
            children: [

              Stack(
                children: [
                  Column(
                    children: [

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier * 2),
                        height: SizeConfig.heightMultiplier * 10,
                        decoration: circularEdges(10, 10, 10, 10, Colors.transparent),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: SizeConfig.heightMultiplier * 2),
                        height: SizeConfig.heightMultiplier * 10,
                        decoration: circularEdges(10, 10, 0, 0, Colors.white),
                      ),
                    ],
                  ),

                  edit==true ?

                      Consumer<ProfileChangeNotifier>(
                          builder: (key, provider, child){


                            return InkWell(
                              onTap: ()async {
                                File temp = await CaptureImage().getImage(ImageSource.gallery);

                                _image = temp;
                                Provider.of<ProfileChangeNotifier>(context,listen: false).updateImage(_image,0);


                              },
                              child: Center(
                                  child: CircleAvatar(
                                    backgroundColor: kGrey,
                                    radius: SizeConfig.heightMultiplier * 10,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: SizeConfig.heightMultiplier * 8.5,
                                      child: provider.imageSelected ? CircleAvatar(
                                        backgroundImage: FileImage(provider.image),
                                        radius: SizeConfig.heightMultiplier * 7.5,
                                      )
                                      : Icon(Icons.add_photo_alternate, size: SizeConfig.heightMultiplier  * 4, color: kOrange, )
                                      ,
                                    ),
                                  )
                              ),
                            );


                          }
                      )


                      :


                  Consumer<ProfileChangeNotifier>(
                      builder: (key, provider, child){


                        return InkWell(
                          onTap: ()async {
                            File temp = await CaptureImage().getImage(ImageSource.gallery);

                            _image = temp;
                            Provider.of<ProfileChangeNotifier>(context,listen: false).updateImage(_image,0);


                          },
                          child: Center(
                              child: CircleAvatar(
                                backgroundColor: kBase.withOpacity(.5),
                                radius: SizeConfig.heightMultiplier * 10,
                                child: CircleAvatar(
                                  backgroundColor: kBase.withOpacity(.5),
                                  radius: SizeConfig.heightMultiplier * 8.5,
                                  child: provider.imageSelected ? CircleAvatar(
                                    backgroundImage: FileImage(provider.image),
                                    radius: SizeConfig.heightMultiplier * 7.5,
                                  )
                                      :

                                        profileImage == "profileImage" ?

                                            Icon(Icons.person, size: SizeConfig.heightMultiplier * 4.5,)
                                        :

                                  CircleAvatar(
                                    backgroundImage: NetworkImage("http://"'${profile?.profileImage}'),
                                    radius: SizeConfig.heightMultiplier * 7.5,
                                    backgroundColor: kBase.withOpacity(.5),
                                  )
                                  ,
                                ),
                              )
                          ),
                        );


                      }
                  )


                ],
              ),

              buildRegistrationForm(
                  formKey,
                  firstName,
                  lastName,
                  profileImage,
                  address,
                  phoneNumber,
                  nric,
                  licenceNumber,
                  bankAccountNumber,
                  context
              ),

              Consumer<ProfileChangeNotifier>(
              builder: (key, provider, child){

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [


                  InkWell(
                    onTap: () async {
                      File temp = await CaptureImage().getImage(ImageSource.camera);
                      _imageNRIC = temp;
                      Provider.of<ProfileChangeNotifier>(context,listen: false).updateImage(_imageNRIC,1);
                    },
                    child: Row(

                      children: [

                        Expanded(flex: 1,child: Icon(Icons.upload_rounded,color: kOrange,size: kDefaultPadding * 2.5)),
                        Expanded(flex: 3,child: Text(provider.nricSelected ? _imageNRIC.path.split("/").last : english ? "Select Image( NRIC )" : m["Select Image (NRIC)"].toString(),style:
                        TextStyle(fontSize: provider.nricSelected ? kDefaultPadding * .8 : kDefaultPadding * 1.1,
                            color: !provider.nricSelected ? Colors.black.withOpacity(.7): Colors.blueAccent ))),

                        SizedBox(width: kDefaultPadding,),


                      ],),
                  ),


                  InkWell(
                    onTap: () async {
                      File temp = await CaptureImage().getImage(ImageSource.camera);
                      _imageLicence = temp;
                      Provider.of<ProfileChangeNotifier>(context,listen: false).updateImage(_imageLicence,2);
                    },
                    child: Row(

                      children: [

                        Expanded(flex: 1,child: Icon(Icons.upload_rounded,color: kOrange,size: kDefaultPadding * 2.5,)),
                        Expanded(flex: 3,child: Text(provider.licenceSelected ? _imageLicence.path.split("/").last : english ? "Select Image( Licence )" : m["Select Image (Licence)"].toString(),style:
                        TextStyle(fontSize: provider.licenceSelected ? kDefaultPadding * .8 : kDefaultPadding * 1.1,
                            color: !provider.licenceSelected ? Colors.black.withOpacity(.7) : Colors.blueAccent ))),
                        SizedBox(width: kDefaultPadding,),

                      ],),
                  ),


                ],);




              }),








              /// SIGN UP BUTTON
              /// SIGN UP BUTTON

              Padding(
                padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
                child: InkWell(


                    ///On Press
                    ///On Press
                    ///On Press
                    onTap: () {

                      if(edit==true){
                        updateProfile(context);

                      }else{

                        signUp(context);

                      }
                      },

                    child: FlatTextButton(context,title??'', double.infinity, kOrange)
                ),
              ),



              SizedBox(height: SizeConfig.heightMultiplier  * 2),

            ],
          ),




        ],),
      ),


    );
  }






  signUp(BuildContext context) async {




    if(_image!= null ){
      if(_imageNRIC != null){
        if(_imageLicence != null){



          if(formKey.currentState!.validate()){

            profile =  ProfileModel(
                firstName: firstName.text,
                lastName: lastName.text,
                profileImage: _image.path,
                address: address.text,
                nric: nric.text,
                phoneNo: phoneNumber.text,
                licenceNo: licenceNumber.text,
                bankAccountNo: bankAccountNumber.text,
                nricUrl: _imageNRIC.path,
                licenceUrl: _imageLicence.path
            );


            Navigator.push(context, MaterialPageRoute(builder: (context)=> VehicleDetails(false, profile!)));
          }


        }else{
          showSnackBar( english ? "Please select licence image" : "Sila pilih imej lesen", _key);
        }
      }else{
        showSnackBar(english  ? "Please select NRIC image" : m["Please select NRIC image"].toString(), _key);
      }
    }else{
      showSnackBar(english ? "Please select profile image" : m["Please select profile image"].toString(), _key);
    }





  }


  Future<void> updateProfile(BuildContext context) async {

    if(formKey.currentState!.validate()){



      profile?.firstName = firstName.text;
      profile?.lastName = lastName.text;
      profile?.profileImage = _image.path;
      profile?.address = address.text;
      profile?.phoneNo = phoneNumber.text;
      profile?.licenceNo = licenceNumber.text;
      profile?.nric = nric.text;
      profile?.bankAccountNo = bankAccountNumber.text;


      print(profile);
      print(profile);


      ///Loadring
      ///Loadring
      ///Loadring
      showDialog(
          context: context,
          builder:(BuildContext context){
            return loading;
          }
      );

      Map<String,dynamic> responseEditProfile = await sendEditProfileReq(profile);

      Navigator.of(context).pop();

      print(responseEditProfile["response"]);
      print(responseEditProfile["status"]);


      if(responseEditProfile["status"]==200){

        showSnackBar("Profile updated Successfully", _key);

        Navigator.of(context).pop();

      }else{

        showSnackBar(responseEditProfile["response"], _key);

      }


    }


  }




}
