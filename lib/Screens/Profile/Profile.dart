import '/Config.dart';
import '/Constants.dart';
import '/Screens/Profile/Model/ProfileModel.dart';
import '/WebServices/GetRider.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../string.dart';
import 'Components/EditPassword.dart';
import 'Components/EditProfile.dart';
import 'Components/Vehicle.dart';


class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}




class _ProfileState extends State<Profile> {


  bool noVehicle = false;

  bool loading = true;

  String errorMessage = "Something went wrong";

  bool error = false;

  ProfileModel? _profile ;


  _ProfileState(){

    getProfile();

  }



  getProfile() async {

    Map<String,dynamic> responseProf = await getRiderByIdReq(int.parse(riderId.toString()));


    if(responseProf["status"]==200){

     setState(() {
       error = false;
       loading = false;
     });
      _profile = responseProf["response"];
      print(_profile);

    }else if(responseProf["status"]== 202){

      setState(() {
        error = false;
        loading = false;
        noVehicle = true;
        _profile = responseProf["response"];

      });


    }else if(responseProf["status"] == 101){

      setState(() {
        loading = false;
        errorMessage = "No Internet :(";
        error = true;
      });

    }

  }
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);


  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    getProfile();
    _refreshController.refreshCompleted();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,


      ///+++++++++++++++++++++++++++++++++++++ APP BAR +++++++++++++++++++++++++++++++
      appBar: AppBar(
        backgroundColor: kGrey,
        elevation: 0,
        leading: GestureDetector(
          onTap: ()=>Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        title: Text(english ? "Profile" : m["Profile"].toString(), style: TextStyle(color: Colors.black, fontFamily: 'Nunito', fontWeight: FontWeight.bold , fontSize: 2.5 * SizeConfig.heightMultiplier)),

      ),


      ///+++++++++++++++++++++++++++++++++++++++++++++ BODY ++++++++++++++++++++++++++++++++++++++++++++
      body: SmartRefresher(
        onRefresh: _onRefresh,
        controller: _refreshController,
        enablePullDown: true,
        child: loading ?

        Center(child: CircularProgressIndicator(backgroundColor: kGreen, color: kBaseLight,),) :

        error ?


        Center( child: Text(errorMessage,style: TextStyle(
          fontSize: SizeConfig.heightMultiplier * 2.0
        ),) ) :

        SingleChildScrollView(
          child: Column(
            children: [


              Stack(
                children: [



                  /// Accent Bg Color
                  /// Accent Bg Color
                  Container(
                    width: SizeConfig.imageSizeMultiplier *100,
                    height: SizeConfig.heightMultiplier * 35,
                    decoration: circularEdges(0, 0, SizeConfig.imageSizeMultiplier * 5, SizeConfig.imageSizeMultiplier * 5, kGrey),
                  ),


                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [


                      CircleAvatar(
                        backgroundColor: kBase.shade200,
                        radius: SizeConfig.heightMultiplier * 12,
                        child: CircleAvatar(
                          radius: SizeConfig.heightMultiplier * 11,
                          backgroundColor: kBase.shade100,
                          child: CircleAvatar(

                            /// Profile Image
                            /// Profile Image
                            backgroundImage: _profile?.profileImage != null ?  NetworkImage("https://"'"${ _profile?.profileImage}"') : const NetworkImage(''),
                            backgroundColor: kBase,

                            radius: SizeConfig.heightMultiplier * 8.5,
                          ),
                        ),
                      ),


                      SizedBox(
                        height: kDefaultPadding,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              '${_profile?.firstName}' " " '${_profile?.lastName}',
                              style: Theme.of(context).textTheme.headline2
                          )

                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(
                              '${_profile?.email}',
                              style: TextStyle(
                                color: Colors.black.withOpacity(.3),
                                fontSize: SizeConfig.heightMultiplier * 2,
                                fontFamily: 'Nunito',
                              )
                          )

                        ],
                      ),

                      SizedBox(
                        height: kDefaultPadding,
                      ),

                    ],
                  ),





                ],
              ),

              SizedBox(height: kDefaultPadding,),


              ///Edit Profile Section
              ///Edit Profile Section
              profileSection(context, _profile!),


              Container(
                margin:EdgeInsets.symmetric(vertical: kDefaultPadding * 2),

                height: 8,
                width: SizeConfig.imageSizeMultiplier * 100,
                color: kGrey,
              ),



              ///Edit vehicle Section
              ///Edit vehicle Section
              vehicle(context, _profile! , noVehicle),



              Container(
                margin:EdgeInsets.symmetric(vertical: kDefaultPadding * 2),

                height: 8,
                width: SizeConfig.imageSizeMultiplier * 100,
                color: kGrey,
              ),



              passwordSection(context, _profile!),


            ],
          ),
        ),

      )
    );
  }
}
