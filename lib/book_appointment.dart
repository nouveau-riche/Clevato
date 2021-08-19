import 'dart:convert';
import 'dart:ui';
import 'package:claveto/models/appointement/check_befor_appointement.dart';
import 'package:claveto/models/appointement/check_before_response.dart';
import 'package:claveto/models/appointement/doctor_appointement_detail.dart';
import 'package:claveto/models/appointement/lab_book_appointment.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:claveto/wIdgets/select_patient_alert_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'checkout.dart';
import 'common/loading.dart';
import 'controllers/doctor_book_appointmen.dart';
import 'model/get_family_member_model.dart';
import 'model/home_screen_model.dart';
import 'models/appointement/book_appointment_body.dart';
import 'payment/razorpay_payment.dart';
import 'wIdgets/my_snackbar.dart';

var formatter = new DateFormat('yyyy-MM-dd');

class BookAppointment extends StatefulWidget {
  final Doctor doctorDetails;
  final Lab lab;
  final bool isLab;

  const BookAppointment(
      {Key key, this.doctorDetails, this.isLab = false, this.lab})
      : super(key: key);

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  final BookDoctorAppointementController _loginController =
      Get.put(BookDoctorAppointementController());
  String startDate, endDate;
  FamilyMember selectedMember;
  int selectedAppointmentType = -1;
  List<String> appointmentType = ['clinic', 'online', 'lab'];

  // TODO: we need to set these value on getting time slot from api
  String startTime = '03:00',
      endTime = '18:00'; // time slot  of doctor availability

  DoctorBookAppointmentResponse doctorClinicAppointmentModel;
  LabBookAppointment labBookAppointment;
  List<bool> packagesCheckBox;

  // List<String> selectedPackagesId;
  // List<LabPackages> selectedPackages;
  Map<String, LabPackages> selectedPackages;
  double totalPrice;

  @override
  void initState() {
    super.initState();
    fetchApiData();

    packagesCheckBox = [];
    selectedPackages = {}; //= [];
    totalPrice = 0.0;
    selectedDate = formatter.format(DateTime(
        currentDateTime.year, currentDateTime.month, currentDateTime.day));
  }

  List<FamilyMember> allFamilyMember = List<FamilyMember>();
  int id;

  fetchApiData() async {
   // print('Lab Time ${widget.lab.startTime}');
    widget.isLab ? id = widget.lab.userId : id = widget.doctorDetails.userId;
    String response =
        await _loginController.fetchDoctorAppointementDetails(id.toString());
    if (widget.isLab) {
      // Todo you have to initialize startTime and endTime here;
      labBookAppointment = LabBookAppointment.fromJson(jsonDecode(response));
      selectedAppointmentType = 2;

      for (var element in labBookAppointment.labPackages) {
        packagesCheckBox.add(false);
      }
      print('Degree Certificate ${labBookAppointment.labDetails.toJson()}');
    } else {
      // Todo you have to initialize startTime and endTime here;
      doctorClinicAppointmentModel =
          DoctorBookAppointmentResponse.fromJson(jsonDecode(response));
      totalPrice = double.parse(doctorClinicAppointmentModel.category.fees);
    }
    await getFamilyMemberList().then((response) {
      allFamilyMember = response.familyMembers;
      print(allFamilyMember.length);
      setState(() {});
    });

    appointmentSlots(startTime, endTime);
  }

  List<bool> availability = [];
  List<String> timeSlots = [];
  DateTime currentDateTime = DateTime.now();
  String selectedDate, selectedTime;
  int familyMemberId = -10;

  /// This function is used to find slots and availability of slots
  List appointmentSlots(String startDate, String endDate) {
    availability = [];
    timeSlots = [];
    print('Start ${startDate.substring(0, 2)}');
    print('Start ${startDate.substring(0, 1)}');
    print('Start ${startDate.substring(3, 5)}');
    print(
        '${int.parse(startDate.substring(0, 2))} ${int.parse(startDate.substring(3, 5))}');
    print(
        '${int.parse(endDate.substring(0, 2))} ${int.parse(endDate.substring(3, 5))}');
    var startTime = TimeOfDay(
        hour: int.parse(startDate.substring(0, 2)),
        minute: int.parse(startDate.substring(3, 5)));
    var endTime = TimeOfDay(
        hour: int.parse(endDate.substring(0, 2)),
        minute: int.parse(endDate.substring(3, 5)));

    final step = Duration(minutes: 15);


    int year = int.parse(selectedDate.substring(0, 4));
    int month = int.parse(selectedDate.substring(5, 7));
    int date = int.parse(selectedDate.substring(8, 10));
    DateTime startDateTime =
        DateTime(year, month, date, startTime.hour, startTime.minute);

    if (startDateTime.isBefore(DateTime.now())) {
      print('Calculating new start time');
      DateTime roundedDateTime = DateTime.now().roundDown(delta: Duration(minutes: 15));
      print('Rounded Date Time ${roundedDateTime.roundDown(delta: Duration(minutes: 15))}');
      startTime =
          TimeOfDay(hour: roundedDateTime.hour, minute: roundedDateTime.minute);
    }

    final times = getTimes(startTime, endTime, step)
        .map((tod) => tod.format(context))
        .toList();
    timeSlots = times;
    List<Appointments> currentDateAppointments;
    // = doctorClinicAppointmentModel
    //     .appointments
    //     .where((element) => element.dateOfAppointment == selectedDate)
    //     .toList();
    if (widget.isLab) {
      /// Reading appointments from lab api
      currentDateAppointments = labBookAppointment.appointments
          .where((element) => element.dateOfAppointment == selectedDate)
          .toList();
    } else {
      /// Reading appointments from Doctor-Clinic api
      currentDateAppointments = doctorClinicAppointmentModel.appointments
          .where((element) => element.dateOfAppointment == selectedDate)
          .toList();
    }

    for (int i = 0; i < times.length - 1; i++) {
      bool temp = false;
      for (int j = 0; j < currentDateAppointments.length; j++) {
        temp = false;
        if (times[i] ==
            currentDateAppointments[j].timeOfAppointment.substring(0, 5)) {
          temp = true;
          break;
        }
      }
      if (temp) {
        availability.add(false);
      } else {
        availability.add(true);
      }
    }
    setState(() {});
    return times;
  }

  int _currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff14B4A5),
                Color(0xff3883EF),
              ],
            ),
          ),
        ),
        elevation: 0,
        actions: [
          // IconButton(
          //     icon: Icon(Icons.ac_unit),
          //     onPressed: () async {
          //       appointmentSlots('10:00', "19:30");
          //     })
        ],
        title: Text("Book Appointment"),
      ),
      body: doctorClinicAppointmentModel == null && labBookAppointment == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xff14B4A5),
                      Color(0xff3883EF),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(5.0, 5.0), //(x,y)
                              blurRadius: 35.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          widget.isLab
                              ? Container(
                                  padding: EdgeInsets.all(15),
                                  margin: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xff14B4A5),
                                        Color(0xff3883EF),
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          child: Text(
                                            'Lab\'s ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 130,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Container(
                                                      color: Colors.white,
                                                      child: Image.network(
                                                          'https://img2.pngio.com/download-free-png-experiment-lab-laboratory-icon-with-png-and-lab-vector-png-512_512.png')))),
                                          Flexible(
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 9, vertical: 0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Lab Name: ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                        '${widget.lab.legalName}',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Name: ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                        '${widget.lab.firstName + " " + widget.lab.middleName + " " + widget.lab.lastName}',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Address: ',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                        '${widget.lab.address}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ))
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'City: ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                        '${widget.lab.city}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ))
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'State: ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        '${widget.lab.state}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'PinCode: ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        '${widget.lab.pincode}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : widget.doctorDetails.degreeCerti != null
                                  ? Material(
                                      elevation: 5,
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(99),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(99)),
                                        child: FadeInImage.assetNetwork(
                                          width: 180,
                                          height: 180,
                                          placeholder: "assets/appLogo.png",
                                          image: IMAGE_URL +
                                              AVTAR +
                                              widget.doctorDetails.degreeCerti,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Image.asset("assets/appLogo.png"),
                          SizedBox(height: 15),
                          widget.isLab
                              ? Container(
                                  padding: EdgeInsets.all(10),
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
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Select Packages',
                                    style: TextStyle(color: Colors.white),
                                  ))
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            widget.doctorDetails.firstName +
                                                " " +
                                                widget
                                                    .doctorDetails.middleName +
                                                widget.doctorDetails.lastName,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                              fontSize: 18,
                                            ))),
                                        // ConstrainedBox(
                                        //   constraints: const BoxConstraints(
                                        //     maxHeight: 30,
                                        //     minHeight: 10,
                                        //   ),
                                        //   child: ListView.builder(
                                        //     itemCount: 3,
                                        //     shrinkWrap: true,
                                        //     scrollDirection: Axis.horizontal,
                                        //     // physics: const NeverScrollableScrollPhysics(),
                                        //     itemBuilder: (BuildContext context,
                                        //         int index) {
                                        //       return Image.asset(
                                        //         "assets/pres.png",
                                        //         height: 15,
                                        //         width: 15,
                                        //       );
                                        //     },
                                        //   ),
                                        // ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                "Location: " +
                                                    widget
                                                        .doctorDetails.address +
                                                    ", " +
                                                    widget.doctorDetails.city +
                                                    ", " +
                                                    widget.doctorDetails.state,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey))),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Text("Charges: ₹ $totalPrice",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          widget.isLab
                              ? Container(
                                  padding: EdgeInsets.all(10),
                                  color: Colors.grey.withOpacity(0.2),
                                  height: 150,
                                  child: ListView.builder(
                                    itemCount:
                                        labBookAppointment.labPackages.length,
                                    itemBuilder: (_, index) {
                                      LabPackages package =
                                          labBookAppointment.labPackages[index];

                                      return ListTile(
                                        title: Text(package.name),
                                        leading: Checkbox(
                                          onChanged: (value) {
                                            packagesCheckBox.replaceRange(
                                                index, index + 1, [value]);
                                            if (value) {
                                              selectedPackages[package.id
                                                  .toString()] = package;

                                              // selectedPackagesId
                                              //     .add(package.id.toString());
                                            } else {
                                              selectedPackages.remove(
                                                  package.id.toString());
                                              // selectedPackagesId.remove(
                                              //     package.id.toString());
                                            }
                                            print(
                                                'Selected Packages ${selectedPackages.length}');
                                            calculateCostOfPackages();
                                            setState(() {});
                                          },
                                          value:
                                              packagesCheckBox[index] ?? false,
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Container(),
                          widget.isLab
                              ? Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey.withOpacity(0.2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Lab Prices :',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        ' $totalPrice',
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ],
                                  ))
                              : Container(),
                          !widget.isLab
                              ? Column(
                                  children: [
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        padding: EdgeInsets.all(5),
                                        alignment: Alignment.centerLeft,
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
                                        child: Text(
                                          'Select Appointment mode',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        )),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2)),
                                      height: 120,
                                      child: ListView.builder(
                                        itemCount: appointmentType.length - 1,
                                        itemBuilder: (_, index) {
                                          return RadioListTile(
                                            value: index,
                                            groupValue: selectedAppointmentType,
                                            onChanged: (value) {
                                              selectedAppointmentType = value;
                                              if (selectedAppointmentType ==
                                                  1) {
                                                familyMemberId = -10;
                                              }
                                              setState(() {});
                                            },
                                            title: Text(appointmentType[index]
                                                .capitalizeFirst),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(height: 10),
                          Visibility(
                            visible: selectedAppointmentType == 1 ||
                                selectedAppointmentType == 2,
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xff14B4A5),
                                    Color(0xff3883EF),
                                  ],
                                ),
                              ),
                              child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => SelectPatientAlertBox(
                                              member: (member) {
                                                selectedMember = member;
                                                if (selectedMember.id != -1) {
                                                  familyMemberId =
                                                      selectedMember.id;
                                                }
                                                print('Member $member');
                                                setState(() {});
                                              },
                                              allFamilyMember: allFamilyMember,
                                            ));
                                  },
                                  child: Text(
                                    selectedMember == null
                                        ? 'Select member'
                                        : selectedMember.middleName,
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: 30,
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
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 35),
                              child: InkWell(
                                  onTap: () {},
                                  child: DropdownButton<String>(
                                    dropdownColor: Color(0xff14B4A5),
                                    value: selectedDate,
                                    items: <String>[
                                      '${formatter.format(DateTime(currentDateTime.year, currentDateTime.month, currentDateTime.day))}',
                                      '${formatter.format(DateTime(currentDateTime.add(Duration(days: 1)).year, currentDateTime.add(Duration(days: 1)).month, currentDateTime.add(Duration(days: 1)).day))}',
                                      '${formatter.format(DateTime(currentDateTime.add(Duration(days: 2)).year, currentDateTime.add(Duration(days: 2)).month, currentDateTime.add(Duration(days: 2)).day))}',
                                    ].map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: Container(
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(value,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.montserrat(
                                                      textStyle: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Colors.white))),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newSelectedDate) {
                                      selectedDate = newSelectedDate;
                                      appointmentSlots('02:30', endTime);
                                      setState(() {});
                                    },
                                    isExpanded: true,
                                    underline: Container(),
                                    icon: Image.asset(
                                      "assets/arrow.png",
                                      height: 15,
                                      width: 15,
                                    ),
                                  )),
                            ),
                          ),
                          timeSlots.length<=1?Center(child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                            child: Text('No Slot Available'),
                          )):Container(
                            height: 200,
                            child: GridView.builder(
                                itemCount: timeSlots.length - 1,
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: MediaQuery.of(context)
                                          .size
                                          .width /
                                      (MediaQuery.of(context).size.height / 2),
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: EdgeInsets.all(5),
                                    //height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/pres.png",
                                              height: 15,
                                              width: 15,
                                            ),
                                            SizedBox(width: 5),
                                            Text(timeSlots[index],
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: 13))),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                            availability[index]
                                                ? "Available"
                                                : "Booked",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.green))),
                                        availability[index]
                                            ? Radio(
                                                value: index,
                                                groupValue: _currentIndex,
                                                onChanged: (value) {
                                                  _currentIndex = value;
                                                  selectedTime =
                                                      timeSlots[index];
                                                  print('Selected Time');
                                                  print(selectedTime);
                                                  setState(() {});
                                                })
                                            : SizedBox(
                                                //height: 42,
                                                ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(height: 30),
                          InkWell(
                            onTap: () {
                              DateTime dateTime;
                              try{
                                if(selectedDate!=null&&selectedTime!=null){
                                  String time;
                                  if (selectedTime.contains('AM') ||
                                      selectedTime.contains('PM')) {
                                    time = twelvehourtoTwentyHour(selectedTime);
                                  } else {
                                    time = selectedTime;
                                  }
                                  print('$selectedTime $selectedDate Date');
                                  int year =
                                  int.parse(selectedDate.substring(0, 4));
                                  int month =
                                  int.parse(selectedDate.substring(5, 7));
                                  int date =
                                  int.parse(selectedDate.substring(8, 10));
                                  int hour =
                                  int.parse(time.substring(0, 2));
                                  int minutes =
                                  int.parse(time.substring(3, 5));

                                  print('DateTime $year $month');

                                  dateTime = DateTime(
                                      year, month, date, hour, minutes, 0, 0, 0);
                                }
                              }
                              catch(a){
                                dateTime = DateTime.now().add(Duration(days: 2));
                                print('Erro ${a.toString()}');
                                Get.snackbar('Error', '${a.toString()}');
                              }

                              if (selectedAppointmentType == -1 &&
                                  doctorClinicAppointmentModel != null) {
                                showSnackBar(
                                    message: 'Select Appointment type please');
                                print('Select Appointment type please');
                              } else if ((selectedAppointmentType == 1 ||
                                      selectedAppointmentType == 2) &&
                                  selectedMember == null) {
                                showSnackBar(message: 'Select family member');
                                print('Select family member');
                              } else if (!packagesCheckBox.contains(true) &&
                                  labBookAppointment != null) {
                                showSnackBar(message: 'Select lab packages');
                                print('Select family member');
                              } else if (selectedTime == null) {
                                Get.rawSnackbar(
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.white,
                                    backgroundGradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xff3883EF),
                                        Color(0xff14B4A5),
                                      ],
                                    ),
                                    messageText: Text(
                                        "Please Select time first",
                                        style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontSize: 17))),
                                    padding: EdgeInsets.all(20),
                                    borderRadius: 10,
                                    margin: EdgeInsets.all(15));
                              } else if (dateTime.isBefore(DateTime.now())) {


                                showSnackBar(
                                    message:
                                    'Please select anothe time and date');
                                print('Select Appointment type please');
                              } else {
                                String time;

                                if (selectedTime.contains('AM') ||
                                    selectedTime.contains('PM')) {
                                  time = twelvehourtoTwentyHour(selectedTime);
                                } else {
                                  time = selectedTime;
                                }

                                CheckBeforeRequestModel model =
                                CheckBeforeRequestModel(
                                  dateOfAppointment: selectedDate,
                                  docLabId: id.toString(),
                                  timeOfAppointment: time,
                                );


                                checkBeforeApi(model);
                              }
                            },
                            child: Container(
                              width: 160,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xff14B4A5),
                                    Color(0xff3883EF),
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text("Book Appointment",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white))),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> checkBeforeApi(
      CheckBeforeRequestModel checkBeforeRequestModel) async {
    showDialog(context: context, builder: (context) => Loading());

    await checkBeforeAppointment(checkBeforeRequestModel).then((onValue) {
      CheckBeforeResponseModel model =
          CheckBeforeResponseModel.fromJson(jsonDecode(onValue));
      if (model.status != 200) {
        Navigator.pop(context);
        // TODO Zeyan change design of dialog as per need
        Get.defaultDialog(title: model.message, content: Text(''), actions: [
          RaisedButton(
            onPressed: () {
              fetchApiData();
              setState(() {});
              Navigator.pop(context);
            },
            child: Text('Select another slot'),
          )
        ]);
      } else {
        print("success  ${selectedPackages.keys.toList().length}");
        Navigator.pop(context);
        print(onValue);
        String time;
        print('$selectedTime ${selectedTime.substring(0, 5).trim()}');

        if (selectedTime.contains('AM') || selectedTime.contains('PM')) {
          time = twelvehourtoTwentyHour(selectedTime);
        } else {
          time = selectedTime;
        }
        Route route = MaterialPageRoute(
            builder: (_) => CheckOut(
                  doctorDetails: widget.doctorDetails,
                  selectedDate: selectedDate,
                  lab: widget.lab,
                  selectedTime: time,
                  totalPrice: totalPrice,
                  isLab: widget.isLab,
                  packagesIds: selectedPackages.keys.toList(),
                  appointmentType: appointmentType[selectedAppointmentType],
                  familyMemberID: familyMemberId,
                ));
        print("success1");
        Navigator.push(context, route);
        print("success2");
      }
    });
    setState(() {});
  }

  calculateCostOfPackages() {
    totalPrice = 0.0;
    print('Length of selected packages ${selectedPackages.length}');
    selectedPackages.forEach((key, value) {
      totalPrice = totalPrice + double.parse(value.packagePrice);
    });
  }
}

Iterable<TimeOfDay> getTimes(
    TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
  var hour = startTime.hour;
  var minute = startTime.minute;

  do {
    yield TimeOfDay(hour: hour, minute: minute);
    minute += step.inMinutes;
    while (minute >= 60) {
      minute -= 60;
      hour++;
    }
  } while (hour < endTime.hour ||
      (hour == endTime.hour && minute <= endTime.minute));
}

String twelvehourtoTwentyHour(String selectedTime) {
// parse date
  DateTime date = DateFormat.jm().parse(selectedTime);
  // DateTime date2= DateFormat("hh:mma").parse(selectedTime); // think this will work better for you
// format date
  print(DateFormat("HH:mm").format(date));
  //print(DateFormat("HH:mm").format(date2));
  return DateFormat("HH:mm").format(date);
}


extension on DateTime{

  DateTime roundDown({Duration delta = const Duration(seconds: 15)}){
    return DateTime.fromMillisecondsSinceEpoch(
        this.millisecondsSinceEpoch + delta.inMilliseconds-
            this.millisecondsSinceEpoch % delta.inMilliseconds
    );
  }
}