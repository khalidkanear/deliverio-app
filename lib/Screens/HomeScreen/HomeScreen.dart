import '/Components/CloseAppDialog.dart';
import 'package:flutter/material.dart';
import 'Components/HomeBody.dart';



class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();


}





class _HomeScreenState extends State<HomeScreen> {




  @override
  Widget build(BuildContext context) {


    return WillPopScope(

      ///EXIT APPLICATION
      ///EXIT APPLICATION
      ///EXIT APPLICATION
      onWillPop: () async {

        showDialog(context: context, builder: (BuildContext context){
          return closeAppDialog(context);
        });

        return false;

      },


      child: Scaffold(

          backgroundColor: Colors.white,

          body: Home()

      ),
    );


  }


}
