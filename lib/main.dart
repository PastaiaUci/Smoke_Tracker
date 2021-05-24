import 'package:flutter/material.dart';
import 'package:smoke_tracker4/about_us.dart';
import 'package:smoke_tracker4/home.dart';
import 'package:smoke_tracker4/size_config.dart';
import 'package:flutter/services.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:smoke_tracker4/ad_service.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(

              debugShowCheckedModeBanner: false,
              initialRoute: '/home',
              routes: {
                '/about': (context) => Baghii(),
                '/home': (conetext) => mainPage(),

              },


            );
          },
        );
      },
    );
  }
}