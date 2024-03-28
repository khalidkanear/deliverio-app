import '/Screens/SignUp/Model/ProfileChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Config.dart';
import '../../../Constants.dart';
import '../../../string.dart';



Form buildRegistrationForm(
    GlobalKey<FormState> formKey ,
    TextEditingController firstName,
    TextEditingController lastName,
    String profileImage,
    TextEditingController address,
    TextEditingController phoneNumber,
    TextEditingController nric,
    TextEditingController licenceNumber,
    TextEditingController bankAccountNumber,
    BuildContext context

    ) {


  int value = 1;

  return Form(

    key:  formKey,

    child: Container(
      decoration: circularEdges(0, 0, 10, 10, Colors.white),
      margin: EdgeInsets.symmetric(horizontal : SizeConfig.heightMultiplier * 2),
      padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[


          ///FIRST NAME FIELD
          ///FIRST NAME FIELD
          TextFormField(
            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: SizeConfig.heightMultiplier * 1.9),
            textCapitalization: TextCapitalization.sentences,
            controller: firstName,


            validator: (value){

              if('$value'.isEmpty){
                if (english) {
                  return 'Please Enter First Name';
                } else {
                  return  m['Please Enter First Name'];
                }
              }else {
                return null;
              }

            },

            decoration: InputDecoration(labelText: english ? "First Name" : m["First Name"],
            labelStyle: const TextStyle(color: Colors.black)
            ),
          ),
          ///LAST NAME FIELD
          ///LAST NAME FIELD
          TextFormField(
            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: SizeConfig.heightMultiplier * 1.9),
            textCapitalization: TextCapitalization.sentences,
            controller: lastName,

            validator: (value){

              if('$value'.isEmpty){
                return english ? 'Please Enter Last Name' : m['Please Enter Last Name'];
              }else {
                return null;
              }

            },

            decoration: InputDecoration(labelText: english ? "Last Name" : m["Last Name"], labelStyle: const TextStyle(color: Colors.black)
            ),
          ),

          ///ADDRESS FIELD
          ///ADDRESS FIELD
          TextFormField(
            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: SizeConfig.heightMultiplier * 1.9),
            textCapitalization: TextCapitalization.sentences,
            controller: address,
            validator: (value){

              if('$value'.isEmpty){
                return english ? "Please Enter Address" : m['Please Enter Address'];
              }else {
                return null;
              }

            },


            decoration: InputDecoration(labelText: english ? "Address" : m["Address"], labelStyle: const TextStyle(color: Colors.black)
            ),
          ),

          ///Phone Field
          ///Phone Field
          TextFormField(
            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: SizeConfig.heightMultiplier * 1.9),

            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.number,
            controller: phoneNumber,
            validator: (value){

              if('$value'.isEmpty){
                return english ?  'Please Enter Mobile No.' : m['Please Enter Mobile No.'];
              }else {
                return null;
              }

            },


            decoration: InputDecoration(labelText: english ? "Mobile No." : m["Mobile No."], labelStyle: const TextStyle(color: Colors.black)
            ),
          ),



          ///licence
          TextFormField(
            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: SizeConfig.heightMultiplier * 1.9),

            controller: licenceNumber,

            validator: (value){

              if('$value'.isEmpty){
                return english ? 'Please Enter Licence No.' : m['Please Enter Licence No.'];
              }else if('$value'.length < 5){
                return '5-34 Digits';
              }

              else {
                return null;
              }

            },

            keyboardType: TextInputType.number,

            decoration: InputDecoration(labelText: english ? "License No." : m["License No."], labelStyle: const TextStyle(color: Colors.black)
            ),
          ),

          ///NRIC
          TextFormField(
            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: SizeConfig.heightMultiplier * 1.9),

            controller: nric,

            validator: (value){

              if('$value'.isEmpty){
                return english ? 'Please Enter NRIC' : m['Please Enter NRIC'];
              }else if('$value'.length < 5){
                return '5-34 Digits';
              }

              else {
                return null;
              }

            },

            keyboardType: TextInputType.number,

            decoration: InputDecoration(labelText: english ? "NRIC" :  m["NRIC"], labelStyle: const TextStyle(color: Colors.black)
            ),
          ),

          ///BANK ACCOUNT
          TextFormField(
            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: SizeConfig.heightMultiplier * 1.9),

            controller: bankAccountNumber,

            validator: (value){

              if('$value'.isEmpty || value == ""){
                return english ? "Please Enter Bank Account No." : m["Please Enter Bank Account No."] ;
              }else if('$value'.length < 5){
                return '5-34 Digits';
              }

              else {
                return null;
              }

            },

            keyboardType: TextInputType.number,

            decoration: InputDecoration(labelText: english ? "Bank Account No." : m["Bank Account No."],  labelStyle: const TextStyle(color: Colors.black)
            ),
          ),


        ],),
    ),
  );




}

Form buildVehicleForm(
    GlobalKey<FormState> formKey ,
    TextEditingController make,
    TextEditingController model,
    TextEditingController regNumber,
    BuildContext context

    ) {



  return Form(

    key:  formKey,

    child: Container(
      decoration: circularEdges(10, 10, 10, 10, Colors.white),
      margin: EdgeInsets.symmetric(horizontal : SizeConfig.heightMultiplier * 2),
      padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[


          ///FIRST NAME FIELD
          ///FIRST NAME FIELD
          TextFormField(
            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: SizeConfig.heightMultiplier * 1.9),
            textCapitalization: TextCapitalization.sentences,
            controller: make,

            validator: (value){

              if('$value'.isEmpty){
                return english ? 'Please Enter Make' : m['Please Enter Make'];
              }else {
                return null;
              }

            },

            decoration: InputDecoration(labelText: english ? "Make" : m["Make"],labelStyle: const TextStyle(color: Colors.black))
          ),
          ///LAST NAME FIELD
          ///LAST NAME FIELD
          TextFormField(
            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: SizeConfig.heightMultiplier * 1.9),
            textCapitalization: TextCapitalization.sentences,
            controller: model,

            validator: (value){

              if('$value'.isEmpty){
                return english ? 'Please Enter Model No.' : m ['Please Enter Model No.'];
              }else {
                return null;
              }

            },

            decoration: InputDecoration(labelText: english ? "Model No." : m["Model No."],  labelStyle: const TextStyle(color: Colors.black)
            ),
          ),

          ///ADDRESS FIELD
          ///ADDRESS FIELD
          TextFormField(
            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: SizeConfig.heightMultiplier * 1.9),
            textCapitalization: TextCapitalization.characters,
            controller: regNumber,
            validator: (value){

              if('$value'.isEmpty){
                return english ? 'Please Enter Registration No.'  : m['Please Enter Registration No.'];
              }else {
                return null;
              }

            },


            decoration: InputDecoration(labelText: english ? "Registration No." : m["Registration No."], labelStyle: const TextStyle(color: Colors.black)
            ),
          ),





        ],),
    ),
  );




}



Form buildCredentialFrom(
    GlobalKey<FormState> formKey,
    TextEditingController email,
    TextEditingController pass,
    TextEditingController confrimPassword,
    BuildContext context,
    bool hide

    ) {



  return Form(

    key:  formKey,

    child: Container(
      decoration: circularEdges(10, 10, 10, 10, Colors.white),
      margin: EdgeInsets.symmetric(horizontal : SizeConfig.heightMultiplier * 2),
      padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[


          ///FIRST NAME FIELD
          ///FIRST NAME FIELD
          TextFormField(
            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: SizeConfig.heightMultiplier * 1.9),

            controller: email,

            validator: (value){

              if('$value'.isEmpty){
                return english ? 'Please Enter Email' : m['Please Enter Email'];
              }else {
                return null;
              }

            },

            decoration: InputDecoration(labelText: english ? "Email" : m["Email"] ,labelStyle: const TextStyle(color: Colors.black)
    ),
          ),
          ///Password fields
          ///Password fields
          TextFormField(
            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: SizeConfig.heightMultiplier * 1.9),


            controller: pass,
            obscureText: hide,
            validator: (value){

              if('$value'.isEmpty){
                return english ? 'Please Enter Password' : m['Please Enter Password'];
              }if('$value'.length < 6){
                return english ? "Password must be 6 characters long" : m["Password must be 6 characters long"];
              }else {
                return null;
              }

            },

            decoration: InputDecoration(

                suffixIcon: InkWell(onTap: ()=> Provider.of<ProfileChangeNotifier>(context,listen: false).invertHide(),

                  child: Icon( hide ? Icons.visibility_off : Icons.visibility, color: Colors.black,),),

                labelText: english ? "Password" : m["Password"], labelStyle: const TextStyle(color: Colors.black)
            ),
          ),

          ///ADDRESS FIELD
          ///ADDRESS FIELD
          TextFormField(
            style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: SizeConfig.heightMultiplier * 1.9),

            controller: confrimPassword,
            keyboardType: TextInputType.text,
            obscureText: hide,
            validator: (value){

              if('$value'.isEmpty){
                return english ? 'Please Enter Confirm Password' : m['Please Enter Confirm Password'];
              }
              else if(value == pass.text && '$value'.length == pass.text.length){
               return  null;
              }else {
                return english ? "Password and Confirm Password doesn't match" : m["Password and Confirm Password doesn't match"];
              }

            },


            decoration: InputDecoration(
                suffixIcon: InkWell(onTap: ()=> Provider.of<ProfileChangeNotifier>(context,listen: false).invertHide(),

                  child: Icon( hide ? Icons.visibility_off : Icons.visibility, color: Colors.black,),),

                labelText: english ?  "Confirm Password" :  m["Confirm Password"],  labelStyle: const TextStyle(color: Colors.black)
            ),
          ),





        ],),
    ),
  );




}