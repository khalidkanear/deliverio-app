// import 'package:assets_audio_player/assets_audio_player.dart';
import '/Components/Loading.dart';
import '/Components/SnackBar.dart';
import '/Screens/HomeScreen/Models/GetLocationUtil.dart';
import '/Screens/HomeScreen/Models/OrderAlert.dart';
import '/Screens/HomeScreen/Models/StatusProvider.dart';
import '/WebServices/ChangeOnlineStatus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Config.dart';
import '../../../Constants.dart';



AppBar buildAppBarHome(BuildContext context, GlobalKey<ScaffoldState> key) {

  // final assetsAudioPlayer = AssetsAudioPlayer();
  bool isPlaying = false;

  return AppBar(
    automaticallyImplyLeading: true,
    elevation: 0,
    backgroundColor: Colors.white,

    leading: GestureDetector(

      onTap: (){
        key.currentState!.openDrawer();
      },

      child: Icon(
        Icons.sort_rounded,size: SizeConfig.heightMultiplier * 4,color: Colors.black,
      ),
    ),


    title: Consumer<Status>(
      builder: (context,item,child){
        return  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoSwitch(
              activeColor: Colors.green,
              value: item.status,

              onChanged: (val) async {

                bool locPermission = await GetLocaiton.hasPermission(key);

                if(locPermission){


                  ///Loadring
                  ///Loadring
                  ///Loadring
                  showDialog(
                      context: context,
                      builder:(BuildContext context){
                        return loading;
                      }
                  );


                  ///Change Status Update Req
                  ///Change Status Update Req
                  Map<String,dynamic> response = await ChangeOnlineStatus().changeStatusReq();
                  print("riderID : $riderId");
                  print("Response Status Update : $response");

                  Navigator.of(context).pop();


                  if(response["status"]== 200){

                    SharedPreferences pref = await SharedPreferences.getInstance();





                    if(val){
                      pref.setBool("OnlineStatus", true);

                      //BackLocService().getBgLocation();

                    }else{
                      //BackLocService().stopService();
                      pref.setBool("OnlineStatus", false);
                    }

                    Provider.of<Status>(context , listen:  false).updateStatus(val);
                  }else{
                    if(Navigator.of(context).canPop()){
                      Navigator.of(context).pop();
                    }
                    showSnackBar(response["response"], key);
                  }

                }else{

                  GetLocaiton().getLocation(key);


                }






              },


            ),
            Text(item.status ? " Online" : " Offline", style: Theme.of(context).textTheme.headline2,),

          ],
        );
      },
    ),
    actions: [
      GestureDetector(
        onTap: () async {

          OrderAlertModel order = OrderAlertModel(

              franchiseAddress: "abc street",
              franchiseName: "My Perwaja",
              deliveryAddress:  "KL Malaysia",
              pickTime:  "20",
              deliveryFee:  "40",
              profileImageFranchise:"https://play-lh.googleusercontent.com/9YewoWlnPknIUYPg9eCt37NNu0opdGMJAqQakcPLQONWXaBhocXcrDL8UPUEXqPytyE"


          );


          // Navigator.push(context, MaterialPageRoute(builder: (context)=> MarkPicked()));



        },

        child: Icon(
          Icons.notifications,
          color: Colors.black,
          size: SizeConfig.heightMultiplier * 3,
        ),
      ),
      SizedBox(width: kDefaultPadding/1.5,)
    ],


  );
}
