import 'package:flutter/material.dart';

import '../../../Constants.dart';


class LoginForm extends StatefulWidget {

  GlobalKey<FormState>? formKey;
  TextEditingController ?email;
  BuildContext? context;

  LoginForm({
    @required this.formKey,
    @required this.email,
    @required this.context
  });

  @override
  _LoginFormState createState() => _LoginFormState();

}

class _LoginFormState extends State<LoginForm> {

  bool _obscureText = true;




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
              validator: (value)=>validatorEmail(value.toString()),
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



  validatorEmail(String value){

    if(value.isEmpty){

      return 'Please Enter Email';

    }else {
      return null;
    }

  }



}
