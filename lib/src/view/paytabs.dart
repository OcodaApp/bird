// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:get/get.dart';
import '../../../constance.dart';
import '../controller/paytabs_controller.dart';

class PayTabsView extends StatelessWidget {
  PayTabsView({Key? key}) : super(key: key);
  final PayTabsController controller = Get.put(PayTabsController());
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.white,
          padding:  EdgeInsets.all(sizeW15),
          child: ListView(
            children: [
              Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Text(controller.instructions),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      controller.payPressed();
                    },
                    child: const Text('Pay with Card'),
                  ),
                  TextButton(
                    onPressed: () {
                      Future.delayed(const Duration(seconds: 20)).then(
                          (value) => FlutterPaytabsBridge.cancelPayment((dynamic) {
                                debugPrint("cancel payment $dynamic");
                              }));
                    },
                    child: const Text('Cancel Payment After 20 sec'),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.payWithTokenPressed();
                    },
                    child: const Text('Pay with Token'),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.payWith3ds();
                    },
                    child: const Text('Pay with 3ds'),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.payWithSavedCards();
                    },
                    child: const Text('Pay with saved cards'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      controller.apmsPayPressed();
                    },
                    child: const Text('Pay with Alternative payment methods'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      controller.queryPressed();
                    },
                    child: const Text('Query transaction'),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.clearSavedCards();
                    },
                    child: const Text('Clear saved cards'),
                  ),
                  const SizedBox(height: 16),
                  controller.applePayButton()
                ])),
            ],
          ),
        ),
      ),
    );
  }
}
