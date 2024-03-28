import 'dart:convert';
import '/Components/AppBar.dart';
import '/Components/Loading.dart';
import '/Components/SnackBar.dart';
import '/Components/flatTextButton.dart';
import '/Config.dart';
import '/Constants.dart';
import '/Screens/Profile/Model/ProfileModel.dart';
import '/Screens/SignUp/Components/Form.dart';
import '/Screens/SignUp/Model/ProfileChangeNotifier.dart';
import '/WebServices/Register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../string.dart';
import 'Components/Terms.dart';

class Credentials extends StatelessWidget {


  ProfileModel? profileModel;
  bool? edit ;
  String title = "Signup";

  GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool? agreement = false;

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();


  Credentials(ProfileModel _profile){

    profileModel = _profile;

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,

      backgroundColor: Colors.white,

      appBar: appBar(english ? "Credentials" : m["Credentials"] , context, Colors.white, Colors.black),

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
                  child: Icon(Icons.vpn_key_rounded,color: kBlack,size: SizeConfig.heightMultiplier * 10,),
                ),


                Consumer<ProfileChangeNotifier>(
                  builder: (context, status, child){

                    return  buildCredentialFrom(formKey, email, pass, confirmPass, context, status.hidePassword);

                    },
                ),



                SizedBox(height: SizeConfig.heightMultiplier  * 2),


                Padding(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Column(children: [
                    Text(english ? "Note : Password must contain a Number, a Special Character & a Capital letter." : m["Note"].toString(),
                      style: TextStyle(color: Colors.redAccent, fontSize: SizeConfig.heightMultiplier * 2),
                      textAlign: TextAlign.center,
                    )
                  ],),
                ),

                SizedBox(height: SizeConfig.heightMultiplier  * 2),


                TermsAndContions(context),

                SizedBox(height: SizeConfig.heightMultiplier  * 2),



                /// SIGN UP BUTTON
                /// SIGN UP BUTTON

                Padding(
                  padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
                  child: InkWell(
                      onTap: () {

                          signUp(context);

                      },
                      child: FlatTextButton(context,english ? title : m[title].toString(), double.infinity, kOrange)
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










  ///BUild TERMS & CONDITIONS Check BOX
  ///BUild TERMS & CONDITIONS Check BOX
  Padding TermsAndContions(BuildContext context) {


    return Padding(
        padding: EdgeInsets.all(kDefaultPadding),

        child: Consumer<ProfileChangeNotifier>(
          builder: (context,item,child){



            return Column(
              children: <Widget>[

                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(


                        onChanged: ( value){

                          agreement = value ;
                          Provider.of<ProfileChangeNotifier>(context , listen:  false).updateTerms(value);

                        },

                        value: item.terms,
                        activeColor: Colors.white,
                        checkColor: Colors.black,

                      ),
                      Text(english  ? "I agree with" : m["I agree with"].toString() , style:  TextStyle(color: Colors.black , fontSize: SizeConfig.heightMultiplier * 2.0),),
                      InkWell(

                        child: Text(english ? " Terms & Conditions" : m["Terms & Conditions"].toString(), style: TextStyle(color: Colors.blueAccent ,fontSize: SizeConfig.heightMultiplier * 2),),
                        onTap: (){

                          Navigator.push(
                              context, MaterialPageRoute( builder: (context) => Terms() )
                          );

                        },

                      ),
                      Text(english ? " stated." : m["stated."].toString(), style: TextStyle(color: Colors.black, fontSize: SizeConfig.heightMultiplier * 2),),

                    ],
                  ),
                ),






              ],);
          },
        )
    );
  }





  signUp(BuildContext context) async {



    if(formKey.currentState!.validate() && signedup == false ){


      profileModel?.email = email.text;
      print("+++++++++++++++++++++++");
      print(profileModel?.profileImage);



      if(pass.text == confirmPass.text){
        if(agreement!){

          ///Loadring
          ///Loadring
          ///Loadring
          showDialog(
              context: context,
              builder:(BuildContext context){
                return loading;
              }
          );


          Map<String, dynamic> responseReg = await sendRegistrationRequest(profileModel! , pass.text);


          /// Stop Loading
          Navigator.of(context).pop();


          if(responseReg["status"]== 200 ){


            riderId = jsonDecode(responseReg["response"])["id"].toString();

            SharedPreferences pref =await SharedPreferences.getInstance();

            pref.setString("riderId", jsonDecode(responseReg["response"])["id"].toString());

            Navigator.of(context).pop();

            showSnackBar('Registered Successfully', _key);

            signedup = true;

            Navigator.pushReplacementNamed(context, "/welcome");


          }else{

            showSnackBar(responseReg["response"], _key);
          }

        }else{

          showSnackBar(english ? "Must agree to terms & conditions to proceed." : "Mesti bersetuju dengan terma & syarat untuk meneruskan.", _key);
        }
      }else{
        showSnackBar(english ? "Password and Confirm Password doesn’t match" : m["Password and Confirm Password doesn’t match"].toString(), _key);
      }



    }

  }

}
