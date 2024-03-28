import '/Components/AppBar.dart';
import '/Components/Loading.dart';
import '/Components/SnackBar.dart';
import '/Components/flatTextButton.dart';
import '/Config.dart';
import '/Constants.dart';
import '/Screens/Profile/Model/ProfileModel.dart';
import '/Screens/SignUp/Components/Form.dart';
import '/Screens/SignUp/Credentials.dart';
import '/WebServices/EditVehicle.dart';
import 'package:flutter/material.dart';
import '../../string.dart';

class VehicleDetails extends StatelessWidget {

  Vehicle? vehicleDetails;
  ProfileModel? profileModel;
  bool? edit=false ;
  String title = english ? "Next" : m["Next"].toString();

  GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _key = GlobalKey();


  TextEditingController make = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController regNo = TextEditingController();
  TextEditingController vehicleType = TextEditingController();


  VehicleDetails(bool _edit, ProfileModel _profile){

    edit = _edit;
    profileModel = _profile;
    vehicleDetails = _profile.vehicle;



    if(edit!){

      make.text = '${vehicleDetails?.make}';
      model.text = '${vehicleDetails?.model}';
      regNo.text = '${vehicleDetails?.regNo}';


      title = "Update Details";

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _key,

      appBar: appBar(english ? "Vehicle Details" : m["Vehicle Details"], context, Colors.white, Colors.black),

      body: Container(
        height: SizeConfig.heightMultiplier * 100,
        decoration: circularEdges(20, 20, 0, 0, kGrey),
        child: SingleChildScrollView(
          child: Column(
            children: [

            SizedBox(height: SizeConfig.heightMultiplier ),

            Column(

              children: [


                Padding(
                  padding: EdgeInsets.all(kDefaultPadding * 2),
                  child: Icon(Icons.pedal_bike_rounded,color: kBlack ,size: SizeConfig.heightMultiplier * 10,),
                ),


                buildVehicleForm(formKey, make, model, regNo,context),


                SizedBox(height: SizeConfig.heightMultiplier  * 2),


                /// SIGN UP BUTTON
                /// SIGN UP BUTTON

                Padding(
                  padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
                  child: InkWell(
                      onTap: () {

                        if(edit!){
                          editVehicle(context);

                        }else{
                          signUp(context);
                        }

                      },
                      child: FlatTextButton(context,title, double.infinity, kOrange)
                  ),
                ),



                SizedBox(height: SizeConfig.heightMultiplier  * 2),

              ],
            ),




          ],),
        ),
      ),


    );
  }


  signUp(BuildContext context) async {



    if(formKey.currentState!.validate() && signedup == false){

      profileModel?.vehicle = Vehicle(
        make: make.text,
        model: model.text,
        regNo: regNo.text,

      );


      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Credentials(profileModel!)));



    }




  }

  Future<void> editVehicle(BuildContext context) async {


    if(formKey.currentState!.validate()){


      String vehicleId = '${profileModel?.vehicle?.vehicleId}';


      profileModel?.vehicle =  Vehicle(
        make: make.text,
        model: model.text,
        regNo: regNo.text,
        vehicleId: vehicleId
      );

      ///Loadring
      ///Loadring
      ///Loadring
      showDialog(
          context: context,
          builder:(BuildContext context){
            return loading;
          }
      );


      Map<String, dynamic> responseReg = await sendEditVehicleReq(profileModel);


      /// Stop Loading
      Navigator.of(context).pop();


      if(responseReg["status"]== 200){
        showSnackBar("Vehicle updated Successfully.", _key);

        Navigator.of(context).pop();


      }else{

        showSnackBar(responseReg["response"], _key);
      }




    }

  }




}
