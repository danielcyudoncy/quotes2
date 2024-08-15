import 'package:get/get.dart';
import 'package:quotes2/controllers/auth_controller.dart';
import 'package:quotes2/controllers/profile_controller.dart';
import 'package:quotes2/controllers/quote_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<QuotesController>(() => QuotesController());
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
