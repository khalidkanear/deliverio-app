import '/Components/CloseAppDialog.dart';
import 'package:flutter/material.dart';
import 'Components/body.dart';



class Welcome extends StatelessWidget {





  @override
  Widget build(BuildContext context) {

    return WillPopScope(

        child: buildBody(context),



      onWillPop: () async {

          showDialog(context: context, builder: (BuildContext context){
            return closeAppDialog(context);
          });

          return false;

          },

    );


  }



}
