import 'package:flutter/material.dart';

import '../../../Constants.dart';


class ChangePasswordForm extends StatefulWidget {

  GlobalKey<FormState>? formKey;
  TextEditingController? email=TextEditingController();
  TextEditingController? oldPassword=TextEditingController();
  TextEditingController? password=TextEditingController();
  TextEditingController? confirmPassword=TextEditingController();
  BuildContext? context;

  ChangePasswordForm({
     this.formKey,
     this.email,
     this.password,
     this.oldPassword,
     this.confirmPassword,
     this.context
  });

  @override
  _LoginFormState createState() => _LoginFormState();

}

class _LoginFormState extends State<ChangePasswordForm> {

  bool _obscureText = true;
  bool _obscureTextOld = true;




  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: circularEdges(20, 20, 20, 20, Colors.white),

      child: Form(
        key: widget.formKey,
        child: Column(
          children: [



            /// Email Field
            TextFormField(
              controller: widget.email,
              style: Theme.of(context).textTheme.headline3,
              decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: Theme.of(context).textTheme.headline3
              ),
              validator: (value)=>validatorEmail(value??''),
            ),

            /// Password Field
            TextFormField(
              controller: widget.oldPassword,
              obscureText: _obscureTextOld,
              style: Theme.of(context).textTheme.headline3,

              decoration: InputDecoration(
                  suffix: InkWell(

                    // Invert the visibility boolean on tap
                    onTap: ()=> toggleOldPasswordVisibility(),

                    // Icon Button for making the password text visible
                    child: Icon(
                      _obscureTextOld ? Icons.visibility_off_rounded : Icons.visibility,
                      color: Colors.black,),
                  ),

                  labelText: "Old Password",labelStyle: Theme.of(context).textTheme.headline3
              ),

              validator: (value)=> validatorPassword(value.toString()),
            ),


            /// Password Field
            TextFormField(
              controller: widget.password,
              obscureText: _obscureText,
              style: Theme.of(context).textTheme.headline3,

              decoration: InputDecoration(
                  suffix: InkWell(

                    // Invert the visibility boolean on tap
                    onTap: ()=> togglePasswordVisibility(),

                    // Icon Button for making the password text visible
                    child: Icon(
                      _obscureText ? Icons.visibility_off_rounded : Icons.visibility,
                      color: Colors.black,),
                  ),

                  labelText: "New Password",labelStyle: Theme.of(context).textTheme.headline3
              ),

              validator: (value)=> validatorPassword(value.toString()),
            ),


            /// Confirm Password Field
            TextFormField(
              controller: widget.confirmPassword,
              obscureText: _obscureText,
              style: Theme.of(context).textTheme.headline3,

              decoration: InputDecoration(
                  suffix: InkWell(

                    // Invert the visibility boolean on tap
                    onTap: ()=> togglePasswordVisibility(),

                    // Icon Button for making the password text visible
                    child: Icon(
                      _obscureText ? Icons.visibility_off_rounded : Icons.visibility,
                      color: Colors.black,),
                  ),

                  labelText: "Confirm New Password",labelStyle: Theme.of(context).textTheme.headline3
              ),

              validator: (value)=> validatorPassword(value!),
            ),

          ],
        ),
      ),

    );

  }


  void togglePasswordVisibility(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  void toggleOldPasswordVisibility(){
    setState(() {
      _obscureTextOld = !_obscureTextOld;
    });
  }

  validatorPassword(String value){

    if(value.isEmpty){

      return 'Please Enter Password';

    }else if(value.length < 8 ){


      return 'Password must be 8 Characters long';

    }else if(widget.password?.text != widget.confirmPassword?.text){

      return 'Password & confirm password must be same';

    }else {
      return null;
    }

  }

  validatorEmail(String? value){

    if('$value'.isEmpty){

      return 'Please Enter Email';

    }else {
      return null;
    }

  }



}
