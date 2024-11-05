
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constance.dart';
import '../../../http/url.dart';
import '../../controller/images_controller.dart';
import '../../controller/lang_controller.dart';
import 'controllers/chat_controller.dart';
// import 'controllers/chat_controller.dart';

// ignore: must_be_immutable
class ChatAdView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final ChatController chatController = Get.put(ChatController());
  String name,image,phone,imageUrl;
  ChatAdView({super.key,
  required this.name, required this.image, required this.phone, required this.imageUrl});
  final LangController langcontroller = Get.put(LangController());
  final ImagesController imagescontroller = Get.put(ImagesController());
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: Scaffold(
        appBar: AppBar(
          title:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              image != 'null'?
              FadeInDown(child:Image.network(imageUrl,width: sizeW25,height: sizeW25,fit: BoxFit.fill,),)
              :FadeInDown(child:Image.asset('assets/profile/person3.png',width: sizeW25,height: sizeW25,fit: BoxFit.fill,),),
              SizedBox(width: sizeW10,),
              Text(name,style: TextStyle(color: primaryColor,fontSize: sizeW20,fontWeight: FontWeight.w600),),
            ],
          ),
          centerTitle: true,
          actions: [
            phone != 'null'?
            Container(
              margin: EdgeInsets.all(sizeW15),
              child: FadeInDown(child:GestureDetector(
                onTap: (){
                  // ignore: deprecated_member_use
                  launch("tel://$phone");
                },
                child:const Icon(Icons.phone,color: primaryColor,) )),
            ):Container(),
          ],
          leading: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Container(
              width: sizeW25,
              height: sizeW25,
              margin: EdgeInsets.all(sizeW12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(sizeW25),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                    offset: const Offset(0, 0),
                    blurRadius: 10.0,
                  )
                ],
              ),
              child: Padding(
                padding:  EdgeInsets.only(right: langcontroller.appLocale == 'ar'? sizeW5:0,left: langcontroller.appLocale == 'en'? sizeW5:0),
                child: Center(child: Icon(Icons.arrow_back_ios,color: greyOpacityColor,size: sizeW15,)),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: whitecolor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          width: Get.width / 1,
          decoration:  BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color:  const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                offset:  const Offset(0, 0),
                blurRadius: 10.0,
              )
            ],
          ),
          padding:EdgeInsets.only(left: sizeW20, right: sizeW20, top: sizeH10, bottom: sizeH10),
          child: Form(
            key: formKey,
            child: TextFormField(
              textAlign: TextAlign.start,
              cursorColor: Colors.white,
              keyboardType: TextInputType.text,
              cursorWidth: 0.5,
              autofocus: false,
              controller: chatController.msgTextController,
              // ignore: missing_return
              validator: (value) {
                if (value!.isEmpty) {
                  return 'required'.tr;
                }
                return null;
              },
              decoration: InputDecoration(
                fillColor: grey5.withOpacity(.3),
                filled: true,
                contentPadding: EdgeInsets.only(
                    top: 0, bottom: 0, right: sizeW20, left: sizeW20),
                hintText: 'Type Here.....'.tr,
                suffixIcon : SizedBox(
                  width: sizeW100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            chatController.addMsg();
                          }
                        },
                        child: const Icon(
                          Icons.send_rounded,
                          color: greyOpacityColor,
                        ),
                      ),
                      SizedBox(width: sizeW15,),
                      GestureDetector(
                        onTap: (){
                          imagescontroller.checkPermission();
                          FocusScope.of(context).requestFocus(FocusNode());
                          final action = CupertinoActionSheet(
                            title: Text(
                              'change photo'.tr,
                              style:  TextStyle(
                                fontSize: sizeW15,
                                color: blackolor,
                              ),
                            ),
                            actions: <Widget>[
                              CupertinoActionSheetAction(
                                child: Text(
                                  'camera'.tr,
                                  style:  TextStyle(
                                    fontSize: sizeW15,
                                    color: primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  chatController
                                        .getImageCaht(ImageSource.camera);
                                    Navigator.pop(context);
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: Text(
                                  'gallary'.tr,
                                  style:  TextStyle(
                                    fontSize: sizeW15,
                                    color: primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  chatController
                                        .getImageCaht(ImageSource.gallery);
                                    Navigator.pop(context);
                                },
                              )
                            ],
                          );
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) => action,
                          );
                        },
                        child: Image.asset('assets/icons/chatgallery.png',)),
                      SizedBox(width: sizeW20,)
                    ],
                  ),
                ),
                hintStyle: TextStyle(
                  fontSize: sizeW14,
                  color: greyOpacityColor,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(sizeW25),
                  borderSide: const BorderSide(
                    color: whitecolor,
                    width: 0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(sizeW25),
                  borderSide: const BorderSide(
                    color: whitecolor,
                    width: 0,
                  ),
                ),
                
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(sizeW25),
                  borderSide: const BorderSide(
                    color: whitecolor,
                    width: 0,
                  ),
                ),
              ),
              style:   TextStyle(
                fontSize: sizeW16,
                color: blackolor,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        body: Container(
          color: whitecolor,
          height: Get.height / 1.2,
          child: ListView(
            children: [
              Obx(() => Container(
                width: Get.width,
                height: Get.height / 1.5,
                margin:  EdgeInsets.all(sizeW15),
                
                child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: chatController.chatsListData.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                        bottom: chatController.chatsListData[index].bodyType == 'text' ?sizeH8:0,
                        top: chatController.chatsListData[index].bodyType == 'text' ?sizeH10:0
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          chatController.chatsListData[index].type == 'client'? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding:  EdgeInsets.all(chatController.chatsListData[index].bodyType == 'text' ? sizeW20:0),
                                      decoration:  BoxDecoration(
                                        borderRadius:  BorderRadius.all(
                                           Radius.circular(chatController.chatsListData[index].bodyType == 'text' ? sizeW25:0),
                                        ),
                                          color: Colors.white,
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color:  const Color.fromARGB(31, 153, 152, 152).withOpacity(0.2),
                                              offset:  const Offset(0, 0),
                                              blurRadius: chatController.chatsListData[index].bodyType == 'text' ?10.0:0,
                                            )
                                          ],
                                        ),
                                      child: chatController.chatsListData[index].bodyType == 'text' ?Text(
                                        chatController.chatsListData[index].body!,
                                        style: TextStyle(color: primaryColor,fontSize: sizeW14,fontWeight: FontWeight.w400),
                                      ):SizedBox(
                                        width: Get.width / 1.5,
                                        height: Get.height / 2.5,
                                        child: Image.network('$urlBaseImage${chatController.chatsListData[index].body!}')
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: sizeW65),
                                ],
                              ),
                              SizedBox(height: sizeH8,),
                              Text(
                                chatController.chatsListData[index].dateString!,
                                style: TextStyle(color: greyOpacityColor,fontSize: sizeW10,fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: sizeH8,),
                            ],
                          ):Container(
                            margin: EdgeInsets.only(bottom: chatController.chatsListData[index].bodyType == 'text' ? sizeH5:0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(width: sizeW65),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(chatController.chatsListData[index].bodyType == 'text' ?sizeW20:0),
                                        decoration:  BoxDecoration(
                                          color: chatController.chatsListData[index].bodyType == 'text' ?primaryColor:whitecolor,
                                          borderRadius:  BorderRadius.all(
                                            Radius.circular(chatController.chatsListData[index].bodyType == 'text' ?sizeW25:0),
                                          ),
                                        ),
                                        child: chatController.chatsListData[index].bodyType == 'text' ?Text(
                                          chatController.chatsListData[index].body!,
                                          style: TextStyle(color: whitecolor,fontSize: sizeW14,fontWeight: FontWeight.w400),
                                        ):SizedBox(
                                          width: Get.width / 1.5,
                                          height: Get.height / 2.5,
                                          child: Image.network('$urlBaseImage${chatController.chatsListData[index].body!}')
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: sizeH8,),
                                Text(
                                  chatController.chatsListData[index].dateString!,
                                  style: TextStyle(color: greyOpacityColor,fontSize: sizeW10,fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
