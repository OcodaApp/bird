// ignore_for_file: unnecessary_null_comparison

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_route_transition/page_route_transition.dart';
import '../../../constance.dart';
import '../../../utility/General.dart';
import '../../controller/intro_controller.dart';
import '../user/login_or_signapp.dart';

// ignore: must_be_immutable
class IntroViews extends StatefulWidget {
  const IntroViews({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _IntroViewsState createState() => _IntroViewsState();
}

class _IntroViewsState extends State<IntroViews> {
  final IntroController controller = Get.put(IntroController());
  final CarouselController introCarousel = CarouselController();
  var _current = 0;
  bool isFnish = false;
  var images = ['1.png','2.png','3.png'];
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(1),
      //   child: Container(color: whitecolor,),
      // ),
      body: Obx(() => controller.isData.value ?  ListView(
        children: [
          SizedBox(height: Get.height/7.5,),
          FadeInLeft(
            child: SizedBox(
              height: Get.height /3,
              width: Get.width /1.4,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: Get.height,
                  viewportFraction: 1.0,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  aspectRatio: 2.0,
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                    int fnish = images.length - 1;
                    if (index == fnish) {
                      setState(() {
                        isFnish = true;
                      });
                    }else{
                      setState(() {
                        isFnish = false;
                      });
                    }
                      
                  },
                ),
                carouselController: introCarousel,
                items:  createSliders() ,
              ),
            ),
          ),

          SizedBox(height: Get.height / 25,),
          
          FadeInRight(
            child: Column(
              children: [
                SizedBox(
                  width: Get.width / 1.3,
                  child: Text(
                    controller.introsData[_current].title!,
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                      color: Colors.black,
                      fontSize: sizeW25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeH15,
                ),
                SizedBox(
                  width: Get.width / 1.1,
                  child: Text(
                    controller.introsData[_current].desc!,
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                      color: greyOpacityColor,
                      fontSize: sizeW16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeH40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...Iterable<int>.generate(
                            images.length)
                        .map(
                      (int pageIndex) => Flexible(
                        child: Container(
                          width: _current == pageIndex ? Get.width / 6:Get.width / 12,
                          height: Get.width / 40,
                          margin:  EdgeInsets.symmetric(
                              vertical: Get.width / 120, horizontal: Get.width / 80,),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _current == pageIndex
                                ? primaryColor
                                : const Color(0xFF4D4D4D).withOpacity(.1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(
                  height: sizeH35,
                ),
                MaterialButton(
                  elevation: 0,
                  color: primaryColor,
                  minWidth: Get.width / 2.5,
                  height: sizeH48,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  onPressed: (){
                    if (!isFnish) {
                      introCarousel.nextPage();
                    } else {
                      General().setIntro();
                      PageRouteTransition.effect = TransitionEffect.scale;
                      PageRouteTransition.push(context, const LoginOrSignUpView());
                    }
                  },
                  child: Text(
                    !isFnish ?'next'.tr: 'started'.tr,
                    style:  TextStyle(
                      fontSize: sizeW16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ):const Center(child: CircularProgressIndicator())),
    );
  }

  List<Widget> createSliders() {
    List<Widget> imageSliders = controller.introsData.map((item) {
      return Obx(() => SizedBox(
        width: Get.width /1.3,
        child: controller.introsData[_current] != null
            ? Image.network(
                '${controller.introsData[_current].cover}',
                fit: BoxFit.contain,
              )
            : Image.asset('assets/images/intro.png'),
      ));
    }).toList();
    return imageSliders;
  }
}
