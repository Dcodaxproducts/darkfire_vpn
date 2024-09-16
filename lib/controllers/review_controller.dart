import 'dart:convert';
import 'package:darkfire_vpn/common/snackbar.dart';
import 'package:darkfire_vpn/data/repository/review_repo.dart';
import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ReviewController extends GetxController implements GetxService {
  final ReviewRepo reviewRepo;
  ReviewController({required this.reviewRepo});
  static ReviewController get find => Get.find<ReviewController>();

  static ReviewController get to => Get.find<ReviewController>();

  bool _isReviewed = false;

  bool get isReviewed => _isReviewed;

  set isReviewed(bool value) {
    _isReviewed = value;
    update();
  }

  Future<void> saveReview(int rating, String review) async {
    showLoading();
    final body = {'rating': rating, 'review': review};
    final response = await reviewRepo.saveReview(body);
    if (response != null) {
      setReviewed();
      final data = jsonDecode(response.body);
      if (data['status'] == 1) {
        isReviewed = true;
        showToast(data['message']);
      } else {
        showToast(data['message']);
      }
    }
  }

  Future<void> setReviewed() async {
    final response = await reviewRepo.setReviewed();
    if (response) {
      isReviewed = true;
    }
  }

  void checkReviewed() {
    isReviewed = reviewRepo.isReviewed();
  }

  void launchStore() {
    launchUrlString(
        'https://play.google.com/store/apps/details?id=${AppConstants.androidPackageName}');
  }
}
