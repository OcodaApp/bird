// ignore_for_file: must_be_immutable, unnecessary_null_comparison, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../constance.dart';
import '../../controller/lang_controller.dart';
import 'controllers/search_home_controller.dart';

class StoresSearchHome extends StatelessWidget {
  StoresSearchHome({Key? key}) : super(key: key);
  final LangController langcontroller = Get.put(LangController());
  final SearchHomeController controller = Get.put(SearchHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(),
      ),
      
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.all(sizeW20),
        child: ListView(
          children:  [
            FadeInRight(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back_ios,color: blackolor,),
                  ),
                  SizedBox(width: sizeW10,),
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType : TextInputType.name,
                      controller: controller.searchTextController,
                      onFieldSubmitted: (value){
                        controller.getStoreDataList();
                      },
                      decoration:  InputDecoration(
                        isDense: true,
                        hintText: 'searchHome'.tr,
                        contentPadding:  EdgeInsets.only(
                          top: sizeH10,
                          bottom: sizeH10,
                          right: 0,
                          left: 0,
                        ),
                        border:   OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(sizeW45)),
                          borderSide: const BorderSide(
                            color: grey3,
                            width: 0.8,
                          ),
                        ),
                        prefixIcon: Image.asset(
                          "assets/search2.png",
                          color: primaryColor,
                          width: sizeW10,
                          height: sizeW10,
                        ),
                        hintStyle:   TextStyle(
                          fontSize: sizeW14,
                          color: grey5,
                          fontWeight: FontWeight.w300,
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius:  BorderRadius.all(Radius.circular(sizeW45)),
                          borderSide: const BorderSide(
                            color: grey3,
                            width: 0.8,
                          ),
                        ),
                        focusedBorder:   OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(sizeW45)),
                          borderSide: const BorderSide(
                            color: grey3,
                            width: 1,
                          ),
                        ),
                      ),
                      style:   TextStyle(
                        fontSize: sizeW16,
                        color: blackolor,
                        fontWeight: FontWeight.w300,
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: sizeH20,),
            Obx(() => controller.isStores.value? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: controller.storesData.isNotEmpty? controller.createSliders():[
                  Container()
                ],
              ):Container(),),
          ],
        ),
      ),
    );
  }
}
