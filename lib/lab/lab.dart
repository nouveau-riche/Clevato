import 'package:claveto/model/home_screen_model.dart';
import 'package:claveto/reviews/reviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../book_appointment.dart';
import '../signup.dart';

class LabScreen extends StatefulWidget {
  final Lab lab;

  const LabScreen({Key key, this.lab}) : super(key: key);
  @override
  _LabScreenState createState() => _LabScreenState();
}


class _LabScreenState extends State<LabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lab\'s'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff14B4A5),
                Color(0xff3883EF),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [SizedBox(height: 15,),

            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RichText(textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color:
                            Colors.lightBlueAccent.withOpacity(0.7),
                            fontSize: 30)),
                    children: [
                      TextSpan(
                        text: widget.lab.legalName
                         )
                    ],
                    text: widget.lab.firstName == null
                        ? ' '
                        : widget.lab.firstName + ' ',
                  )),
            ),
            SizedBox(height: 15,),
            Container(
              child: Column(
                children: [
                  Material(elevation: 5,borderRadius: BorderRadius.circular(99),color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.all(1),
                      padding: EdgeInsets.all(5),

                      child: CircleAvatar(
                        maxRadius: 90,

                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RichText(textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color:
                                  Colors.lightBlueAccent.withOpacity(0.7),
                                  fontSize: 30)),
                          children: [
                            TextSpan(
                                text: widget.lab.middleName == null
                                    ? 'Dr '
                                    : widget.lab.middleName + ' ',
                                children: [
                                  TextSpan(
                                    text: widget.lab.lastName == null
                                        ? ' '
                                        : widget.lab.lastName,
                                  )
                                ])
                          ],
                          text: widget.lab.firstName == null
                              ? ' '
                              : widget.lab.firstName + ' ',
                        )),
                  ),
                  // Container(
                  //     margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  //     child: Text(
                  //         widget.doctorDetail.firstName +
                  //             " " +
                  //             widget.doctorDetail.middleName +
                  //             widget.doctorDetail.lastName,
                  //         textAlign: TextAlign.center,
                  //         style: GoogleFonts.montserrat(
                  //             textStyle: TextStyle(
                  //                 color:
                  //                     Colors.lightBlueAccent.withOpacity(0.7),
                  //                 fontSize: 30)))),
                  // Container(
                  //     child: Text(,
                  //         textAlign: TextAlign.center,
                  //         style: GoogleFonts.montserrat(
                  //             textStyle: TextStyle(
                  //                 color: Colors.black, fontSize: 15)))),
                ],
              ),
            ),
            Container( margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Material(elevation: 3,borderRadius: BorderRadius.circular(15),color: Colors.white,
                child: Container(

                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),

                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Address: ",
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.lightBlueAccent.withOpacity(0.7),
                                    fontSize: 20)),
                          ),
                          Container(width: 180,
                            child: Text(
                              widget.lab.address,
                              style: GoogleFonts.montserrat(
                                  textStyle:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                            ),
                          ),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "State: ",
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.lightBlueAccent.withOpacity(0.7),
                                    fontSize: 20)),
                          ),
                          Text(
                            widget.lab.state,
                            style: GoogleFonts.montserrat(
                                textStyle:
                                TextStyle(color: Colors.black, fontSize: 15)),
                          ),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "City: ",
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.lightBlueAccent.withOpacity(0.7),
                                    fontSize: 20)),
                          ),
                          Text(
                            widget.lab.city,
                            style: GoogleFonts.montserrat(
                                textStyle:
                                TextStyle(color: Colors.black, fontSize: 15)),
                          ),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pin code: ",
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.lightBlueAccent.withOpacity(0.7),
                                    fontSize: 20)),
                          ),
                          Text(
                            widget.lab.pincode,
                            style: GoogleFonts.montserrat(
                                textStyle:
                                TextStyle(color: Colors.black, fontSize: 15)),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            //   padding: EdgeInsets.all(15),
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //     border:
            //         Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
            //   ),
            //   child: Row(
            //     children: [
            //       Icon(
            //         Icons.security,
            //         color: Colors.lightBlueAccent.withOpacity(0.5),
            //         size: 80,
            //       ),
            //       Flexible(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               "Smartech 360 diagnostic center",
            //               overflow: TextOverflow.ellipsis,
            //               style: GoogleFonts.montserrat(
            //                   textStyle:
            //                       TextStyle(color: Colors.black, fontSize: 15)),
            //             ),
            //             Text(
            //               widget.doctorDetail.,
            //               overflow: TextOverflow.ellipsis,
            //               style: GoogleFonts.montserrat(
            //                   textStyle: TextStyle(
            //                       color: Colors.black.withOpacity(0.7),
            //                       fontSize: 14)),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  decoration: BoxDecoration(
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
                      'See Reviews',
                      style: GoogleFonts.montserrat(
                          textStyle:
                          TextStyle(color: Colors.white, fontSize: 13)),
                    ),
                    onPressed: (){

                      Route route = MaterialPageRoute(builder: (_)=>ReviewsScreen(
                      ));
                      Navigator.push(context, route);

                    },),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  decoration: BoxDecoration(
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
                        'Book Appointment',textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            textStyle:
                            TextStyle(color: Colors.white, fontSize: 13)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookAppointment(

                                lab: widget.lab,
                                isLab: true,
                              )),
                        );
                      }),
                ),
              ],
            ),

            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            //   padding: EdgeInsets.all(15),
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //     border:
            //         Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //           margin: EdgeInsets.symmetric(vertical: 10),
            //           child: Text(
            //             "Reviews & Ratings",
            //             style: GoogleFonts.montserrat(
            //                 textStyle: TextStyle(
            //                     color: Colors.lightBlueAccent.withOpacity(0.7),
            //                     fontSize: 25)),
            //           )),
            //       Row(
            //         children: [
            //           Text(
            //             "4.7 ",
            //             style: GoogleFonts.montserrat(
            //                 textStyle: TextStyle(
            //                     color: Colors.lightBlueAccent.withOpacity(0.7),
            //                     fontSize: 25)),
            //           ),
            //           Icon(
            //             Icons.star,
            //             color: Colors.lightBlueAccent.withOpacity(0.7),
            //           ),
            //           Icon(
            //             Icons.star,
            //             color: Colors.lightBlueAccent.withOpacity(0.7),
            //           ),
            //           Icon(
            //             Icons.star,
            //             color: Colors.lightBlueAccent.withOpacity(0.7),
            //           ),
            //           Icon(
            //             Icons.star,
            //             color: Colors.lightBlueAccent.withOpacity(0.7),
            //           ),
            //           Icon(
            //             Icons.star_half,
            //             color: Colors.lightBlueAccent.withOpacity(0.7),
            //           )
            //         ],
            //       ),
            //       Text(
            //         "Samesh",
            //         style: GoogleFonts.montserrat(
            //             textStyle: TextStyle(
            //                 color: Colors.lightBlueAccent.withOpacity(0.7),
            //                 fontSize: 20)),
            //       ),
            //       Text(
            //         "Dental scpecialist dr raman have 5 years of experience indental relaed issues. He is able to solve all kind of dental problems.",
            //         style: GoogleFonts.montserrat(
            //             textStyle:
            //                 TextStyle(color: Colors.black, fontSize: 13)),
            //       ),
            //     ],
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.45,
//                   margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
//                   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                   decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.topRight,
//                         colors: [
//                           Color(0xff14B4A5),
//                           Color(0xff3883EF),
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(590)),
//                   child: MaterialButton(
//                       child: Text(
//                         'Consult Now',
//                         style: GoogleFonts.montserrat(
//                             textStyle:
//                                 TextStyle(color: Colors.white, fontSize: 15)),
//                       ),
//                       onPressed: () {
// //                Navigator.push(
// //                  context,
// //                  MaterialPageRoute(builder: (context) => Signup()),
// //                );
//                       }),
//                 ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
