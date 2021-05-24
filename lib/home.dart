import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:smoke_tracker4/ad_service.dart';
import 'package:smoke_tracker4/size_config.dart';



class mainPage extends StatefulWidget {
  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {

  final ams = AdMobService();

  @override
  void initState() {
    interstitialAd = AdmobInterstitial(
      adUnitId: "ca-app-pub-3508692267480239/1739819519",
    );
    interstitialAd.load();
    super.initState();
    _loadCounter();

    Admob.initialize(ams.getAdMobAppId());
  }



  static const duration = const Duration(seconds: 1);
  int seconds_passed = 0;
  int minutes_passed = 0;
  int hours_passed = 0;
  int days_passed = 0;
  bool isActive = false;
  Timer timer;
  DateTime timeStarted = new DateTime.now();
  DateTime timeTheUserStoppedSmooking = new DateTime.now();
  AdmobInterstitial interstitialAd;

  _getIntFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('timeSaved', timeTheUserStoppedSmooking.toString());
      prefs.setBool('isActive', isActive);
    });
  }

  _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final timeString = prefs.getString('timeSaved');
      final este = prefs.getBool('isActive');
      timeTheUserStoppedSmooking = DateTime.parse(timeString);
      isActive = este;



    });
  }






  @override
  Widget build(BuildContext context) {


    final data = MediaQuery.of(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    void seconds_passing(){
      if(isActive){

        setState(() {
          seconds_passed += 1;
        });
      }
    }

    void seconds_passingv2(){
      if(isActive){

        setState(() {
          timeStarted = new DateTime.now();
          var difference = timeStarted.difference(timeTheUserStoppedSmooking);
          seconds_passed = difference.inSeconds;
          minutes_passed = difference.inMinutes;
          hours_passed = difference.inHours;
          days_passed = difference.inDays;
        });
      }
    }




    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        seconds_passingv2();
        // print ("DAAAAAAAAAAAAAAAAAAAAAAAAAAA $difference");

      });
    }






    int seconds = seconds_passed % 60;
    int minutes = minutes_passed % 60;
    int hours = hours_passed % 60;
    int days = days_passed;


    return  Scaffold(
          backgroundColor: Colors.grey[850],
          appBar: AppBar(
            title: Text(
              'Stop Smoking Bruh!',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          body:  SafeArea(
            child: Container(

                  padding: const EdgeInsets.fromLTRB(35.0, 50.0, 50.0, 120.0),
                  child:  Column(

                        children: <Widget>[

                          FittedBox(
                            child: Text(
                              'You have not smoked for :',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 6 * SizeConfig.widthMultiplier,
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                          ),
                           SizedBox(height: 40.0,),
                           Row(

                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                Expanded(
                                  child: Container(

                                    padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                                    height: data.size.height * 0.15,
                                    child:FittedBox(
                                      child:LabelText(
                                      label: 'DAYS',
                                      value: days.toString().padLeft(2, '0' ),
                                    ),),


                                  ),
                                ),
                                Expanded(
                                  child:
                                  Container(
                                    padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                                    height: data.size.height * 0.15,
                                    child:
                                      FittedBox(
                                        child: LabelText(
                                          label: 'HRS',
                                          value: hours.toString().padLeft(2, '0' ),
                                        ),
                                      ),

                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                                    height: data.size.height * 0.15,
                                    child:FittedBox(
                                      child: LabelText(
                                        label: 'MIN',
                                        value: minutes.toString().padLeft(2, '0' ),
                                      ),
                                    ),


                                  ),
                                ),
                                Expanded(
                                  child:
                                  Container(
                                    padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                                    height: data.size.height * 0.15,
                                    child:
                                    FittedBox(
                                      child: LabelText(
                                          label: 'SEC',
                                          value: seconds.toString().padLeft(2, '0' ),
                                        ),
                                    ),

                                  ),
                                ),


                              ],
                            ),
                          SizedBox(height: 50.0,),

                          RaisedButton(

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            onPressed: () {


                              interstitialAd.show();
                              setState(() {

                                _getIntFromSharedPref();
                                seconds_passed = 0;
                                minutes_passed = 0;
                                hours_passed = 0;
                                days_passed = 0;
                                isActive = !isActive;
                                timeTheUserStoppedSmooking = new DateTime.now();

                              });




                            },
                            child: Text(
                              isActive ? 'I SMOKED...' : 'START',

                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,


                              ),
                            ),
                            color: Colors.black,

                          ),


                          SizedBox(height: 30.0,),

                          Container(
                            child:IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/about');
                              },
                              icon:Icon(Icons.help_outline),
                              color: Colors.red[900],
                              iconSize: 50.0,


                            ),


                          ),

                          AdmobBanner(
                            adUnitId: ams.getBannerAdId(),
                            adSize: AdmobBannerSize.BANNER,
                          ),






                        ]

                    ),

              ),
          ),




      );

  }
}

class LabelText extends StatelessWidget {
  LabelText({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(

        padding: EdgeInsets.all(3 * SizeConfig.widthMultiplier),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3 * SizeConfig.heightMultiplier),
          color: Colors.black,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

             Text(
                  '$value',
                  style: TextStyle(
                      color: Colors.white, fontSize: 7.5 * SizeConfig.widthMultiplier, fontWeight: FontWeight.bold),
                ),


           
           FittedBox(
             child: Text(
                  '$label',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
           ),
            
          ],
        ),
      ),
    );
  }
}
