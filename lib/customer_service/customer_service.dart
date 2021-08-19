import 'package:claveto/all_user_types/all_clinics_screen.dart';
import 'package:claveto/all_user_types/all_doctors.dart';
import 'package:claveto/all_user_types/all_labs.dart';
import 'package:claveto/categories/categories_in_clinic.dart';
import 'package:claveto/clinics/doctors_in_clinics.dart';
import 'package:claveto/lab/lab.dart';
import 'package:claveto/model/home_screen_model.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../DoctorsList.dart';
import '../aboutdoctors.dart';
import '../book_appointment.dart';

class CustomerService extends StatefulWidget {
  final List<Doctor> allDoctors;

  final List<Symptoms> allsymptoms;

  final List<Category> allcategories;

  final List<Clinic> allclinics;

  final List<Lab> alllabs;
  final List<Banners> allBanners;

  const CustomerService(
      {Key key,
      this.allDoctors,
      this.allsymptoms,
      this.allcategories,
      this.allclinics,
      this.alllabs,
      this.allBanners})
      : super(key: key);

  @override
  _CustomerServiceState createState() => _CustomerServiceState(
      allCategories: allcategories,
      allClinics: allclinics,
      allDoctors: allDoctors,
      allLabs: alllabs,
      allBanners: allBanners,
      allSymptoms: allsymptoms);
}

class _CustomerServiceState extends State<CustomerService> {
  final List<Doctor> allDoctors;

  final List<Symptoms> allSymptoms;

  final List<Category> allCategories;

  final List<Clinic> allClinics;

  final List<Lab> allLabs;
  final List<Banners> allBanners;

  _CustomerServiceState(
      {this.allDoctors,
      this.allSymptoms,
      this.allCategories,
      this.allClinics,
      this.allBanners,
      this.allLabs});

  @override
  Widget build(BuildContext context) {
    print('Customer Service ${allDoctors.length}');
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(50),
              //       bottomRight: Radius.circular(50)),
              //   gradient: LinearGradient(
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //     colors: [
              //       Color(0xff14B4A5),
              //       Color(0xff3883EF),
              //     ],
              //   ),
              // ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: PageView.builder(
                itemCount: allBanners.length,
                itemBuilder: (_, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/appLogo.png",
                        image: IMAGE_URL +
                            "icons/" +
                            allBanners[index].bannerImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       Container(
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.only(
            //               bottomLeft: Radius.circular(50),
            //               bottomRight: Radius.circular(50)),
            //           gradient: LinearGradient(
            //             begin: Alignment.topLeft,
            //             end: Alignment.bottomRight,
            //             colors: [
            //               Color(0xff14B4A5),
            //               Color(0xff3883EF),
            //             ],
            //           ),
            //         ),
            //         width: MediaQuery.of(context).size.width,
            //         height: MediaQuery.of(context).size.height * 0.3,
            //         child: Image.asset("assets/card.png"),
            //       ),
            //       Container(
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.only(
            //               bottomLeft: Radius.circular(50),
            //               bottomRight: Radius.circular(50)),
            //           gradient: LinearGradient(
            //             begin: Alignment.topLeft,
            //             end: Alignment.bottomRight,
            //             colors: [
            //               Color(0xff14B4A5),
            //               Color(0xff3883EF),
            //             ],
            //           ),
            //         ),
            //         width: MediaQuery.of(context).size.width,
            //         height: MediaQuery.of(context).size.height * 0.3,
            //         child: Image.asset("assets/card.png"),
            //       ),
            //       Container(
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.only(
            //               bottomLeft: Radius.circular(50),
            //               bottomRight: Radius.circular(50)),
            //           gradient: LinearGradient(
            //             begin: Alignment.topLeft,
            //             end: Alignment.bottomRight,
            //             colors: [
            //               Color(0xff14B4A5),
            //               Color(0xff3883EF),
            //             ],
            //           ),
            //         ),
            //         width: MediaQuery.of(context).size.width,
            //         height: MediaQuery.of(context).size.height * 0.3,
            //         child: Image.asset("assets/card.png"),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Text("Top Doctors",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(fontSize: 15)))),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllDoctorsScreen(
                                      allDoctors: allDoctors,
                                    )),
                          );
                        },
                        child: Container(
                            child: Text("See All",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(fontSize: 15)))),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 150,
                      minHeight: 50,
                    ),
                    child: ListView.builder(
                      itemCount: allDoctors.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutDoctors(
                                        doctorDetail: allDoctors[index],
                                      )),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(1),
                            width: MediaQuery.of(context).size.width * 0.31,
                            height: MediaQuery.of(context).size.height * 0.22,
                            child: Card(
                                elevation: 5,
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        allDoctors[index].avatar != null
                                            ? FadeInImage.assetNetwork(
                                                width: 60,
                                                height: 60,
                                                placeholder:
                                                    "assets/appLogo.png",
                                                image:
                                                IMAGE_URL +
                                                    AVTAR_DOCTOR +
                                                        allDoctors[index]
                                                            .avatar,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                "assets/appLogo.png",
                                                height: 60,
                                                width: 60,
                                              ),
                                        SizedBox(height: 10),
                                        Flexible(
                                          flex: 1,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: RichText(
                                                    text: TextSpan(
                                                  style: GoogleFonts.montserrat(
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10)),
                                                  children: [
                                                    TextSpan(
                                                        text: allDoctors[index]
                                                                    .middleName ==
                                                                null
                                                            ? 'Dr '
                                                            : allDoctors[index]
                                                                    .middleName +
                                                                ' ',
                                                        children: [
                                                          TextSpan(
                                                            text: allDoctors[
                                                                            index]
                                                                        .lastName ==
                                                                    null
                                                                ? ' '
                                                                : allDoctors[
                                                                        index]
                                                                    .lastName,
                                                          )
                                                        ])
                                                  ],
                                                  text: allDoctors[index]
                                                              .firstName ==
                                                          null
                                                      ? ' '
                                                      : allDoctors[index]
                                                              .firstName +
                                                          ' ',
                                                )),
                                              ),
                                              // Text(
                                              //      allDoctors[index]
                                              //         .firstName==null?'Dr':allDoctors[index]
                                              //          .firstName+allDoctors[index].middleName+,
                                              //
                                              //     overflow: TextOverflow
                                              //         .ellipsis,
                                              //     style:
                                              //     GoogleFonts.montserrat(
                                              //         textStyle:
                                              //         TextStyle(
                                              //             fontSize:
                                              //             10))),
//                                                allDoctors[index]
//                                                    .degreeCerti != null ?Text(", " + allDoctors[index]
//                                                    .degreeCerti,
//                                                    overflow: TextOverflow
//                                                        .ellipsis,
//                                                    style: GoogleFonts
//                                                        .montserrat(
//                                                        textStyle: TextStyle(
//                                                            fontSize: 8))):Container(),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookAppointment(
                                                        doctorDetails:
                                                            allDoctors[index],
                                                      )),
                                            );
                                          },
                                          child: Text('Consult Now',style: TextStyle(fontSize: 10),),
                                        )
                                      ],
                                    ))),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Text("Labs",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(fontSize: 15)))),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllLabsScreen(
                                      allLabs: allLabs,
                                    )),
                          );
                        },
                        child: Container(
                            child: Text("See All",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(fontSize: 15)))),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 180,
                      minHeight: 120,
                    ),
                    child: ListView.builder(
                      itemCount: allLabs.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        Lab lab = allLabs[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LabScreen(
                                          lab: lab,
                                        )));
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.23,
                            child: Card(
                                elevation: 5,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      height: 100,
                                      child: Image.asset("assets/appLogo.png"),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      child: Text(lab.middleName,
                                          style: GoogleFonts.montserrat(
                                              textStyle:
                                                  TextStyle(fontSize: 15))),
                                    ),
                                    Container(
                                      child: Text('Lab',
                                          style: GoogleFonts.montserrat(
                                              textStyle:
                                                  TextStyle(fontSize: 15),
                                              color: Colors.blue)),
                                    )
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Text("Clinics",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(fontSize: 15)))),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllClinicsScreen(
                                      allDoctors: allDoctors,
                                      allClinics: allClinics,
                                    )),
                          );
                        },
                        child: Container(
                            child: Text("See All",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(fontSize: 15)))),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 180,
                      minHeight: 120,
                    ),
                    child: ListView.builder(
                      itemCount: allClinics.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        Clinic clinic = allClinics[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DoctorsInClinics(
                                          allDoctors: allDoctors,
                                          clinicId: clinic.id,
                                        )));
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.34,
                            child: Card(
                                elevation: 5,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      height: 100,
                                      child: Image.asset("assets/appLogo.png"),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      child: Text(clinic.legalName,
                                          style: GoogleFonts.montserrat(
                                              textStyle:
                                                  TextStyle(fontSize: 12))),
                                    ),
                                    Container(
                                      child: Text('Clinics',
                                          style: GoogleFonts.montserrat(
                                              textStyle:
                                                  TextStyle(fontSize: 15),
                                              color: Colors.blue)),
                                    )
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Text("Common Symptoms",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(fontSize: 15)))),
                      allSymptoms.length > 5
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text("See All",
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(fontSize: 15))))
                          : Container()
                    ],
                  ),
                  SizedBox(height: 10),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 180,
                      minHeight: 120,
                    ),
                    child: ListView.builder(
                      itemCount: allSymptoms.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        print(allSymptoms.length);
                        print(allSymptoms[0].name);
                        return Container(
                          margin: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.23,
                          child: Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    height: 100,
                                    child: allSymptoms[index].icon != null
                                        ? FittedBox(
                                            child: FadeInImage.assetNetwork(
                                              width: 60,
                                              height: 60,
                                              placeholder: "assets/appLogo.png",
                                              image: IMAGE_URL +
                                                  "icons/" +
                                                  allSymptoms[index].icon,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Image.asset("assets/appLogo.png"),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(allSymptoms[index].name,
                                        style: GoogleFonts.montserrat(
                                            textStyle:
                                                TextStyle(fontSize: 15))),
                                  ),
                                  // Container(
                                  //   child: Text('Consult Now',
                                  //       style: GoogleFonts.montserrat(
                                  //           textStyle: TextStyle(fontSize: 15),
                                  //           color: Colors.blue)),
                                  // )
                                ],
                              )),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Text("Categories",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(fontSize: 15)))),
                      allCategories.length > 5
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text("Find All",
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(fontSize: 15))))
                          : Container()
                    ],
                  ),
                  SizedBox(height: 10),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 110,
                      minHeight: 50,
                    ),
                    child: ListView.builder(
                      itemCount: allCategories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Route route = MaterialPageRoute(
                                      builder: (_) => CategoriesInClinics(
                                            categoryId: allCategories[index].id,
                                            allDoctors: allDoctors,
                                          ));
                                  Navigator.push(context, route);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: allCategories[index].icon != null
                                      ? Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(90),
                                              color:
                                                  Colors.grey.withOpacity(0.5)),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100.0)),
                                            child: FadeInImage.assetNetwork(
                                              width: 60,
                                              height: 60,
                                              placeholder: "assets/appLogo.png",
                                              image: IMAGE_URL +
                                                  "icons/" +
                                                  allCategories[index].icon,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : Image.asset("assets/appLogo.png"),
                                ),
                              ),
                              Container(
                                child: Text(allCategories[index].name),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
