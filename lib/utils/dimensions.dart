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
  static double height136 = screenHeight / 5.64;

  //dynamic width - padding and margin
  static double width1 = screenWidth / screenWidth;
  static double width64 = screenWidth / 16;

  //font size
  static double font16 = screenHeight / 48;
  static double font40 = screenHeight / 19.2;

  //radius
  //static double radius5 = screenHeight / 170.2;

  //icon
  //static double icon15 = screenHeight / 56.73;
  static double icon22 = screenHeight / 35;
}
