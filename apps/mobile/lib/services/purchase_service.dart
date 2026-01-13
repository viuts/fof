import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class PurchaseService extends ChangeNotifier {
  static const String _entitlementId = 'FoF Pro';
  static const String _apiKey = 'test_TtmHbbBrVIazvLWcDEMFsOMRTKJ';

  CustomerInfo? _customerInfo;
  bool _isPro = false;
  Offerings? _offerings;

  CustomerInfo? get customerInfo => _customerInfo;
  bool get isPro => _isPro;
  Offerings? get offerings => _offerings;

  Future<void> init({String? uid}) async {
    if (kDebugMode) {
      await Purchases.setLogLevel(LogLevel.debug);
    }

    if (kIsWeb) {
      debugPrint('RevenueCat is not fully configured for Web yet.');
      return;
    }

    final configuration = PurchasesConfiguration(_apiKey)..appUserID = uid;
    await Purchases.configure(configuration);

    // Initial fetch
    try {
      _customerInfo = await Purchases.getCustomerInfo();
      _isPro =
          _customerInfo?.entitlements.all[_entitlementId]?.isActive ?? false;
      _offerings = await Purchases.getOfferings();
      notifyListeners();
    } catch (e) {
      debugPrint('Error initializing RevenueCat: $e');
    }

    // Listen for customer info updates
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      _customerInfo = customerInfo;
      _isPro = customerInfo.entitlements.all[_entitlementId]?.isActive ?? false;
      notifyListeners();
    });
  }

  Future<bool> purchasePackage(Package package) async {
    try {
      // In the latest version, purchasePackage is often preferred for simple package purchases
      // or using the modern purchase(PurchaseParams) if available.
      // Reverting to purchasePackage as it is more reliable across versions if PurchaseParams is tricky.
      final result = await Purchases.purchase(PurchaseParams.package(package));
      _customerInfo = result.customerInfo;
      _isPro =
          _customerInfo?.entitlements.all[_entitlementId]?.isActive ?? false;
      notifyListeners();
      return true;
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        debugPrint('Purchase error: ${e.message}');
      }
      return false;
    }
  }

  Future<void> restorePurchases() async {
    try {
      _customerInfo = await Purchases.restorePurchases();
      _isPro =
          _customerInfo?.entitlements.all[_entitlementId]?.isActive ?? false;
      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint('Restore error: ${e.message}');
    }
  }

  Future<void> showCustomerCenter() async {
    try {
      await RevenueCatUI.presentCustomerCenter();
    } catch (e) {
      debugPrint('Error showing Customer Center: $e');
    }
  }

  Future<void> logIn(String uid) async {
    try {
      final result = await Purchases.logIn(uid);
      _customerInfo = result.customerInfo;
      _isPro =
          _customerInfo?.entitlements.all[_entitlementId]?.isActive ?? false;
      notifyListeners();
      debugPrint('Successfully logged in to RevenueCat with UID: $uid');
    } catch (e) {
      debugPrint('Error logging in to RevenueCat: $e');
    }
  }

  Future<void> reset() async {
    try {
      await Purchases.logOut();
      _customerInfo = null;
      _isPro = false;
      _offerings = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Error logging out from RevenueCat: $e');
    }
  }
}
