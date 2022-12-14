import 'package:get/get.dart';

class Dimensions {
  //1024 = width
  //768 = height / 10
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  //dynamic height - padding and margin
  static double height5 = screenHeight / 153.6;
  static double height10 = screenHeight / 76.8;
  static double height16 = screenHeight / 48;
  static double height20 = screenHeight / 38.4;
  static double height30 = screenHeight / 25.6;
  static double height40 = screenHeight / 19.2;
  static double height50 = screenHeight / 15.36;
  static double height56 = screenHeight / 13.71;
  static double height60 = screenHeight / 12.8;
  static double height136 = screenHeight / 5.64;

  //dynamic width - padding and margin
  static double width1 = screenWidth / screenWidth;
  static double width5 = screenWidth / 204.8;
  static double width12 = screenWidth / 85.3;
  static double width20 = screenWidth / 51.2;
  static double width24 = screenWidth / 42.66;
  static double width30 = screenWidth / 34.13;
  static double width40 = screenWidth / 25.6;
  static double width48 = screenWidth / 21.33;
  static double width64 = screenWidth / 16;
  static double width150 = screenWidth / 6.82;
  static double width350 = screenWidth / 2.925;

  //font size
  static double font10 = screenHeight / 76.8;
  static double font12 = screenHeight / 64;
  static double font16 = screenHeight / 48;
  static double font18 = screenHeight / 42.66;
  static double font20 = screenHeight / 38.4;
  static double font24 = screenHeight / 32;
  static double font40 = screenHeight / 19.2;

  //radius
  //static double radius5 = screenHeight / 170.2;
  static double radius8 = screenHeight / 96;
  static double radius12 = screenHeight / 64;
  static double radius20 = screenHeight / 38.4;
  static double radius30 = screenHeight / 25.6;

  //icon
  //static double icon15 = screenHeight / 56.73;
  static double icon18 = screenHeight / 42.66;
  static double icon22 = screenHeight / 35;
}
