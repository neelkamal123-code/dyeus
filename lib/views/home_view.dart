import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:stacked/stacked.dart';
import '../viewmodels/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key, required this.heading, required this.byLine}) : super(key: key);
  final String heading;
  final String byLine;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeModel>.reactive(
        viewModelBuilder: () => HomeModel(heading,byLine),
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: Column(

            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children:[
                    GestureDetector(
                      onTap:(){
                        model.signInTap();
                    },
                      child:Chip(
                        elevation: 5,
                        padding: const EdgeInsets.all(8),
                        backgroundColor: model.signinColor,
                        shadowColor: Colors.black,
                        label: const Text(
                          'Signin',
                          style: TextStyle(fontSize: 15),
                        ), //Text
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        model.signUpTap();
                      },
                      child: Chip(
                        elevation: 5,
                        padding: const EdgeInsets.all(8),
                        backgroundColor: model.signupColor,
                        shadowColor: Colors.black,
                        label: const Text(
                          'Signup',
                          style: TextStyle(fontSize: 15),
                        ), //Text
                      ),
                    ),

                  ],
                ),
              ),
              Expanded(
                flex: 9,
                child: ListView(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      child: Text(
                        model.signHeading,
                        // "Welcome Back!!",
                        style:
                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        // "Please login with your phone number.",
                        model.signLine,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                      child: IntlPhoneField(
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          // print(phone.completeNumber);
                          model.changePhone(phone.completeNumber);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                      child: GestureDetector(
                        onTap: (model.phoneNumber.length==13)?(){
                          model.verifyPhone(context);
                        }:(){},
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color:  (model.phoneNumber.length==13)?const Color(0xFFBFFB62):Colors.grey,
                          ),
                          child: (model.isLoading)?const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.black),
                          ):const Center(
                            child: Text(
                              'Continue',
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

                    //----or---section
                    Row(children: const [
                      Expanded(
                          child: Divider(
                            thickness: 2,
                            endIndent: 12,
                          )),
                      Text(
                        "OR",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Expanded(
                          child: Divider(
                            thickness: 2,
                            indent: 12,
                          ))
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        GoogleAuthButton(
                          onPressed: () {},
                          style: const AuthButtonStyle(
                            buttonType: AuthButtonType.secondary,
                          ),
                          text: 'Connect to Google',
                        ),
                        AppleAuthButton(
                          onPressed: () {},
                          darkMode: true,
                          text: 'Connect to Apple',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: (){
                            model.signUpTap();
                          },
                          child: const Text(
                            "Signup",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffBFFB62)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ));
  }
}
