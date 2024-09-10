import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SpeedTestController extends GetxController implements GetxService {
  final FlutterInternetSpeedTest speedTest;
  SpeedTestController({required this.speedTest});

  static SpeedTestController get find => Get.find<SpeedTestController>();

  double _downloadSpeed = 0.0;
  double _uploadSpeed = 0.0;
  double _testProgress = 0.0;
  double _calculatingSpeed = 0.0;
  bool _isTesting = false;
  bool _isDownloading = false;

  double get downloadSpeed => _downloadSpeed;
  double get uploadSpeed => _uploadSpeed;
  double get testProgress => _testProgress;
  double get calculatingSpeed => _calculatingSpeed;
  bool get isTesting => _isTesting;
  bool get isDownloading => _isDownloading;
  double get speedGuageSize => 230.sp;

  set downloadSpeed(double value) {
    _downloadSpeed = value;
    update();
  }

  set uploadSpeed(double value) {
    _uploadSpeed = value;
    update();
  }

  set testProgress(double value) {
    _testProgress = value;
    update();
  }

  set isTesting(bool value) {
    _isTesting = value;
    update();
  }

  set isDownloading(bool value) {
    _isDownloading = value;
    update();
  }

  Future<void> startTesting() async {
    isTesting = true;
    speedTest.startTesting(
      useFastApi: true,
      onStarted: () {
        _isTesting = true;
        resetData();
      },
      onCompleted: (TestResult download, TestResult upload) {
        _downloadSpeed = download.transferRate;
        _uploadSpeed = upload.transferRate;
        _calculatingSpeed = upload.transferRate;
        _isTesting = false;
        _isDownloading = false;
        update();
      },
      onProgress: (double percent, TestResult data) {
        _testProgress = percent;
        _calculatingSpeed = data.transferRate;
        update();
      },
      onError: (String error, String speedTestError) {
        _isTesting = false;
        update();
      },
      onDownloadComplete: (TestResult data) {
        downloadSpeed = data.transferRate;
        _isDownloading = false;
      },
      onUploadComplete: (TestResult data) {
        uploadSpeed = data.transferRate;
      },
      onCancel: () {
        _isTesting = false;
        _isDownloading = false;
        update();
      },
    );
  }

  void resetData() {
    _isDownloading = true;
    _testProgress = 0;
    _downloadSpeed = 0;
    _uploadSpeed = 0;
    _calculatingSpeed = 0;
    update();
  }

  Future<bool> cancelTesting() async {
    return await speedTest.cancelTest();
  }
}
