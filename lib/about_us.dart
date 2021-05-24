import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:smoke_tracker4/size_config.dart';

class Baghii extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final data = MediaQuery.of(context);

    return  Scaffold(
          backgroundColor: Colors.grey[850],
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text(
              'About Us',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                letterSpacing: 1.5,
              ),
            ),


          ),
          body:
             SafeArea(

                child: Column(
                  children: <Widget>[

                       Expanded(
                         flex: 1,
                         child: Center(

                              child: CircleAvatar(
                                radius: 5.71 * SizeConfig.heightMultiplier,
                                backgroundImage: AssetImage('assets/BaghiiLogo.jpg'),
                              ),
                            ),
                       ),

                     



                      Expanded(
                        flex: 1,
                        child: Divider(
                            color: Colors.grey[800],
                            height: SizeConfig.heightMultiplier * 10,
                          ),
                      ),



                    Expanded(
                        flex: 5,
                       
                          child: Text(
                            '       Have you ever tried to give up smoking but some day you just forgot your streak?\n\n'
                                '       We know from our personal experience how devastating this thing is and how many times you started smoking again and again just because you forgot your streak.But fear no more because now you have the ultime smoking tracker and that means NO MORE EXCUSES.\n'
                                '       BE A MAN AND STOP SMOKING RIGHT NOW!\n\n'
                                '       Founded and developed by the Baghii Org.All rights reserved! ©',


                            style: TextStyle(
                                color: Colors.teal[50],
                                fontWeight: FontWeight.bold,
                                fontSize: 2.35 * SizeConfig.textMultiplier,
                                fontFamily: 'IndieFlower'


                            ),


                          ),
                        ),

                    
                  ],
                ),



             ),




    );

  }
}
