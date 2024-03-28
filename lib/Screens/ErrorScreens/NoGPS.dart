import '/Config.dart';
import '/Constants.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class NoGPS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: SizeConfig.heightMultiplier * 100,
            width: SizeConfig.imageSizeMultiplier * 100,
            child: Image.asset(
              "assets/images/locationAccess.png",
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(kDefaultPadding * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "No Location Access",
                          style: Theme.of(context).textTheme.headline1,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Please enable GPS and try again.",
                          style: Theme.of(context).textTheme.headline2,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                    bottom: kDefaultPadding * 2,
                  ),
                  child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.imageSizeMultiplier * 20),
                      height: SizeConfig.heightMultiplier * 6,
                      width: SizeConfig.imageSizeMultiplier * 100,
                      decoration: circularEdges(
                          SizeConfig.heightMultiplier * 5,
                          SizeConfig.heightMultiplier * 5,
                          SizeConfig.heightMultiplier * 5,
                          SizeConfig.heightMultiplier * 5,
                          kOrange),
                      child: GestureDetector(
                        onTap: () async {
                          Location location = Location();

                          bool serviceEnabled =
                              await location.requestService();

                          if (serviceEnabled) {
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Enable Location",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontSize:
                                          SizeConfig.heightMultiplier * 2),
                            ),
                          ],
                        ),
                      ))),
            ],
          )
        ],
      ),
    );
  }
}
