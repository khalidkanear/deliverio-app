import '/Components/Loading.dart';
import '/Screens/HomeScreen/Models/StatusProvider.dart';
import '/WebServices/ChangeOnlineStatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Config.dart';
import '../../../Constants.dart';
import '../../../string.dart';



Drawer drawer(BuildContext context){


  return Drawer(
    elevation: 0,

    child: Container(

      child: Column(
        children: [

          Expanded(flex: 3,

            child: Container(
              color: kGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: kDefaultPadding,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Image.asset("assets/images/logoOnly.png", scale: SizeConfig.heightMultiplier * .7,),
                      SizedBox(height: kDefaultPadding/2,),
                      Text("PenyuRider", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.heightMultiplier * 1.8
                      ),),
                      SizedBox(height: kDefaultPadding/4,),
                      FittedBox(
                        child: Text("myperwajagrocer.com.my",style: TextStyle(
                          color: Colors.black.withOpacity(.5)
                        ),),
                      ),

                      SizedBox(height: kDefaultPadding * 2,)

                    ],
                  ),
                ],
              ),

            ),
          ),

          Expanded(flex: 8,

              child: Column(
                children: [


                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/orders');
                    },
                    child: ListTile(
                      leading: const Icon(Icons.list_alt_rounded,color: Colors.green,),
                      title: Text(english ? "Orders" : m["Orders"].toString(),
                        style: TextStyle(
                          fontSize: SizeConfig.heightMultiplier * 2.5,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/dashboard');
                    },
                    child: ListTile(
                      leading: Icon(Icons.data_usage_sharp,color: kOrange,),
                      title: Text(english ? "Dashboard" : m["Dashboard"].toString(),
                        style: TextStyle(
                          fontSize: SizeConfig.heightMultiplier * 2.5,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: ListTile(
                      leading: Icon(Icons.person_outline_rounded,color: kBase,),
                      title: Text(english ? "Profile": m["Profile"].toString(),
                        style: TextStyle(
                          fontSize: SizeConfig.heightMultiplier * 2.5,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      String? orderDetails = pref.getString("orderDetails");
                      
                      if(orderDetails != null){
                        
                      }else{

                        bool? onlineStatus = pref.getBool("OnlineStatus");
                        if(onlineStatus != null && onlineStatus){

                          ///Show Loading
                          ///Show Loading
                          showDialog(
                              context: context,
                              builder:(BuildContext context){
                                return loading;
                              }
                          );

                           Map<String,dynamic> resStatus =  await ChangeOnlineStatus().changeStatusReq();

                          Navigator.of(context).pop();
                           
                           
                           if(resStatus["status"]==200){
                             
                             String? email = pref.getString("email");
                             String? sentAt = pref.getString("sentAt");
                             pref.clear();
                             pref.setString("email", email.toString());
                             pref.setString("sentAt", sentAt.toString());

                             Navigator.of(context).pop();
                             Navigator.of(context).pushReplacementNamed('/welcome');

                             Provider.of<Status>(context , listen:  false).updateStatus(false);

                           
                           }
                           
                        }else{
                          String? email = pref.getString("email");
                          pref.clear();
                          pref.setString("email", email.toString());
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacementNamed('/welcome');
                        }
                        
                        
                      
                        
                      }
                      
                      
                      
                    },
                    child: ListTile(
                      leading: const Icon(Icons.logout,color: Colors.redAccent,),
                      title: Text(english ? "Logout" : m["Logout"].toString(),
                        style: TextStyle(
                          fontSize: SizeConfig.heightMultiplier * 2.5,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2,)

                ],
              )
          ),


        ],
      ),
    ),
  );


}