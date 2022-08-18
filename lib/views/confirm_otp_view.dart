import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_work/viewmodels/confirm_otp_view_model.dart';
import 'package:stacked/stacked.dart';

class OtpView extends StatelessWidget {
  OtpView({Key? key,required this.phoneNumber,required this.verification}) : super(key: key);
  final String phoneNumber;
  final String verification;


  String  resendOtp() {
    Future.delayed(const Duration(),
            () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    return "RESEND OTP";
  }

  String resendOtpIn(model) {
    // Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    return "RESEND OTP in ${model.timerCount}";
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpViewModel>.reactive(
        viewModelBuilder: ()=>OtpViewModel(verification),
        onModelReady: (model) => model.startTimer(),
        builder:(context,model,child)=>Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: ListView(
            children: [
              const Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Enter OTP",
                  // "Welcome Back!!",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  // "Please login with your phone number.",
                  "An five digit code has been sent to $phoneNumber",
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 15),
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      // "Please login with your phone number.",
                      "Incorrect number ?",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 15),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        // "Please login with your phone number.",
                        "Change",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15,color: Color(0xFFBFFB62)),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 100,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller:model.controller,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: "OTP",
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: "Enter OTP",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                child: GestureDetector(
                  onTap: (){
                  model.verifyCode(context);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color:  const Color(0xFFBFFB62),
                    ),
                    child: const Center(
                      child: Text(
                        'Verify',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),

              Text(
                model.timerCount == 0 ? resendOtp() : resendOtpIn(model),
                textAlign: TextAlign.center,
              ),
              Visibility(
                visible: model.timerCount==0,
                child: Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () => model.resendOTP(phoneNumber, "text"),
                    child: model.isTextResendLoading
                        ? const CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation(Colors.white),
                    )
                        : const Text("Resend",style: TextStyle(color: Colors.black),),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFBFFB62)),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
