import 'package:electrokimo/data/repositories/authentication/authentication_repository.dart';
import 'package:electrokimo/data/repositories/authentication/facture_repository.dart';
import 'package:electrokimo/features/auth/controllers/verification/verification_controller.dart';
import 'package:electrokimo/utils/network/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(AuthenticationRepository());
    Get.put(VerificationController());
    Get.put(FactureRepository());
  }
}
