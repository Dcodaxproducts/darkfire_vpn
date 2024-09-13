import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
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

  PackageInfo? _packageInfo;
  PackageInfo? get packageInfo => _packageInfo;

  getPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
    update();
  }
}
