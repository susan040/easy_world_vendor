import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Rx<GoogleSignInAccount?> googleUser = Rx<GoogleSignInAccount?>(null);

  Future<void> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      googleUser.value = account;
      if (account != null) {
        Get.snackbar("Signed In", "Hello, ${account.displayName}");
      }
    } catch (e) {
      Get.snackbar("Error", "Google Sign-In failed: $e");
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    googleUser.value = null;
    Get.snackbar("Signed Out", "You have been signed out");
  }
}
