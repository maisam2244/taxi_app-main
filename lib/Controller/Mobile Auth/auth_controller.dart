import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  String userUid = "";
  var verId = "";
  int? resendTokenId;
  bool phoneAuthCheck = false;
  dynamic credentials;

  phoneAuth(String phone) async{
    try{
      credentials = null;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("Completed");
          credentials = credential;
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        forceResendingToken: resendTokenId,
        verificationFailed: (FirebaseAuthException e) {
          print("Failed");
          if (e.code == 'invalid-phone-number') {
            Get.snackbar("Error", "The provided phone number is not valid");
          }
        },
        codeSent: (String verificationId, int? resendToken) async{
          print("CodeSent");
          resendTokenId = resendToken;
          verId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},

      );
    } catch(e){
      print("Error Occured $e");
    }
  }

  verifyOtp(String otpNumber) async{
    print("called");
    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(
      verificationId: verId, 
      smsCode: otpNumber
    );

    print("Logged In");

    await FirebaseAuth.instance
    .signInWithCredential(credential);

    
  }
}