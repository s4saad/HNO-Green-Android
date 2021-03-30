import 'package:dokanamar_driver/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import '../constant.dart';

class signIn extends StatefulWidget {
  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7 /2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/splash2.png"
                      ),
                      fit: BoxFit.cover
                  )
              ),
              padding: EdgeInsets.all(20),
            ),
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: MediaQuery.of(context).size.height * 0.4,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Log in",
                        style: headingStyle.merge(TextStyle(color: blackColor, fontWeight: FontWeight.bold, fontSize: 28)),
                        children: <TextSpan>[
                          TextSpan(
                            text: " with your phone number.",
                            style: headingStyle.merge(TextStyle(color: blackColor,fontSize: 28)),
                          )
                        ]
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
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> OTPScreen()));
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: blackColor,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(
                          child: Text(
                            "NEXT",
                            style: headingStyle.merge(TextStyle(color: whiteColor, fontWeight: FontWeight.bold)),
                          )
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
