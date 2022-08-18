import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_work/views/confirm_otp_view.dart';

import 'package:stacked/stacked.dart';


class HomeModel extends BaseViewModel{
  HomeModel(this.heading,this.byLine);

  FirebaseAuth auth=FirebaseAuth.instance;
  String verificationIdR="";
  String heading;
  String byLine;

  bool isLoading=false;

  Color signupColor=Colors.white;
  Color signinColor=Color(0xFFBFFB62);

  String signHeading="Welcome Back!!";
  String signLine="Please login with your phone number.";
  String phoneNumber="";


  void signUpTap(){
    signHeading="Welcome to App";
    signLine="Please signup with your phone number to get registered.";
    signupColor=Color(0xFFBFFB62);
    signinColor=Colors.white;
    notifyListeners();
  }
  void signInTap(){
    signHeading="Welcome Back!!";
    signLine="Please login with your phone number.";
    signupColor=Colors.white;
    signinColor=Color(0xFFBFFB62);
    notifyListeners();
  }

  void changePhone(phone){
    phoneNumber=phone;
    notifyListeners();
  }

  void verifyPhone(context){
    isLoading=true;
    auth.verifyPhoneNumber(phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) => {
          print("logged in")
        });

        },
        verificationFailed: (FirebaseAuthException exception){
        print(exception.message);
        isLoading=false;
        },
        codeSent: (String verificationId,int? resendToken){
        verificationIdR=verificationId;
        isLoading=false;
        notifyListeners();
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>OtpView(phoneNumber: phoneNumber,verification  :verificationIdR)));
        },
        codeAutoRetrievalTimeout: (String verificationId){

        }
        );
  }

}