import 'dart:convert';

import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:flutter/material.dart';
import 'package:rise_up/DonorPages/Auth/DonorCompleteProfile.dart';
import 'package:rise_up/lang/locale_keys.g.dart';
import '../../Colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

import '../../MerchantPages/Auth/MerchantCompleteProfile.dart';
import '../../Token.dart';
import '../../Response200.dart';

class SignUpToFillScreen extends StatefulWidget {
  String category;

  SignUpToFillScreen({super.key, required this.category});
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SignUpToFillScreen> {
  String username = "", txtEmail = "", password = "", confirmPassword = "";
  bool firstValue = false;
  bool secondValue = false;

  //TextController to read text entered in text field
  final TextEditingController pass = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          Stack(children: [
            Container(
              height: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("Assets/Images/SignUpBanner.png"),
                      fit: BoxFit.fill)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.04,
                  MediaQuery.of(context).size.width * 0.1,
                  0,
                  0),
              child: GestureDetector(
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.arrow_back,
                    color: orangeColor,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.04,
                  MediaQuery.of(context).size.width * 0.57,
                  MediaQuery.of(context).size.width * 0.1,
                  0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.2,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Assets/Images/Group 46912.png"),
                          fit: BoxFit.fill)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.height * 0.35, 0, 0),
              child: ListTile(
                title: Text(
                  LocaleKeys.BeneficiarySignUpScreen_lblTitle.tr(),
                  style: const TextStyle(
                    fontFamily: "Lucida Sans",
                    color: blueTextColor,
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  LocaleKeys.BeneficiarySignUpScreen_lblSubTitle.tr(),
                  style: const TextStyle(
                    fontFamily: "Open Sans",
                    color: greyTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ]),
          Form(
            key: formKey,
            child: Expanded(
                child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        //Username
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            LocaleKeys.BeneficiarySignUpScreen_lblUserName.tr(),
                            style: const TextStyle(
                              fontFamily: "Lucida Sans",
                              color: blueTextColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Must not be empty";
                              } else if (value.contains(' ')) {
                                return 'Username cannot contain spaces';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                username = value;
                              });
                            },
                            decoration: const InputDecoration(
                              fillColor: greyInputColor,
                              filled: true,
                              labelText: 'Ex: alias',
                              labelStyle: TextStyle(
                                  fontFamily: "Open Sans",
                                  color: greyHintColor),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: greyInputColor,
                                  )),
                            ),
                          ),
                        ),
                        //Email address
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            LocaleKeys.BeneficiarySignUpScreen_lblEmail.tr(),
                            style: const TextStyle(
                              fontFamily: "Lucida Sans",
                              color: blueTextColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Must not be empty";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                txtEmail = value;
                              });
                            },
                            decoration: const InputDecoration(
                              fillColor: greyInputColor,
                              filled: true,
                              labelStyle: TextStyle(
                                  fontFamily: "Open Sans",
                                  color: greyHintColor),
                              labelText: 'Ex: example@gmail.com',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: greyInputColor,
                                  )),
                            ),
                          ),
                        ),
                        //password
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            LocaleKeys.BeneficiarySignUpScreen_lblPass.tr(),
                            style: const TextStyle(
                              fontFamily: "Lucida Sans",
                              color: blueTextColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextFormField(
                            controller: pass,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Must not be empty";
                              }
                              if (!RegExp(
                                      r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)")
                                  .hasMatch(value)) {
                                return "Must contain at least one Capital Letter, \n Small Letters, Numbers & a special character ";
                              } else {
                                return null;
                              }
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: greyInputColor,
                              filled: true,
                              labelStyle: const TextStyle(
                                  fontFamily: "Open Sans",
                                  color: greyHintColor),
                              labelText: LocaleKeys
                                  .BeneficiarySignUpScreen_lblPassHint.tr(),
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: greyInputColor,
                                  )),
                            ),
                          ),
                        ),
                        //confirm password
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            LocaleKeys.BeneficiarySignUpScreen_lblConfirmPass
                                .tr(),
                            style: const TextStyle(
                              fontFamily: "Lucida Sans",
                              color: blueTextColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextFormField(
                            controller: confirmPass,
                            onChanged: (value) {
                              confirmPassword = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty ||
                                  (pass.text != confirmPass.text)) {
                                return "password does not match";
                              } else {
                                return null;
                              }
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: greyInputColor,
                              filled: true,
                              labelStyle: const TextStyle(
                                  fontFamily: "Open Sans",
                                  color: greyHintColor),
                              labelText: LocaleKeys
                                  .BeneficiarySignUpScreen_lblConfirmHint.tr(),
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: greyInputColor,
                                  )),
                            ),
                          ),
                        ),
                        /** Checkbox Widget **/
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: CheckboxListTileFormField(
                            title: Flexible(
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: LocaleKeys
                                          .BeneficiarySignUpScreen_chkContentTxt1part1
                                      .tr(),
                                  style: const TextStyle(
                                      fontFamily: "Open Sans",
                                      fontSize: 15,
                                      color: greyTextColor,
                                      fontWeight: FontWeight.w400),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: LocaleKeys
                                              .BeneficiarySignUpScreen_chkContentSpan1part1
                                          .tr(),
                                      style: const TextStyle(
                                          fontFamily: "Open Sans",
                                          fontSize: 15,
                                          color: navyColor,
                                          fontWeight: FontWeight.w600),
                                      //recognizer: TapGestureRecognizer()..onTap = () =>Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckMailScreen()),)
                                    ),
                                    TextSpan(
                                      text: LocaleKeys
                                              .BeneficiarySignUpScreen_chkContentTxt1part2
                                          .tr(),
                                      style: const TextStyle(
                                          fontFamily: "Open Sans",
                                          fontSize: 15,
                                          color: greyTextColor,
                                          fontWeight: FontWeight.w400),
                                      //recognizer: TapGestureRecognizer()..onTap = () =>Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckMailScreen()),)
                                    ),
                                    TextSpan(
                                      text: LocaleKeys
                                              .BeneficiarySignUpScreen_chkContentSpan1part2
                                          .tr(),
                                      style: const TextStyle(
                                          fontFamily: "Open Sans",
                                          fontSize: 15,
                                          color: navyColor,
                                          fontWeight: FontWeight.w600),
                                      //recognizer: TapGestureRecognizer()..onTap = () =>Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckMailScreen()),)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            checkColor: whiteColor,
                            // color of tick Mark
                            activeColor: redColor,
                            onChanged: (bool value) {
                              setState(() {
                                firstValue = value;
                              });
                            },
                            validator: (value) {
                              if (value!) {
                                return null;
                              } else {
                                return 'Must be checked';
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: CheckboxListTileFormField(
                            title: Flexible(
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: LocaleKeys
                                          .BeneficiarySignUpScreen_chkContentTxt2
                                      .tr(),
                                  style: const TextStyle(
                                      fontFamily: "Open Sans",
                                      fontSize: 15,
                                      color: greyTextColor,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            checkColor: whiteColor,
                            // color of tick Mark
                            activeColor: redColor,
                            validator: (value) {
                              if (value!) {
                                return null;
                              } else {
                                return 'Must be checked!';
                              }
                            },
                            onChanged: (bool value) {
                              setState(() {
                                secondValue = value;
                              });
                            },
                          ),
                        )
                      ],
                    );
                  }),
            )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                0,
                MediaQuery.of(context).size.height * 0.03,
                0,
                MediaQuery.of(context).size.height * 0.03),
            child: Center(
                child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(navyColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ))),
                onPressed: () async {
                  //if the form is validated send api
                  if (formKey.currentState!.validate()) {
                    bool chk = true;
                    if (widget.category == "Merchant") {
                      print(widget.category);
                      Map response = await MerchantRegister(
                          username, txtEmail, password, chk);
                      var tokenresponse = response["token"];
                      if (response['success'] == true) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MerchantCompleteProfile(
                                  tokenId: merchanttokenid,
                                  tokenbody: tokenresponse)),
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 16,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const SizedBox(height: 20),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "Assets/Images/ErrorIcon.png"),
                                                fit: BoxFit.fill)),
                                      ),
                                      const Center(
                                          child: Text('Sorry!',
                                              style: TextStyle(
                                                fontFamily: "Lucida Sans",
                                                color: navyColor,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600,
                                              ))),
                                      const Center(
                                          child: Text(
                                              'An active application exists. You are not eligible to apply again at this moment',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: "Open Sans",
                                                color: greyTextColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ))),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04),
                                        child: Center(
                                            child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(navyColor),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ))),
                                            onPressed: () {
                                              // Navigator.push(
                                              // context,
                                              //MaterialPageRoute(
                                              //builder: (context) =>  const LoginScreen()),
                                              //);
                                            },
                                            child: const Text(
                                              "LEARN MORE",
                                              style: TextStyle(
                                                color: whiteColor,
                                                fontFamily: "Lucida Sans",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    } else if (widget.category == "Donor") {
                      bool chk1 = true;
                      bool chk2 = true;
                      print(widget.category);
                      Map response = await DonorRegister(
                          username, txtEmail, password, chk1, chk2);
                      var tokenresponse = response["token"];
                      if (response['success'] == true) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DonorCompleteProfile(
                                  tokenId: donortokenid,
                                  tokenbody: tokenresponse)),
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 16,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const SizedBox(height: 20),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "Assets/Images/ErrorIcon.png"),
                                                fit: BoxFit.fill)),
                                      ),
                                      const Center(
                                          child: Text('Sorry!',
                                              style: TextStyle(
                                                fontFamily: "Lucida Sans",
                                                color: navyColor,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600,
                                              ))),
                                      const Center(
                                          child: Text(
                                              'An active application exists. You are not eligible to apply again at this moment',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: "Open Sans",
                                                color: greyTextColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ))),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04),
                                        child: Center(
                                            child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(navyColor),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ))),
                                            onPressed: () {
                                              // Navigator.push(
                                              // context,
                                              //MaterialPageRoute(
                                              //builder: (context) =>  const LoginScreen()),
                                              //);
                                            },
                                            child: const Text(
                                              "LEARN MORE",
                                              style: TextStyle(
                                                color: whiteColor,
                                                fontFamily: "Lucida Sans",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }
                  } //else if not validate
                  else {
                    print("UnSuccessfull");
                  }
                },
                child: Text(
                  LocaleKeys.BeneficiarySignUpScreen_btnSign.tr(),
                  style: const TextStyle(
                    color: whiteColor,
                    fontFamily: "Lucida Sans",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}

var merchanttokenid;
Future<Map> MerchantRegister(
    String userName, String email, String pass, bool chk) async {
  var body = jsonEncode({
    'email': email,
    'userName': userName,
    'password': pass,
    'becontacted': chk,
  });
  print("begin");
  print("the username is $userName");
  var response = await http.post(
      Uri.parse('https://rise.anzimaty.com/api/Merchant/Register'),
      body: body,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });
  Response200 response200 = response200FromMap(response.body);
  //handle api response
  if (response.statusCode == 200) {
    print('response DonorRegister 200');
    //decode response body
    Response200 response200 = response200FromMap(response.body);
    var tokenMap = Token().parseJwt(response200.token);
    print('Token Map : $tokenMap');
    merchanttokenid = tokenMap['Id'];
    print(donortokenid);
  }
  Map result = json.decode(response.body);
  print(response.body);
  return result;
}

var donortokenid;
Future<Map> DonorRegister(
    String userName, String email, String pass, bool chk1, chk2) async {
  var body = jsonEncode({
    'email': email,
    'username': userName,
    'password': pass,
    'showName': chk1,
    'beAnonymous': chk2,
  });
  print("begin");
  print("the username is $userName");
  var response = await http.post(
      Uri.parse('https://rise.anzimaty.com/api/Donor/Register'),
      body: body,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });
  Response200 response200 = response200FromMap(response.body);
  //handle api response
  if (response.statusCode == 200) {
    print('response DonorRegister 200');
    //decode response body
    Response200 response200 = response200FromMap(response.body);
    var tokenMap = Token().parseJwt(response200.token);
    print('Token Map : $tokenMap');
    donortokenid = tokenMap['Id'];
    print(donortokenid);
  }
  Map result = json.decode(response.body);
  print(response.body);
  return result;
}
