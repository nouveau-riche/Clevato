import 'package:claveto/aboutdoctors.dart';
import 'package:claveto/appointments.dart';
import 'package:claveto/common/constant.dart';
import 'package:claveto/common/keys.dart';
import 'package:claveto/common/loading.dart';
import 'package:claveto/editprofile.dart';
import 'package:claveto/main.dart';
import 'package:claveto/model/home_screen_model.dart';
import 'package:claveto/newsletter.dart';
import 'package:claveto/orderhistory.dart';
import 'package:claveto/reports/diagnosis.dart';
import 'package:claveto/reports/reports.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:claveto/supportcentre.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:uuid/uuid.dart';

import 'DoctorsList.dart';
import 'blog/all_blogs.dart';
import 'customer_service/customer_service.dart';
import 'customer_service/search_screen.dart';
import 'familymemberList.dart';
import 'help.dart';
import 'memberhistory.dart';
import 'model/get_family_member_model.dart';
import 'package:geocoder/geocoder.dart';
import 'search/search_screen.dart';

GetFamilyMember model;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Doctor> allDoctors = List<Doctor>();
  List<Symptoms> allsymptoms = List<Symptoms>();
  List<Category> allcategories = List<Category>();
  List<Clinic> allclinics = List<Clinic>();
  List<Lab> alllabs = List<Lab>();
  List<Widget> homeScreenWidgets = [];
  List<Banners> allBanners = [];
  bool isLocationEnable;
  String selectedAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //fetchCurrentLocation();
    selectedAddress = '';
    _determinePosition();
    homeScreenWidgets = [
      Center(),
      Center(),
      Center(
        child: Text('Offers Screen'),
      )
      //SearchScreen(),
    ];
    // if(isLocationEnable){
    //   // Future.delayed(Duration(milliseconds: 1000), () {
    //   //   getHomeDataAPI();
    //   // });
    //   homeScreenWidgets = [
    //     Center(),
    //     Center(),
    //     Center(
    //       child: Text('Offers Screen'),
    //     )
    //     //SearchScreen(),
    //   ];
    //
    // }
  }
  Position userCurrentPosition;
  Future<Position> fetchCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await setCoordinates(position.latitude, position.longitude);
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark currentPlaceMark = placeMarks[0];
    selectedAddress =
        '${currentPlaceMark.name} ${currentPlaceMark.subAdministrativeArea} ${currentPlaceMark.administrativeArea}';
    print('Place ${currentPlaceMark.toJson()}');
    return position;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled.');
    // }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      isLocationEnable = false;
      permission = await Geolocator.requestPermission();
      setState(() {});
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        isLocationEnable = false;
        setState(() {});
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      try {
         userCurrentPosition = await fetchCurrentLocation();
      } catch (e) {
        print('Error While fetching address');
      }

      await getHomeDataAPI();
      setState(() {
        isLocationEnable = true;
      });
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      try {
        userCurrentPosition = await fetchCurrentLocation();
      } catch (e) {
        print('Error While fetching address');
      }

      await getHomeDataAPI();
      setState(() {
        isLocationEnable = true;
      });
    }
    setState(() {});
    return await Geolocator.getCurrentPosition();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xff14B4A5),
                  Color(0xff3883EF),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            child: getPrefValue(Keys.PROFILE_PIC) != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(100.0)),
                                    child: FadeInImage.assetNetwork(
                                      width: 65,
                                      height: 65,
                                      placeholder: "assets/add.png",
                                      image: getPrefValue(Keys.PROFILE_PIC),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image.asset("assets/appLogo.png"),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                              width: 290,
                              child: Text(getPrefValue(Keys.NAME),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 18)))),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile()),
                              );
                            },
                            child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text('View or Edit Profile',
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10)))),
                          ),
                        ],
                      )
                    ],
                  ),
                  Divider(
                    indent: 50,
                    endIndent: 50,
                    color: Colors.white,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FamilyMemberList()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 40,
                              width: 40,
                              child: Image.asset(
                                "assets/add.png",
                              )),
                          Container(
                              child: Text('Family members',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 15))))
                        ],
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => OrderHistory()),
                  //     );
                  //   },
                  //   child: Container(
                  //     margin: EdgeInsets.all(10),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Container(
                  //             margin:
                  //                 EdgeInsets.symmetric(horizontal: 10),
                  //             height: 40,
                  //             width: 40,
                  //             child: Image.asset(
                  //               "assets/med.png",
                  //             )),
                  //         Container(
                  //             child: Text('Order History',
                  //                 style: GoogleFonts.montserrat(
                  //                     textStyle: TextStyle(
                  //                         color: Colors.white,
                  //                         fontSize: 15))))
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => MemberHistory()),
                  //     );
                  //   },
                  //   child: Container(
                  //     margin: EdgeInsets.all(10),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Container(
                  //             margin:
                  //                 EdgeInsets.symmetric(horizontal: 10),
                  //             height: 40,
                  //             width: 40,
                  //             child: Image.asset(
                  //               "assets/know.png",
                  //             )),
                  //         Container(
                  //             child: Text('Medical history',
                  //                 style: GoogleFonts.montserrat(
                  //                     textStyle: TextStyle(
                  //                         color: Colors.white,
                  //                         fontSize: 15))))
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DiagnosisScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 40,
                              width: 40,
                              child: Image.asset(
                                "assets/rx.png",
                              )),
                          Container(
                              child: Text('MedicalHostory',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 15))))
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppointmentsScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 40,
                              width: 40,
                              child: Image.asset(
                                "assets/cal.png",
                              )),
                          Container(
                              child: Text('Appointments',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 15))))
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReportsScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              height: 40,
                              width: 40,
                              child: Image.asset(
                                "assets/micro.png",
                              )),
                          Container(
                              child: Text('Lab Test',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 15))))
                        ],
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => NewsLetter()),
                  //     );
                  //   },
                  //   child: Container(
                  //     margin: EdgeInsets.all(10),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Container(
                  //             margin:
                  //                 EdgeInsets.symmetric(horizontal: 10),
                  //             height: 40,
                  //             width: 40,
                  //             child: Image.asset(
                  //               "assets/pres.png",
                  //             )),
                  //         Container(
                  //             child: Text('Newsletter',
                  //                 style: GoogleFonts.montserrat(
                  //                     textStyle: TextStyle(
                  //                         color: Colors.white,
                  //                         fontSize: 15))))
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => SupportCentre()),
                  //     );
                  //   },
                  //   child: Container(
                  //     margin: EdgeInsets.all(10),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Container(
                  //             margin:
                  //                 EdgeInsets.symmetric(horizontal: 10),
                  //             height: 40,
                  //             width: 40,
                  //             child: Image.asset(
                  //               "assets/help.png",
                  //             )),
                  //         Container(
                  //             child: Text('Support centre',
                  //                 style: GoogleFonts.montserrat(
                  //                     textStyle: TextStyle(
                  //                         color: Colors.white,
                  //                         fontSize: 15))))
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Divider(
                    indent: 50,
                    endIndent: 50,
                    color: Colors.white,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Help()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                "assets/quest.png",
                              )),
                          Container(
                              child: Text('Help center',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 15))))
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.all(10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Container(
                  //           margin: EdgeInsets.symmetric(horizontal: 15),
                  //           height: 30,
                  //           width: 30,
                  //           child: Image.asset(
                  //             "assets/setting.png",
                  //           )),
                  //       Container(
                  //           child: Text('Settings',
                  //               style: GoogleFonts.montserrat(
                  //                   textStyle: TextStyle(
                  //                       color: Colors.white,
                  //                       fontSize: 15))))
                  //     ],
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                      clearPref();

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                          (route) => false);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                "assets/back.png",
                              )),
                          Container(
                              child: Text('Logout',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 15))))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          title: Text('Claveto'),
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
          actions: [
            Container(
                padding: EdgeInsets.all(20),
                child: Text(selectedAddress,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 10)))),
            InkWell(
              onTap: () async {
                final sessionToken = Uuid().v4();
                final Suggestion result = await showSearch(
                  context: context,
                  delegate: AddressSearch(sessionToken),
                );
                // This will change the text displayed in the TextField
                if (result != null) {
                  await getAddressListFromQuery(result.description);
                  setState(() {});
                  //changeLocationBottomSheet();
                }
              },
              child: Container(
                  padding: EdgeInsets.all(20), child: Icon(Icons.location_on)),
            )
          ],
        ),
        body: isLocationEnable == null
            ? Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: Loading(),
                ),
              )
            : isLocationEnable == true
                ? homeScreenWidgets[_currentIndex]
                : noServiceEnabelWidget(),
        bottomNavigationBar: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xff14B4A5),
                    Color(0xff3883EF),
                  ],
                ),
                borderRadius: BorderRadius.circular(20)),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              currentIndex: _currentIndex,
              onTap: (index) {
                _currentIndex = index;
                setState(() {});
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Image.asset(
                          "assets/nav1.png",
                        )),
                    title: Text('Customer Service')),
                BottomNavigationBarItem(
                    icon: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Image.asset(
                          "assets/nav2.png",
                          color: Colors.white,
                        )),
                    title: Text('Search')),
                BottomNavigationBarItem(
                    icon: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: Image.asset("assets/nav3.png")),
                    title: Text('Blog')),
              ],
              fixedColor: Colors.white,
            )),

        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  clearPref() {
    setPrefValue(Keys.TOKEN, "");
    clearAllPrefs();
  }

  Future<void> getHomeDataAPI() async {
    //showDialog(context: context, builder: (context) => Loading());
    await getHomeData().then((response) {
      print('Doctor ${response.doctors.toList().length}');
      allDoctors = response.doctors
          .toList()
          .where((element) =>
              element.isActive == 1 &&
              element.firstName != null &&
              element.pincode != null)
          .toList();
      allsymptoms = response.symptoms;

      print(allsymptoms.length);
      allcategories = response.categories;
      allclinics = response.clinics;
      Map<int, double> clinicMap = {};
      // if(userCurrentPosition!=null){
      //
      //   allclinics.forEach((element) {
      //     double disance = calculateDistanceBetweenTwoPoints(
      //         clinicLabPosition: Position(
      //           latitude: double.parse(element.lat),
      //           longitude: double.parse(element.long),
      //         ),
      //         userPosition: userCurrentPosition
      //
      //     );
      //     clinicMap[element.id]=disance??0;
      //   });
      //
      //
      // }
      // else{
      //
      // }

      alllabs = response.labs;
      allBanners = response.banners;
      print('Doctor 2 ${allDoctors.length}');
      homeScreenWidgets = [
        CustomerService(
          allcategories: allcategories,
          allclinics: allclinics,
          allDoctors: allDoctors,
          alllabs: alllabs,
          allsymptoms: allsymptoms,
          allBanners: allBanners,
        ),
        SearchScreen(
          allcategories: allcategories,
          allclinics: allclinics,
          allDoctors: allDoctors,
          alllabs: alllabs,
          allsymptoms: allsymptoms,
        ),
        AllBlogs() //SearchScreen(),
      ].toList();

      //SearchScreen(),
    });
    model = await getFamilyMemberList();
    setState(() {});
    // setState(() {});
    // Navigator.pop(context);
  }

  Widget noServiceEnabelWidget() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://www.umhs-adolescenthealth.org/wp-content/uploads/2016/12/google-map-background.jpg',
              ))),
      child: Container(
        color: Colors.white.withOpacity(0.8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(990)),
                  child: Image.network(
                    'https://freesvg.org/img/1392496432.png',
                    height: 250,
                  )),
              SizedBox(
                height: 120,
              ),
              Text(
                "We are unable to Locate you",
                style: TextStyle(color: Colors.black, fontSize: 28),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xff14B4A5),
                        Color(0xff3883EF),
                      ],
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      bool isOpened =
                          await LocationPermissions().openAppSettings();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Enable Location',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  List<Address> address = [];

  changeLocationBottomSheet() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Text('Search Location',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 25,
                                    color: Colors.lightBlueAccent)))),
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        height: 30,
                        width: 30,
                        child: Image.asset('assets/close.png'))
                  ],
                ),
                Container(
                  height: 45,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(.5),
                      borderRadius: BorderRadius.circular(590)),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(590)),
                    child: TextFormField(
                      onChanged: (query) async {
                        await getAddressListFromQuery(query);
                        setState(() {});
                      },
                      decoration: new InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.blue.withOpacity(.7),
                        ),
                        hintText: "search",
                        hintStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 15)),
                        border: InputBorder.none,
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                ),
                address.length != 0
                    ? Container(
                        child: ListView.builder(
                            itemCount: address.length,
                            itemBuilder: (_, index) {
                              return Text(address[index].toMap().toString());
                            }),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              height: 30,
                              width: 30,
                              child: Icon(
                                Icons.my_location,
                                color: Colors.lightBlueAccent,
                              )),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Text('Detect Current Location',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.lightBlueAccent)))),
                        ],
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<List<Address>> getAddressListFromQuery(String query) async {
    //final query = "1600 Amphiteatre Parkway, Mountain View";
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    print("Address From Query ${first.featureName} : ${first.coordinates}");
    selectedAddress = query;
    return addresses;
  }

  double calculateDistanceBetweenTwoPoints({
    Position clinicLabPosition,
    Position userPosition,
  }) {

    final distanceInMetres = Geolocator.distanceBetween(
            userPosition.latitude,
            userPosition.longitude,
            clinicLabPosition.latitude,
            clinicLabPosition.longitude) /
        1000;

    return distanceInMetres;
  }
}
