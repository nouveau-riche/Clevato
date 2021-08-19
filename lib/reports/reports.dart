import 'package:claveto/config/config.dart';
import 'package:claveto/models/diagnosis_model/report_response_model.dart';
import 'package:claveto/models/my_appointments/my_appointments.dart';
import 'package:claveto/payment_success/payment_success.dart';
import 'package:claveto/wIdgets/my_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:claveto/rest/api_services.dart';

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        navigateTOHomeScreen(context);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Reports",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff14B4A5),
                  Color(0xff3883EF),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          child: FutureBuilder<ReportResponseModel>(
              future: getReports(),
              builder: (context, snapshot) {
                print('Called snapshot ${snapshot}');
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error while fetching blogs'),
                  );
                } else {
                  List<Reports> reports =
                  snapshot.data.reports.toList().reversed.toList();
                  return ListView.builder(
                      itemCount: snapshot.data.reports.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        Reports model = reports[index];
                        return new Container(
                          margin: EdgeInsets.all(15),
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => DetailedBlog(
                              //     model: model,
                              //   )),
                              // );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xff14B4A5),
                                    Color(0xff3883EF),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    model.report!=null?FadeInImage.assetNetwork(
                                      width: 60,
                                      height: 60,
                                      placeholder:
                                      "assets/appLogo.png",
                                      image:
                                      "https://claveto.s3.ap-south-1.amazonaws.com/lab_report/" +
                                          model.report,
                                      fit: BoxFit.cover,
                                    )
                                        : Image.asset("assets/appLogo.png"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }
              }),
        ),
      ),
    );
  }
}
