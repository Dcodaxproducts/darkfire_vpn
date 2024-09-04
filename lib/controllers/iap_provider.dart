import 'dart:async';
import 'dart:io';
import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';

///InAppPurchase realted provider
class IAPController extends GetxController implements GetxService {
  static IAPController get find => Get.find<IAPController>();

  late StreamSubscription<PurchasedItem?> _subscription;

  FlutterInappPurchase get _engine => FlutterInappPurchase.instance;

  final List<IAPItem> _productItems = [];
  List<IAPItem> get productItems => _productItems;

  bool _isPro = false;
  bool get isPro => _isPro;

  bool _inGracePeriod = false;
  bool get inGracePeriod => _inGracePeriod;

  ///Initialize IAP and handler all purchase functions
  Future initialize() {
    return _engine.initialize().then((value) async {
      _subscription = FlutterInappPurchase.purchaseUpdated
          .listen((item) => item != null ? _verifyPurchase(item) : null);
      await _loadPurchaseItems();
      await _verifyPreviousPurchase();
    });
  }

  ///Load purchased item, in this case subscription
  Future _loadPurchaseItems() {
    return _engine
        .getSubscriptions(AppConstants.subscriptionIdentifier.keys.toList())
        .then((value) {
      if (value.isNotEmpty) {
        productItems.addAll(value);
      }
    });
  }

  ///Verify previous purchase, so you'll know if subscription still occurs
  Future _verifyPreviousPurchase() async {
    return _engine.getAvailablePurchases().then((value) async {
      for (var item in value ?? []) {
        await _verifyPurchase(item);
      }
    });
  }

  ///Verify the purchase that made
  Future<bool> _verifyPurchase(PurchasedItem item) async {
    if (Platform.isAndroid) {
      if (item.purchaseStateAndroid == PurchaseState.purchased) {
        if (item.productId != null) {
          _isPro =
              _productItems.map((e) => e.productId).contains(item.productId);
        }
      }
    } else {
      if (item.transactionStateIOS == TransactionState.purchased ||
          item.transactionStateIOS == TransactionState.restored) {
        if (item.productId != null) {
          _isPro = await _engine.checkSubscribed(
            sku: item.productId!,
            duration: AppConstants.subscriptionIdentifier[item.productId!]
                    ?["duration"] ??
                Duration.zero,
            grace: AppConstants.subscriptionIdentifier[item.productId!]
                    ?["grace_period"] ??
                Duration.zero,
          );
        }
      }
    }

    if (item.transactionDate != null) {
      var different = DateTime.now().difference(item.transactionDate!);
      var subbscriptionDuration =
          AppConstants.subscriptionIdentifier[item.productId!]?["duration"] ??
              Duration.zero;
      var graceDuration = AppConstants.subscriptionIdentifier[item.productId!]
              ?["grace_period"] ??
          Duration.zero;
      if (different.inDays > subbscriptionDuration.inDays &&
          different.inDays <
              (subbscriptionDuration.inDays + graceDuration.inDays)) {
        _inGracePeriod = true;
      }
    }
    update();
    return _isPro;
  }

  ///Purchasing items
  Future purchase(IAPItem item) {
    return _engine.requestPurchase(item.productId!,
        offerTokenAndroid: item.subscriptionOffersAndroid?.first.offerToken);
  }

  Future<bool> restorePurchase() {
    return _engine.getAvailablePurchases().then((value) async {
      if (value?.isNotEmpty ?? false) {
        for (var element in value!) {
          await _verifyPurchase(element);
        }
        return true;
      }
      return false;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
