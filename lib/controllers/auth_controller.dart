import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';


class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  Rxn<UserModel> user = Rxn<UserModel>();
  RxBool isLoading = false.obs;
  RxBool hasReadTermsAndConditions = false.obs;
  RxBool rememberMe = false.obs;
  RxnString errorMessage = RxnString();

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      user.value = await _authService.login(email, password);
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? 'Login failed';
      user.value = null;
    } catch (e) {
      errorMessage.value = 'Something went wrong';
      user.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup(String email, String password) async {
    isLoading.value = true;
    try {
      user.value = await _authService.signup(email, password);
    } on FirebaseAuthException catch(e) {
      errorMessage.value = e.message ?? "Couldn't create an account for you! Please try again later.";
      user.value = null;
    } catch (e) {
      errorMessage.value = 'Something went wrong';
      user.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(String email) async {
    isLoading.value = true;
    try {
      await _authService.resetPassword(email);
    } finally {
      isLoading.value = false;
    }
  }
}
