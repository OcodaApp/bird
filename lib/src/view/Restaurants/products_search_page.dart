// ignore_for_file: must_be_immutable, unnecessary_null_comparison, prefer_typing_uninitialized_variables

import 'package:birdandroid/src/view/Restaurants/product_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../constance.dart';
import '../../controller/lang_controller.dart';
import 'controller/products_search_controller.dart';

class ProductsSearch extends StatelessWidget {
  ProductsSearch({Key? key}) : super(key: key);
  final LangController langcontroller = Get.put(LangController());
  final ProductsSearchController controller = Get.put(ProductsSearchController());

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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType : TextInputType.name,
                      controller: controller.searchTextController,
                      onChanged: controller.onSearchTextChanged,
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
            Obx(
              () => SizedBox(
                height: Get.height / 1.3,
                child: controller.searchResult.isEmpty ||
                        controller.searchTextController.text.isEmpty
                    ? ListView.builder(
                        itemCount: controller.productsData.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index2) {
                          return GestureDetector(
                            onTap: ()async{
                              FocusManager.instance.primaryFocus?.unfocus();
                              FocusScope.of(context).unfocus();
                              await Get.to(()=>ProductView(
                                product: controller.productsData[index2],reqs: controller.productsData[index2].reqs,opts: controller.productsData[index2].opts,),arguments: [controller.productsData[index2].id]
                              );
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.only(bottom: sizeH20),
                              margin: EdgeInsets.only(bottom: sizeH20),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: index2 == controller.productsData.length - 1? whitecolor: grey3.withOpacity(0.5),width:  1),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.width / 1.5,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(controller.productsData[index2].name,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: primaryColor)),
                                        SizedBox(height: sizeH5,),
                                        Text(controller.productsData[index2].desc,style: TextStyle(fontSize: sizeW12,fontWeight: FontWeight.w300,color: greyOpacityColor)),
                                        SizedBox(height: sizeH5,),
                                        Text('${controller.productsData[index2].price} ${'SAR'.tr}',style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w500,color: primaryColor)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Image.network(controller.productsData[index2].image,fit: BoxFit.fill,),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: controller.searchResult.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index2) {
                          return GestureDetector(
                            onTap: ()async{
                              FocusManager.instance.primaryFocus?.unfocus();
                              FocusScope.of(context).unfocus();
                              await Get.to(()=>ProductView(
                                product: controller.searchResult[index2],reqs: controller.searchResult[index2].reqs,opts: controller.searchResult[index2].opts,),arguments: [controller.searchResult[index2].id]
                              );
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.only(bottom: sizeH20),
                              margin: EdgeInsets.only(bottom: sizeH20),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: index2 == controller.searchResult.length - 1? whitecolor: grey3.withOpacity(0.5),width:  1),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.width / 1.5,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(controller.searchResult[index2].name,style: TextStyle(fontSize: sizeW16,fontWeight: FontWeight.w500,color: primaryColor)),
                                        SizedBox(height: sizeH5,),
                                        Text(controller.searchResult[index2].desc,style: TextStyle(fontSize: sizeW12,fontWeight: FontWeight.w300,color: greyOpacityColor)),
                                        SizedBox(height: sizeH5,),
                                        Text('${controller.searchResult[index2].price} ${'SAR'.tr}',style: TextStyle(fontSize: sizeW14,fontWeight: FontWeight.w500,color: primaryColor)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Image.network(controller.searchResult[index2].image,fit: BoxFit.fill,),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
