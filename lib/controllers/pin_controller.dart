import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../core/helpers/local_storage.dart';
import '../features/auth/pin/pin_screen.dart';
import '../features/auth/pin/pin_setup_screen.dart';

class PinController extends GetxController {
  final RxnString uid = RxnString();
  RxBool isPinSet = false.obs;
  RxBool isLoading = false.obs;
  RxString message = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // Listen for account changes
    FirebaseAuth.instance.userChanges().listen((user) async {
      uid.value = user?.uid;
      if (uid.value != null) {
        await checkPinStatus();
        // if user has set up their PIN redirect them to PINScreen
        // to enter their PIN, else let them create their PIN
        if (isPinSet.value) {
          Get.offAll(() => PINScreen());
        } else {
          Get.offAll(() => PinSetupScreen());
        }
      } else {
        isPinSet.value = false;
      }
    });
  }

  Future<void> checkPinStatus() async {
    if (uid.value == null) return;
    isLoading.value = true;
    String? pinHash = await LocalDB.getPin(uid.value!);
    isPinSet.value = pinHash != null;
    isLoading.value = false;
  }

  Future<bool> verifyPin(String pin) async {
    if (uid.value == null) {
      message.value = "No user logged in";
      return false;
    }

    isLoading.value = true;
    try {
      bool isCorrectPIN = await LocalDB.verifyPin(uid.value!, pin);
      if (!isCorrectPIN) {
        message.value = 'Incorrect PIN! Please try again.';
      }
      return isCorrectPIN;
    } catch (e) {
      message.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> savePin(String pin) async {
    if (uid.value == null) {
      message.value = 'User is logged out!';
      return false;
    }
    try {
      await LocalDB.savePin(uid.value!, pin);
      message.value = 'PIN created & saved successully!';
      isPinSet.value = true;

      return true;
    } catch (e) {
      message.value = e.toString();
      return false;
    }
  }
}
