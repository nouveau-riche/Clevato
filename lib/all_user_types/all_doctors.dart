import 'package:claveto/model/home_screen_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../aboutdoctors.dart';

class AllDoctorsScreen extends StatefulWidget {
  final List<Doctor> allDoctors;

  const AllDoctorsScreen({Key key, this.allDoctors}) : super(key: key);

  @override
  _AllDoctorsScreenState createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
  List<Doctor> doctors;

  @override
  void initState() {
    doctors = widget.allDoctors;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( flexibleSpace: Container(
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
        title: Text('All Doctors'),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (_, index) {
          return horizontalDoctorCard(doctors[index], context);
        },
      ),
    );
  }
}

Widget horizontalDoctorCard(Doctor doctor, BuildContext context) {
  // todo zeyan change the ui and use values from doctor model

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AboutDoctors(
                  doctorDetail: doctor,
                )),
      );
    },
    child: Container( margin: EdgeInsets.all(15),
      child: Material(elevation: 5,borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(15),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff14B4A5).withOpacity(0.5),
                Color(0xff3883EF).withOpacity(0.5),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Text(
                    'Doctor\'s ',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 130,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                              'https://doctoryouneed.org/wp-content/uploads/2020/05/dr-new-demo-image-64.png'))),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 9, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Name: ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.6-130,
                              child: Text(
                                '${doctor.firstName??''}' +
                                    " " +
                                    '${doctor.middleName??''}' +
                                    " " +
                                    '${doctor.lastName??''}',
                                style: TextStyle(color: Colors.white,),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Gender: ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${doctor.gender??''}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address: ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(width: 80,
                              child: Text(
                                '${doctor.address??''}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        // if(doctor.dob!=null)Row(
                        //   children: [
                        //     Text(
                        //       'DOB: ',
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //
                        //     Text(
                        //       '${doctor.dob.toString().substring(0, 10)}',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'PinCode: ',
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //     Text(
                        //       '${doctor.pincode}',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
