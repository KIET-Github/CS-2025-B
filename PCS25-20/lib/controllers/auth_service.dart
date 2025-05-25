import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static String verifyId = "";

  static Future<void> sentOtp({
    required String phone,
    required Function errorStep,
    required Function nextStep,
  }) async {
    await _firebaseAuth
        .verifyPhoneNumber(
      timeout: Duration(seconds: 30),
      phoneNumber: "+91$phone",
      verificationCompleted: (PhoneAuthCredential credential) async {
        // This callback is called when auto-retrieval or instant verification is triggered
        // You can handle automatic verification here if needed
        // For example, you might directly sign in the user
        // _signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle the verification failure here
        errorStep();
        print("Verification failed: ${e.message}");
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        // Save the verification ID somewhere to use it later in the login process
        verifyId = verificationId;
        nextStep();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // This callback is called when the auto-retrieval of the OTP times out
        // You might handle it if necessary
        print("Auto retrieval timeout");
      },
    )
        .catchError((error) {
      errorStep();
      print("Error sending OTP: $error");
    });
  }

  static Future<String> loginWithOtp({required String otp}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifyId,
        smsCode: otp,
      );
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      // Check if user is successfully logged in
      if (userCredential.user != null) {
        return "Success";
      } else {
        return "Error in OTP login";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  static Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  static Future<bool> isLoggedIn() async {
    final User? user = _firebaseAuth.currentUser;
    return user != null;
  }
}
