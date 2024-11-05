// ignore_for_file: avoid_print

import 'dart:math';

import 'package:birdandroid/utility/Address.dart';
import 'package:birdandroid/utility/General.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSDKQueryConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSDKSavedCardInfo.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';


class PayTabsController extends GetxController {
  String instructions = 'Tap on "Pay" Button to try PayTabs plugin';

  var rng = Random();
  PaymentSdkConfigurationDetails generateConfig() {
  var billingDetails = BillingDetails(General.username, General.email,
      General.mobile, Address.a_street, "sa", Address.a_city, Address.a_city, "12345");
  var shippingDetails = ShippingDetails(General.username, General.email,
      General.mobile, Address.a_street, "sa", Address.a_city, Address.a_city, "12345");
  List<PaymentSdkAPms> apms = [];
  apms.add(PaymentSdkAPms.AMAN);
  final configuration = PaymentSdkConfigurationDetails(
      profileId: "109021",
      serverKey: "SMJNHNDLNL-JHT9JN9DD2-WT6LRLJHBZ",
      clientKey: "CTKM9D-NQNG6H-7P6QPD-RDH977",
      cartId: rng.nextInt(100).toString(),
      cartDescription: "Flowers",
      merchantName: "The bird sa",
      screentTitle: "payment".tr,
      amount: 20.0,
      showBillingInfo: false,
      forceShippingInfo: false,
      currencyCode: "SAR",
      merchantCountryCode: "SA",
      billingDetails: billingDetails,
      shippingDetails: shippingDetails,
      alternativePaymentMethods: apms,
      linkBillingNameWithCardHolderName: true,
    );
    final theme = IOSThemeConfigurations();
    theme.logoImage = "assets/logo.png";
    configuration.iOSThemeConfigurations = theme;
    configuration.tokeniseType = PaymentSdkTokeniseType.MERCHANT_MANDATORY;
    return configuration;
  }

  Future<void> payPressed() async {
    FlutterPaytabsBridge.startCardPayment(generateConfig(), (event) {
      print('event');
      print(event);
      print(event["data"]);
      if (event["status"] == "success") {
        // Handle transaction details here.
        var transactionDetails = event["data"];
        print(transactionDetails);
        if (transactionDetails["isSuccess"]) {
          print("successful transaction");
          if (transactionDetails["isPending"]) {
            print("transaction pending");
          }
        } else {
          print("failed transaction");
        }

        // print(transactionDetails["isSuccess"]);
      } else if (event["status"] == "error") {
        print("error");
        // Handle error here.
      } else if (event["status"] == "event") {
        print("event");
        // Handle events here.
      }
    });
  }

  Future<void> payWithTokenPressed() async {
    FlutterPaytabsBridge.startTokenizedCardPayment(
        generateConfig(), "*Token*", "*TransactionReference*", (event) {
          print(event);
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            print("failed transaction");
          }

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
  }

  Future<void> payWith3ds() async {
    FlutterPaytabsBridge.start3DSecureTokenizedCardPayment(
        generateConfig(),
        PaymentSDKSavedCardInfo("4111 1111 1111 1111", "visa"),
        "*Token*", (event) {
          print("event");
          print(event);
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            print("failed transaction");
          }

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
          print("error transaction");
        } else if (event["status"] == "event") {
          // Handle events here.
          print("event transaction");
        }
      });
  }

  Future<void> payWithSavedCards() async {
    FlutterPaytabsBridge.startPaymentWithSavedCards(generateConfig(), false,
        (event) {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            print("failed transaction");
          }

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
  }

  Future<void> apmsPayPressed() async {
    FlutterPaytabsBridge.startAlternativePaymentMethod(generateConfig(),
        (event) {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
  }

  Future<void> queryPressed() async {
    FlutterPaytabsBridge.queryTransaction(
        generateConfig(), generateQueryConfig(), (event) {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
  }

  Future<void> applePayPressed() async {
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "*Profile id*",
        serverKey: "*server key*",
        clientKey: "*client key*",
        cartId: "12433",
        cartDescription: "Flowers",
        merchantName: "Flowers Store",
        amount: 20.0,
        currencyCode: "AED",
        merchantCountryCode: "ae",
        merchantApplePayIndentifier: "merchant.com.bunldeId",
        simplifyApplePayValidation: true);
    FlutterPaytabsBridge.startApplePayPayment(configuration, (event) {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
  }

  Widget applePayButton() {
    if (Platform.isIOS) {
      return TextButton(
        onPressed: () {
          applePayPressed();
        },
        child: const Text('Pay with Apple Pay'),
      );
    }
    return const SizedBox(height: 0);
  }

  Future clearSavedCards() async {
    final result = await FlutterPaytabsBridge.clearSavedCards();
    debugPrint("ClearSavedCards $result");
  }

  PaymentSDKQueryConfiguration generateQueryConfig() {
    return  PaymentSDKQueryConfiguration("ServerKey", "ClientKey",
        "Country Iso 2", "Profile Id", "Transaction Reference");
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}
