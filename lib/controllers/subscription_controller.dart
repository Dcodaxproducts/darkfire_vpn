// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';
import '../common/navigation.dart';
import '../common/snackbar.dart';

bool get isPro => SubscriptionController.find.isPro;

class SubscriptionController extends GetxController implements GetxService {
  static SubscriptionController get find => Get.find<SubscriptionController>();

  final FlutterInappPurchase _iap = FlutterInappPurchase.instance;

  final List<String> _subscriptionIds = const <String>[
    'yearly_plan',
    'monthly_plan',
    'weekly_plan',
  ];
  List<IAPItem> _products = [];
  late StreamSubscription _purchaseUpdatedSubscription;
  DateTime? _proLimitDate;

  List<IAPItem> get products => _products;
  DateTime? get proLimitDate => _proLimitDate;

  set products(List<IAPItem> value) {
    _products = value;
    update();
  }

  set proLimitDate(DateTime? value) {
    _proLimitDate = value;
    update();
  }

  Future<void> initialize() async {
    await _iap.initialize();
    await _getSubscriptiions();
    await refreshProStatus();
    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((result) {
      _verifyPurchase(result, callback: () {
        pop();
        showToast('purchase_success'.tr, success: true);
      });
    });
  }

  Future<void> _getSubscriptiions() async {
    var data = await _iap.getSubscriptions(_subscriptionIds);
    if (data.isNotEmpty) {
      _products.addAll(data);
    }
    update();
  }

  Future<void> buyProduct(IAPItem productDetails,
      {Function()? callback}) async {
    try {
      await _iap.requestSubscription(productDetails.productId!);
    } catch (e) {
      print(e);
    }
  }

  _verifyPurchase(PurchasedItem? result, {Function()? callback}) async {
    if (result == null) {
      // Handle the case where the purchase is null
      return;
    }
    // Check if the purchase is successful
    if (Platform.isAndroid) {
      if (result.purchaseStateAndroid == PurchaseState.purchased) {
        _finishTransaction(result, callback: callback);
      }
    } else {
      if (result.transactionStateIOS == TransactionState.purchased ||
          result.transactionStateIOS == TransactionState.restored) {
        _finishTransaction(result, callback: callback);
      }
    }
  }

  Future<void> _finishTransaction(PurchasedItem result,
      {Function()? callback}) async {
    DateTime? purchaseTime = result.transactionDate;

    switch (result.productId!.toLowerCase()) {
      case "yearly_plan":
        purchaseTime = purchaseTime?.add(const Duration(days: 365));
        break;
      case "monthly_plan":
        purchaseTime = purchaseTime?.add(const Duration(days: 30));
        break;
      case "weekly_plan":
        purchaseTime = purchaseTime?.add(const Duration(days: 7));
        break;

      default:
        return;
    }
    if (DateTime.now().isBefore(purchaseTime!)) {
      proLimitDate = purchaseTime;
    }
    try {
      await _iap.finishTransaction(result);
      if (callback != null) callback.call();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future refreshProStatus() async {
    // get past purchases
    var result = await _iap.getAvailablePurchases();
    if (result != null && result.isNotEmpty) {
      for (var item in result) {
        _verifyPurchase(item);
      }
    }
  }

  bool get isPro {
    if (proLimitDate == null) {
      return false;
    } else {
      return DateTime.now().isBefore(proLimitDate!);
    }
  }

  @override
  void onClose() {
    _purchaseUpdatedSubscription.cancel();
    super.onClose();
  }
}
