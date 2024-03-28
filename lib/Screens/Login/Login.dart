import 'dart:convert';

import '/Components/AppBar.dart';
import '/Components/Loading.dart';
import '/Components/SnackBar.dart';
import '/Components/flatTextButton.dart';
import '/Config.dart';
import '/Screens/ForgotPassword/ForgotPasswordScreen.dart';
import '/Screens/HomeScreen/HomeScreen.dart';
import '/Screens/HomeScreen/Models/StatusProvider.dart';
import '/Screens/OrderInitiated/OrderInitiated.dart';
import '/WebServices/GetStatusOnline.dart';
import '/WebServices/Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants.dart';
import '../../string.dart';


class Login extends StatelessWidget {

  final TextEditingController _id = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  Login(){

    getData();


  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      appBar: appBar(english ? "LOGIN" : m["LOGIN"], context, Colors.white, Colors.black),

      body: Column(children: [

        const Spacer(),


        Padding(
          padding:EdgeInsets.all(4 * SizeConfig.heightMultiplier),

          child: Form(
            key: _formKey,
            child: Column(children: [

              ///     ID
              ///     ID
              TextFormField(
                controller: _id,
                style: Theme.of(context).textTheme.headline3,
                decoration: InputDecoration(
                  labelText: "ID",
                  labelStyle: Theme.of(context).textTheme.headline3
                ),
                validator: (value){

                  if(value!.isEmpty){
                    return 'Please enter a valid Id';
                  }else {
                    return null;
                  }

                },
              ),


              ///    PASS
              ///    PASS
              TextFormField(
                controller: _pass,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.headline3,
                decoration: InputDecoration(
                  labelText: english ? "Password" : m["Password"],
                  labelStyle: Theme.of(context).textTheme.headline3
                ),

                validator: (value){

                  if(value!.isEmpty){
                    return english ? 'Please enter password' : m['Please Enter Password'];
                  }else {
                    return null;
                  }

                },
              ),


              /// Forgot Password
              /// Forgot Password
              Padding(
                padding: EdgeInsets.symmetric(vertical:2 * SizeConfig.heightMultiplier),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(

                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ForgotPassword(updatePass: false,))),
                        child: Text(english ? "Forgot Password" : "${m["Forgot Password"]}?", style: Theme.of(context).textTheme.headline3,)

                    ),
                  ],
                ),
              ),


                SizedBox(height: SizeConfig.heightMultiplier * 5,),


                /// Login Button
                /// Login Button
                InkWell(

                    onTap: ()=>loginRequet(context),
                    child: FlatTextButton(context,english ? "Login" : m["Login"].toString(), double.infinity,kOrange)
                )

            ],),
          ),
        ),
        const Spacer(),

      ],),



    );


  }


   Future<void> loginRequet(BuildContext context) async {






     if(_formKey.currentState!.validate()){

       showDialog(
           context: context,
           builder:(BuildContext context){
             return loading;
           }
       );


       Map<String, dynamic> resLogin;

       try {

         resLogin  = await LoginRequest(id: _id.text, pass: _pass.text.toString()).sendLoginReq();


         if(resLogin["status"]==200){

           SharedPreferences pref = await SharedPreferences.getInstance();

           pref.setString("userProfile", resLogin["response"]);

           pref.setString("riderId", jsonDecode(resLogin["response"])["id"].toString());

           pref.setString("email", _id.text);

           print(jsonDecode(resLogin["response"]));

           bearerToken = jsonDecode(resLogin["response"])["bearerToken"];
           fullName = jsonDecode(resLogin["response"])["fullName"];

           riderId = jsonDecode(resLogin["response"])["id"].toString();


           /// Get Online Status
           Map<String, dynamic> onlineStatus = await getStatusOnlineReq(int.parse(riderId.toString()));


           /// Update Online Status
           if(onlineStatus["status"]==200){

             SharedPreferences pref = await SharedPreferences.getInstance();

             statusOnline = onlineStatus["response"];

             pref.setBool("OnlineStatus", statusOnline);

             Provider.of<Status>( context, listen:  false).updateStatus(statusOnline);

             Navigator.of(context).pop();
             Navigator.of(context).pop();

             Navigator.pushReplacement(
               context,
               PageRouteBuilder(
                 pageBuilder: (context, animation1, animation2) => HomeScreen(),
                 transitionDuration: const Duration(seconds: 0),
               ),
             );

           }else if(onlineStatus["status"]==201 ){

             Navigator.of(context).pop();
             //Navigator.of(context).pop();
             Navigator.pushReplacement(context, MaterialPageRoute(  builder: (context)=> OrderInitiated( )));

           }




         }
         else{
           Navigator.of(context).pop();
           if(!english){
             showSnackBar(m["${resLogin["response"]} "].toString(), _key);
           }else{
             showSnackBar(resLogin["response"].toString(), _key);

           }


         }

       } on Exception catch(_){

         Navigator.of(context).pop();
         showSnackBar("Something went wrong, please try again latter", _key);

       }







     }








   }



   getData() async {

     SharedPreferences pref = await SharedPreferences.getInstance();

     _id.text = pref.getString("email").toString();


   }


}
