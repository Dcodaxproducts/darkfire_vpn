import 'package:get/get.dart';
import '../data/repository/splash_repo.dart';

class SplashController extends GetxController implements GetxService {
  final SplashRepo splashRepo;
  SplashController({required this.splashRepo});

  // instance
  static SplashController get find => Get.find<SplashController>();

  Future<bool> initSharedData() => splashRepo.initSharedData();
  Future<bool> removeSharedData() => splashRepo.removeSharedData();

  Future<void> saveFirstTime() async => await splashRepo.saveFirstTime();
  bool get isFirstTime => splashRepo.getFirstTime();
}
