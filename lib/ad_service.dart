import 'dart:io';


class AdMobService {

  String getAdMobAppId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3508692267480239~9420381879';
    }
    return null;
  }

  String getBannerAdId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3508692267480239/4429454230';
    }
    return null;
  }


  String getInterstitialAdId() {
     if (Platform.isAndroid) {
//      return '';
      return "ca-app-pub-3508692267480239/4429454230";
    }
    return null;
  }



}