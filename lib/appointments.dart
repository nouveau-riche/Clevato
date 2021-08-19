import 'package:claveto/config/config.dart';
import 'package:claveto/models/my_appointments/my_appointments.dart';
import 'package:claveto/wIdgets/my_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:claveto/rest/api_services.dart';

import 'chat/chat.dart';
import 'payment_success/payment_success.dart';

class AppointmentsScreen extends StatefulWidget {
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
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
            "Appointments",
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
          child: FutureBuilder<MyAppointmentsModel>(
              future: getMyAppointments(),
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
                  List<Appointments> myAppointments =
                      snapshot.data.appointments.toList().reversed.toList();
                  return myAppointments.length==0?Center(
                    child: Text('No Appointments'),
                  ):ListView.builder(
                      itemCount: snapshot.data.appointments.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        Appointments model = myAppointments[index];
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
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Text(
                                            'Name: ' + model.patientName ?? 0,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15))),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Text(
                                            'Test Doctor ID: ' +
                                                    model.docLabId ??
                                                0,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15))),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                                'Status: ' + model.status ?? 0,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15))),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                                'Type: ' +
                                                        model.appointmentType ??
                                                    0,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15))),
                                      ],
                                    ),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Text(
                                            '${model.dateOfAppointment.toString()} ${model.timeOfAppointment.toString()}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                    model.appointmentType.contains('online')
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.chat),
                                                onPressed: () {
                                                  int year = int.parse(model
                                                      .dateOfAppointment
                                                      .substring(0, 4));
                                                  int month = int.parse(model
                                                      .dateOfAppointment
                                                      .substring(5, 7));
                                                  int date = int.parse(model
                                                      .dateOfAppointment
                                                      .substring(8, 10));
                                                  int hour = int.parse(model
                                                      .timeOfAppointment
                                                      .substring(0, 2));
                                                  int minutes = int.parse(model
                                                      .timeOfAppointment
                                                      .substring(3, 5));

                                                  DateTime dateTime = DateTime(
                                                          year,
                                                          month,
                                                          date,
                                                          hour,
                                                          minutes,
                                                          0,
                                                          0,
                                                          0)
                                                      .subtract(
                                                          Duration(minutes: 5));

                                                  if (dateTime.isBefore(
                                                      DateTime.now())) {
                                                    //ChatApp.sharedPreferences.clear();
                                                    if (ChatApp
                                                            .sharedPreferences
                                                            .getBool(
                                                                '${model.id}x') ==
                                                        null) {
                                                      ChatApp.sharedPreferences
                                                          .setBool(
                                                              '${model.id}x',
                                                              true);
                                                    } else {
                                                      ChatApp.sharedPreferences
                                                          .setBool(
                                                              '${model.id}x',
                                                              false);
                                                    }

                                                    Route route =
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                Chat(
                                                                  userID: model
                                                                      .userId
                                                                      .toString(),
                                                                  patientName: model
                                                                      .patientName,
                                                                  id: model.id
                                                                      .toString(),
                                                                  peerId: model
                                                                      .docLabId
                                                                      .toString(),
                                                                ));
                                                    Navigator.push(
                                                        context, route);
                                                  } else {
                                                    showSnackBar(
                                                        message:
                                                            'You cannot open now');
                                                  }
                                                },
                                              ),

                                              // Container(
                                              //     padding: EdgeInsets.symmetric(
                                              //         horizontal: 10, vertical: 5),
                                              //     child: Text('5 min read',
                                              //         style: TextStyle(color: Colors.white))),
                                            ],
                                          )
                                        : Container(),
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
