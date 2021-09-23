import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3785449751039492~3299104346";
      // return 'ca-app-pub-3940256099942544~3347511713';
    } else if (Platform.isIOS) {
      // return "ca-app-pub-3940256099942544~2594085930";
      return '';
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3785449751039492/7046777665";
      // return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      // return "ca-app-pub-3940256099942544/4339318960";
      return '';
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3785449751039492/8168287646";
      // return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      // return "ca-app-pub-3940256099942544/3964253750";
      return '';
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static AdmobInterstitial getInterstialAd({Function handler}) {
    return AdmobInterstitial(
      adUnitId: AdManager.interstitialAdUnitId,
      // listener: (AdmobAdEvent event, Map<String, dynamic> args) {
      //   // print("InterstitialAdEvent: $event");
      //   if (event == AdmobAdEvent.closed ||
      //       event == AdmobAdEvent.failedToLoad) {
      //     print("InterstitialAdEvent: $event");
      //     handler();
      //   }
      // },
    );
  }

  static AdmobBanner getBannerAd() {
    return AdmobBanner(
      adUnitId: AdManager.bannerAdUnitId,
      adSize: AdmobBannerSize.BANNER,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        // handleEvent(event, args, 'Banner');
      },
    );
  }
}
