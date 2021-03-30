import 'package:dokanamar_driver/constant.dart';
import 'package:dokanamar_driver/screens/signIn.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class signUp extends StatefulWidget {
  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: blackColor.withOpacity(0.1),
                      offset: Offset(0, 0),
                      blurRadius: 13,
                      spreadRadius: 8
                  )
                ]
            ),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.7 /2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/splash2.png"
                      ),
                      fit: BoxFit.cover
                    )
                  ),
                  padding: EdgeInsets.all(20),
                  child: RichText(
                    text: TextSpan(
                        text: "Sign up",
                        style: headingStyle.merge(TextStyle(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 28)),
                        children: <TextSpan>[
                          TextSpan(
                            text: " with email and phone number.",
                            style: headingStyle.merge(TextStyle(color: whiteColor,fontSize: 28)),
                          )
                        ]
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.1),
                          ),
                          borderRadius: BorderRadius.circular(5)
                          ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "name@example.com",
                            contentPadding: EdgeInsets.all(10),
                            hintStyle: headingStyle.merge(TextStyle(color: Colors.black.withOpacity(0.4)))
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.1),
                                ),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: CountryCodePicker(
                              textStyle: headingStyle,
                              initialSelection: 'IT',
                              favorite: ['+39','FR'],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: "+84 33 544644646",
                                    contentPadding: EdgeInsets.all(10),
                                    hintStyle: headingStyle.merge(TextStyle(color: Colors.black.withOpacity(0.4)))
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: blackColor,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child: Text(
                            "SIGN UP",
                            style: headingStyle.merge(TextStyle(color: whiteColor, fontWeight: FontWeight.bold)),
                          )
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
          heightSpace,
          heightSpace,
          heightSpace,
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> signIn()));
            },
            child: Text(
              "Already have an account? Sign in",
              style: searchTextStyle.merge(TextStyle(color: Colors.black)),
            ),
          )
        ],
      ),
    );
  }
}
