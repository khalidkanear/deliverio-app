import '/Components/AppBar.dart';
import '/Components/Loading.dart';
import '/Components/SnackBar.dart';
import '/Components/flatTextButton.dart';
import '/Constants.dart';
import '/Screens/ForgotPassword/Components/ChangePassword.dart';
import '/WebServices/ForgotPassword.dart';
import '/WebServices/UpdatePassword.dart';
import 'package:flutter/material.dart';
import '../../Config.dart';
import 'Components/LoginForm.dart';





class ForgotPassword extends StatelessWidget {


  bool updatePass = false;
  String title = "Reset Password";

  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  TextEditingController email = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();


  ForgotPassword({bool? updatePass}){
    this.updatePass = updatePass??false;

    if(updatePass!){
      title = "Change Password";
      email.text = Id.toString();
    }

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _key,
      appBar: appBar(title, context, Colors.white, Colors.black),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [



            /// StateFull Form widget
            updatePass ?

            ChangePasswordForm(formKey: _formKey, email: email, oldPassword: oldPassword ,password: password, confirmPassword: confirmPassword, context: context) :

            LoginForm(formKey: _formKey, context: context, email: email ),

            ///Note for Password
            updatePass ? Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Column(children: [
                Text("Note : Password must contain a Number, a Special Character & a Capital letter.",
                  style: TextStyle(color: Colors.redAccent, fontSize: SizeConfig.heightMultiplier * 1.8,fontFamily: "Nunito"),
                  textAlign: TextAlign.center,
                )
              ],),
            ) : Container(),

            SizedBox(height: SizeConfig.heightMultiplier  * 2),

            /// Login Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 2, vertical: kDefaultPadding),
              child: InkWell(
                //Send Login Request
                  onTap: ()=> updatePass ? changePasswordReq(context) : forgotPassReq(context),
                  child: FlatTextButton(context, title, double.infinity, kOrange)
              ),
            )

          ],),
      ),

    );

  }


  void forgotPassReq(BuildContext context) async {

    if(_formKey.currentState!.validate()){



      /// Show Loading
      showDialog(
          context: context,
          builder:(BuildContext context){
            return loading;
          }
      );

      Map<String,dynamic> forgotPassResponse =  await forgotPasswordReq(email.text);


      ///Dismiss Loading
      Navigator.pop(context);


      if(forgotPassResponse["status"] == 200){

        Navigator.of(context).pop();

        showSnackBar("Please check your email to reset Password", _key);

      }else{
        showSnackBar(forgotPassResponse["response"], _key);
      }




    }

  }


  changePasswordReq(BuildContext context) async {

    if(_formKey.currentState!.validate()){

      if(password.text == confirmPassword.text ){




        /// Show Loading
        showDialog(
            context: context,
            builder:(BuildContext context){
              return loading;
            }
        );

         Map<String,dynamic> loginResponse =  await resetPasswordReq(email.text , oldPassword.text, password.text );


        ///Dismiss Loading
        Navigator.pop(context);


        if(loginResponse["status"] == 200){

          Navigator.of(context).pop();

        }



      }

    }

  }



}
