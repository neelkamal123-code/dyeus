
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:stacked/stacked.dart';

class OtpViewModel extends BaseViewModel{

  OtpViewModel(this.verificationIdRecieved);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  String verificationIdRecieved;


  TextEditingController controller = TextEditingController();
  int timerCount = 30;
  String verificationIdR="";
  FirebaseAuth auth=FirebaseAuth.instance;
  bool isTextResendLoading = false;
  late Timer _timer;
  Future startTimer() async {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      timerCount--;
      notifyListeners();
      if (timerCount == 0) {
        _timer.cancel();
      }
    });
  }
  Future resendOTP(String phoneNumber, String type) async {
    bool isTextResendLoading = true;
    await SmsAutoFill().listenForCode;
    auth.verifyPhoneNumber(phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) => {
            print("logged in")
          });

        },
        verificationFailed: (FirebaseAuthException exception){
          print(exception.message);
          isTextResendLoading=false;
        },
        codeSent: (String verificationId,int? resendToken){
        print("in here buddy");
          verificationIdRecieved=verificationId;
          timerCount=30;
          isTextResendLoading=false;
          startTimer();
          notifyListeners();

          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>OtpView(phoneNumber: phoneNumber)));
        },
        codeAutoRetrievalTimeout: (String verificationId){

        }
    );
  }

  void verifyCode(context)async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationIdRecieved, smsCode: controller.text);
    try{
      await auth.signInWithCredential(credential).then((value){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("we are logged in!!")));
      });
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Otp")));
    }
  }

}