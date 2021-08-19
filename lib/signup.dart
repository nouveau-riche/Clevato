import 'dart:convert';

import 'package:claveto/common/keys.dart';
import 'package:claveto/home.dart';
import 'package:claveto/model/register_fail.dart';
import 'package:claveto/model/register_success.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

import 'common/constant.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var genderController = TextEditingController();
  var dobController = TextEditingController();
  var stateController = TextEditingController();
  var cityController = TextEditingController();
  var pincodeController = TextEditingController();

  String gender;
  List<String>genderList=["Male","Female"];
  DateTime selectedDate;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  validateInputs(
      name, email, password, phone,/* gender, dob, state, city, pincode*/) {
    if (GetUtils.isNullOrBlank(name)) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("Name Can't be empty",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    } else if (GetUtils.isNullOrBlank(email)) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("Email Can't be empty",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    } else if (GetUtils.isNullOrBlank(password)) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("Password Can't be empty",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    } else if (GetUtils.isNullOrBlank(phone)) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("PhoneNumber Can't be empty",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    }
    /*else if (GetUtils.isNullOrBlank(gender)) {
      print('Gender value ${gender}');
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("Gender Can't be empty",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    } else if (GetUtils.isNullOrBlank(dob)) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("Birth Date Can't be empty",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    } else if (GetUtils.isNullOrBlank(state)) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("State Can't be empty",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    } else if (GetUtils.isNullOrBlank(city)) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("City Can't be empty",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    } else if (GetUtils.isNullOrBlank(pincode)) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("Pincode Can't be empty",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    }*/
    else {
      registerAPI();
    }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: ZigZagClipper(),
              child: Container(
                height: 190.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff14B4A5),
                    Color(0xff3883EF),
                  ],
                ),),
                child: Center(child: Text("SignUp",style: TextStyle(color: Colors.white,fontSize: 35),)),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xff14B4A5),
                          Color(0xff3883EF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(590)),
                  child: Container(
                    padding: EdgeInsets.only(top: 4,bottom: 2,left:5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(590)),
                    child: TextFormField(
                      controller: nameController,
                      decoration: new InputDecoration(
                        enabledBorder:  OutlineInputBorder(
                          borderSide:  BorderSide(
                              color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 0.0),

                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: new EdgeInsets.fromLTRB(
                            10,5,10,30),
                        labelText: " Full Name",
                        labelStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 20)),
                        fillColor: Colors.white,
                        //  filled: true,
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xff14B4A5),
                          Color(0xff3883EF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(590)),
                  child: Container(
                    padding: EdgeInsets.only(top: 4,bottom: 2,left:5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(590)),
                    child: TextFormField(
                      controller: emailController,
                      decoration: new InputDecoration(
                        enabledBorder:  OutlineInputBorder(
                          borderSide:  BorderSide(
                              color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 0.0),

                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: new EdgeInsets.fromLTRB(
                            10,5,10,30),
                        labelText: " Email",
                        alignLabelWithHint: true,
                        labelStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 20)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        fillColor: Colors.white,
                        filled: true,
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xff14B4A5),
                          Color(0xff3883EF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(590)),
                  child: Container(
                    padding: EdgeInsets.only(top: 4,bottom: 2,left:5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(590)),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: new InputDecoration(
                        enabledBorder:  OutlineInputBorder(
                          borderSide:  BorderSide(
                              color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 0.0),

                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: new EdgeInsets.fromLTRB(
                            10,5,10,30),
                        labelText: "Password",
                        labelStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 20)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        fillColor: Colors.white,
                        filled: true,
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xff14B4A5),
                          Color(0xff3883EF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(590)),
                  child: Container(
                    padding: EdgeInsets.only(top: 4,bottom: 2,left:5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(590)),
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        enabledBorder:  OutlineInputBorder(
                          borderSide:  BorderSide(
                              color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 0.0),

                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: new EdgeInsets.fromLTRB(
                            20,5,10,30),
                        prefixIcon: Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.only(left: 0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color(0xff14B4A5),
                                Color(0xff3883EF),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Container(
                              child: Text(
                                '+91',
                                style: GoogleFonts.montserrat(
                                    textStyle:
                                    TextStyle(color: Colors.white, fontSize: 20)),
                              )),
                        ),
                        hintText: " Phone Number",
                        hintStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 20)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        fillColor: Colors.white,
                        filled: true,
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                //   padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                //   decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //         begin: Alignment.bottomCenter,
                //         end: Alignment.topCenter,
                //         colors: [
                //           Color(0xff14B4A5),
                //           Color(0xff3883EF),
                //         ],
                //       ),
                //       borderRadius: BorderRadius.circular(590)),
                //   child:   Container(
                //     height: 60,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(35.0),
                //       border: Border.all( width: 0.80),
                //       color: Colors.white,
                //     ),
                //     child: Padding(
                //         padding: const EdgeInsets.all(15.0),
                //         child:DropdownButtonHideUnderline(
                //           child: DropdownButton<String>(
                //             items: genderList.map((item) {
                //               return new DropdownMenuItem(
                //                 child: Text( item,style: GoogleFonts.montserrat(
                //                     textStyle: TextStyle(
                //                         color: Colors.black.withOpacity(0.5),
                //                         fontSize: 20))),
                //                 value:item,
                //                 //value: item.id.toString(),
                //               );
                //             }).toList(),
                //             onChanged: (String value) {
                //
                //               print('Gender in drop down $gender');
                //               setState(() {
                //                 gender = value;
                //               });
                //               print('Gender in drop down 1 $gender');
                //             },
                //             hint:Text("All", style: GoogleFonts.montserrat(
                //                 textStyle: TextStyle(
                //                     color: Colors.black.withOpacity(0.5),
                //                     fontSize: 20))),
                //             value: gender,
                //             isExpanded: true,
                //             icon:Container(
                //               padding: EdgeInsets.all(5),
                //               child: Container(
                //                   margin: EdgeInsets.all(0),
                //                   height: 20,
                //                   width: 20,
                //                   child: Image.asset(
                //                     "assets/senddown.png",
                //                   )),
                //             ),
                //           ),
                //         )
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                //   padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                //   decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //         begin: Alignment.bottomCenter,
                //         end: Alignment.topCenter,
                //         colors: [
                //           Color(0xff14B4A5),
                //           Color(0xff3883EF),
                //         ],
                //       ),
                //       borderRadius: BorderRadius.circular(590)),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.all(new Radius.circular(35.0)),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.all(5.0),
                //       child: GestureDetector(
                //         onTap: () => _selectDate(context),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: <Widget>[
                //             Padding(
                //               padding: const EdgeInsets.only(left:8.0),
                //               child: Text(
                //                   selectedDate != null
                //                       ?  DateFormat("yyyy-MM-dd").format(selectedDate)
                //                       : "Birth Date",
                //                   // : DateFormat("yyyy-MM-dd").format(selectedDate),
                //                   style: GoogleFonts.montserrat(
                //                       textStyle: TextStyle(
                //                           color: Colors.black.withOpacity(0.5),
                //                           fontSize: 20))),
                //             ),
                //             Container(
                //               padding: EdgeInsets.all(15),
                //               margin: EdgeInsets.only(right: 3),
                //               decoration: BoxDecoration(
                //                 gradient: LinearGradient(
                //                   begin: Alignment.topLeft,
                //                   end: Alignment.topRight,
                //                   colors: [
                //                     Color(0xff14B4A5),
                //                     Color(0xff3883EF),
                //                   ],
                //                 ),
                //                 borderRadius: BorderRadius.circular(50),
                //               ),
                //               child: Container(
                //                   padding: EdgeInsets.symmetric(horizontal: 3),
                //                   child: FaIcon(
                //                     FontAwesomeIcons.calendarAlt,
                //                     color: Colors.white,
                //                     size: 20,
                //                   )),
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                //   padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                //   decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //         begin: Alignment.bottomCenter,
                //         end: Alignment.topCenter,
                //         colors: [
                //           Color(0xff14B4A5),
                //           Color(0xff3883EF),
                //         ],
                //       ),
                //       borderRadius: BorderRadius.circular(590)),
                //   child: TextFormField(
                //     controller: stateController,
                //     decoration: new InputDecoration(
                //       suffixIcon: Container(
                //         padding: EdgeInsets.all(15),
                //         child: Container(
                //             margin: EdgeInsets.all(0),
                //             height: 10,
                //             width: 10,
                //             child: Image.asset(
                //               "assets/senddown.png",
                //             )),
                //       ),
                //       labelText: " State",
                //       labelStyle: GoogleFonts.montserrat(
                //           textStyle: TextStyle(
                //               color: Colors.black.withOpacity(0.5),
                //               fontSize: 20)),
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(50)),
                //       fillColor: Colors.white,
                //       filled: true,
                //       //fillColor: Colors.green
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                //   padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                //   decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //         begin: Alignment.bottomCenter,
                //         end: Alignment.topCenter,
                //         colors: [
                //           Color(0xff14B4A5),
                //           Color(0xff3883EF),
                //         ],
                //       ),
                //       borderRadius: BorderRadius.circular(590)),
                //   child: TextFormField(
                //     controller: cityController,
                //     decoration: new InputDecoration(
                //       suffixIcon: Container(
                //         padding: EdgeInsets.all(15),
                //         child: Container(
                //             margin: EdgeInsets.all(0),
                //             height: 10,
                //             width: 10,
                //             child: Image.asset(
                //               "assets/senddown.png",
                //             )),
                //       ),
                //       labelText: " City",
                //       labelStyle: GoogleFonts.montserrat(
                //           textStyle: TextStyle(
                //               color: Colors.black.withOpacity(0.5),
                //               fontSize: 20)),
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(50)),
                //       fillColor: Colors.white,
                //       filled: true,
                //       //fillColor: Colors.green
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                //   padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                //   decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //         begin: Alignment.bottomCenter,
                //         end: Alignment.topCenter,
                //         colors: [
                //           Color(0xff14B4A5),
                //           Color(0xff3883EF),
                //         ],
                //       ),
                //       borderRadius: BorderRadius.circular(590)),
                //   child: Container(
                //     padding: EdgeInsets.only(top: 4,bottom: 2,left:5),
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(590)),
                //     child: TextFormField(
                //       controller: pincodeController,
                //       decoration: new InputDecoration(
                //         enabledBorder:  OutlineInputBorder(
                //           borderSide:  BorderSide(
                //               color: Colors.white, width: 0.0),
                //           borderRadius: BorderRadius.circular(30.0),
                //         ),
                //         focusedBorder:OutlineInputBorder(
                //           borderSide: const BorderSide(color: Colors.white, width: 0.0),
                //
                //           borderRadius: BorderRadius.circular(30.0),
                //         ),
                //         contentPadding: new EdgeInsets.fromLTRB(
                //             10,5,10,30),
                //         labelText: " Pincode",
                //         labelStyle: GoogleFonts.montserrat(
                //             textStyle: TextStyle(
                //                 color: Colors.black.withOpacity(0.5),
                //                 fontSize: 20)),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(50)),
                //         fillColor: Colors.white,
                //         filled: true,
                //         //fillColor: Colors.green
                //       ),
                //     ),
                //   ),
                // ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
//                    boxShadow: [
//                      BoxShadow(
//                        color: Colors.black,
//                        offset: Offset(5.0, 5.0), //(x,y)
//                        blurRadius: 55.0,
//                      ),
//                    ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xff14B4A5),
                          Color(0xff3883EF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(590)),
                  child: MaterialButton(
                      child: Text(
                        'Register',
                        style: GoogleFonts.montserrat(
                            textStyle:
                            TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                      onPressed: () {
                        validateInputs(
                            nameController.text,
                            emailController.text,
                            phoneController.text,
                            passwordController.text,
                            // gender,//genderController.text,
                            // selectedDate,
                            // stateController.text,
                            // cityController.text,
                            // pincodeController.text
                        );
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => Signup()),
//                  );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> registerAPI() async {
    //showDialog(context: context, builder: (context) => Loading());

    await register(
            nameController.text,
            emailController.text,
            phoneController.text,
            passwordController.text,
            // gender,
            // selectedDate.toString(),
            // stateController.text,
            // cityController.text,
            // pincodeController.text
    )
        .then((onValue) {
      if (onValue.toString().contains("message")) {
        Map<String, dynamic> temp = json.decode(onValue);
        Get.rawSnackbar(
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            messageText: Text(temp["message"],
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 17))),
            padding: EdgeInsets.all(20),
            borderRadius: 10,
            margin: EdgeInsets.all(15));
      } else {
        print("else");
        Map<String, dynamic> temp = json.decode(onValue);
        Get.rawSnackbar(
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            messageText: Text("Register SuccessFull",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 17))),
            padding: EdgeInsets.all(20),
            borderRadius: 10,
            margin: EdgeInsets.all(15));
        print(temp["access_token"]);
        setPrefValue(Keys.TOKEN, temp["access_token"]);
        setPrefValue(Keys.NAME,nameController.text);
      setPrefValue(Keys.DOB,selectedDate.toString());
      setPrefValue(Keys.GENDER,gender);
      setPrefValue(Keys.PHONE,phoneController.text);
      setPrefValue(Keys.EMAIL,emailController.text);

        setPrefValue(Keys.ADDRESS,stateController.text+" "+ cityController.text);
      //setPrefValue(Keys.BLOOD_GROUP,blo));

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    });
    setState(() {});
  }


}
class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 50, size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

