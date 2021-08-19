import 'package:claveto/common/constant.dart';
import 'package:claveto/common/loading.dart';
import 'package:claveto/common/pref.dart';
import 'package:claveto/forgot_password.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:claveto/signup.dart';
import 'package:claveto/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat/chat.dart';
import 'common/keys.dart';
import 'config/config.dart';
import 'home.dart';
import 'image360/full_body_page.dart';
import 'image360/select_part_page.dart';
import 'model/signIn_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_example.dart';
Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  ChatApp.sharedPreferences = await SharedPreferences.getInstance();


  await Firebase.initializeApp();
  ChatApp.firestore = FirebaseFirestore.instance;

  await configureLocalTimeZone();

  final NotificationAppLaunchDetails notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  const MacOSInitializationSettings initializationSettingsMacOS =
  MacOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false);
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      //iOS: initializa3tionSettingsIOS,
      macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
        selectNotificationSubject.add(payload);
      });
  runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(notificationAppLaunchDetails),
      )
    // MaterialApp(
    //   home: HomePage(
    //     notificationAppLaunchDetails,
    //   ),
    // ),
  );
}

// //
// // void main() {
// //   runApp(MyApp());
// // }
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   ChatApp.sharedPreferences = await SharedPreferences.getInstance();
//
//
//   await Firebase.initializeApp();
//   ChatApp.firestore = FirebaseFirestore.instance;
//
//
//   await configureLocalTimeZone();
//
//   final NotificationAppLaunchDetails notificationAppLaunchDetails =
//   await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
//
//   const AndroidInitializationSettings initializationSettingsAndroid =
//   AndroidInitializationSettings('app_icon');
//
//   /// Note: permissions aren't requested here just to demonstrate that can be
//   /// done later
//   final IOSInitializationSettings initializationSettingsIOS =
//   IOSInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//       onDidReceiveLocalNotification:
//           (int id, String title, String body, String payload) async {
//         didReceiveLocalNotificationSubject.add(ReceivedNotification(
//             id: id, title: title, body: body, payload: payload));
//       });
//   const MacOSInitializationSettings initializationSettingsMacOS =
//   MacOSInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false);
//   final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//       macOS: initializationSettingsMacOS);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: (String payload) async {
//         if (payload != null) {
//           debugPrint('notification payload: $payload');
//         }
//         selectNotificationSubject.add(payload);
//       });
//
//   runApp(MyApp(notificationAppLaunchDetails: notificationAppLaunchDetails));
// }
//
//
//
// class MyApp1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',      theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: FullBodyPage()
//       // Chat(
//       //   peerId: 123.toString(),
//       //   userID: 12.toString(),
//       // ),
//     );
//   }
// }
//
//
// class MyApp extends StatelessWidget {
//
//   final NotificationAppLaunchDetails notificationAppLaunchDetails;
//
//   const MyApp({Key key, this.notificationAppLaunchDetails}) : super(key: key);
//   bool get didNotificationLaunchApp =>
//       notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: SafeArea(child: SplashScreen(notificationAppLaunchDetails)),
//     );
//   }
//
// }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final emailController=TextEditingController();
  final passController=TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Pref.init();
  }

  validateInputs(e,p) {
   if (GetUtils.isNullOrBlank(e)) {
     Get.rawSnackbar(
         snackPosition: SnackPosition.BOTTOM,
         backgroundColor: Colors.white,
         messageText: Text("Email Can't be empty",
             style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 17))),
         padding: EdgeInsets.all(20),
         borderRadius: 10,
         margin: EdgeInsets.all(15));

    }
    else if (GetUtils.isNullOrBlank(p)) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("Password Can't be empty",
              style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    } else {
     loginAPI(emailController.text,passController.text);

   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Container(
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
         child: Container(
           child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(margin: EdgeInsets.all(45),
                child:Image.asset('assets/logos.png')
              ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.5),
                  borderRadius: BorderRadius.circular(590)),
              child: TextFormField(
                controller: emailController,
                decoration: new InputDecoration(
                  labelText: " Email",
                  labelStyle:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 20)),
                  border: InputBorder.none,
                  //fillColor: Colors.green
                ),
              ),
            ),
              Container(margin: EdgeInsets.symmetric(horizontal: 25,vertical: 5),padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.5),
                    borderRadius: BorderRadius.circular(590)),
                child: TextFormField(
                  obscureText: true,
                  controller: passController,
                  decoration: new InputDecoration(
                    labelText: " Password",
                    labelStyle:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 20)),
                    border: InputBorder.none,
                    //fillColor: Colors.green
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()),
                  );
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(margin: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                    child:Text('Forgot password?',
                      style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 15)),) ,
                  ),
                ),
              ),
              SizedBox(height: 35),
//              Container(margin: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
//                child:Text('Or Login with OTP',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 15)),) ,
//              ),
//
//
//              Container(margin: EdgeInsets.symmetric(horizontal: 25,vertical: 5),padding: EdgeInsets.symmetric(horizontal: 15),
//                decoration: BoxDecoration(
//                    color: Colors.white.withOpacity(.5),
//                    borderRadius: BorderRadius.circular(590)),
//                child: TextFormField(
//
//                  decoration: new InputDecoration(
//                    suffixIcon: Container(padding: EdgeInsets.all(15),
//                      decoration: BoxDecoration(
//                        gradient: LinearGradient(
//                          begin: Alignment.topLeft,
//                          end: Alignment.topRight,
//                          colors: [
//
//                            Color(0xff14B4A5),
//                            Color(0xff3883EF),
//                          ],
//                        ),
//                        borderRadius: BorderRadius.circular(50),
//
//                      ),
//                        child: Container( margin:EdgeInsets.all(0),height: 10,width: 10,
//                            child: Image.asset("assets/send.png",color: Colors.white,)),),
//                    labelText: " Mobile",
//                    labelStyle:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 20)),
//                    border: InputBorder.none,
//                    //fillColor: Colors.green
//                  ),
//                ),
//              ),
//              Container(
//                child: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: PinEntryTextField(
//                    showFieldAsBox: false,
//                    fields: 6,
//                    onSubmit: (String pin){
//
//                      showDialog(
//                          context: context,
//                          builder: (context){
//                            return AlertDialog(
//                              title: Text("Pin"),
//                              content: Text('Pin entered is $pin'),
//                            );
//                          }
//                      ); //end showDialog()
//
//                    }, // end onSubmit
//                  ), // end PinEntryTextField()
//                ), // end Padding()
//              ),


              Container(
                width: MediaQuery.of(context).size.width*0.85,
                margin: EdgeInsets.symmetric(horizontal: 25,vertical: 15),padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                decoration: BoxDecoration( boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(5.0, 5.0), //(x,y)
                    blurRadius: 55.0,
                  ),
                ],
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
                 child: Row(mainAxisSize: MainAxisSize.min,
                   children: [
                     Text('Signin',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 20)),),
                     Container( margin:EdgeInsets.all(10),height: 15,width: 15,
                         child: Image.asset("assets/send.png",color: Colors.white,)),
                   ],
                 ),
                    onPressed: () {
                      validateInputs(emailController.text,passController.text);

                }
                ),
              ),
              Container(width: MediaQuery.of(context).size.width*0.85,
                margin: EdgeInsets.symmetric(horizontal: 25,),padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                  decoration: BoxDecoration( boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(5.0, 5.0), //(x,y)
                      blurRadius: 55.0,
                    ),
                  ],
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
                  child: Text('Register',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 20)),),  onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                }
                ),
              ),


        ],),
         ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> loginAPI(email,password) async {
    showDialog(context: context, builder: (context) => Loading());
    await login(email,password).then((onValue) {
    if (onValue.toString().contains("message"))
      {
        Navigator.pop(context);
        Get.rawSnackbar(
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            messageText: Text("Invalid Credentials",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 17))),
            padding: EdgeInsets.all(20),
            borderRadius: 10,
            margin: EdgeInsets.all(15));
      }
    else{
      print("success");
      Navigator.pop(context);
      print(onValue.toString());
      setPrefValues(onValue);
      print(getPrefValue(Keys.TOKEN));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()),);
    }
    });
    setState(() {
    });
  }


  void setPrefValues(onValue) {
    SignInModel sign=onValue;
    print(sign.user.id);
    setPrefValue(Keys.TOKEN, sign.accessToken);
    setPrefValue(Keys.ID, sign.user.id.toString());
    setPrefValue(Keys.FIRST_NAME, sign.details.firstName);
    setPrefValue(Keys.LAST_NAME, sign.details.lastName);
    setPrefValue(Keys.MIDDLE_NAME, sign.details.middleName);
    setPrefValue(Keys.NAME, sign.user.name);
    setPrefValue(Keys.EMAIL, sign.user.email);
    setPrefValue(Keys.PHONE, sign.user.phone);
    setPrefValue(Keys.DOB, sign.details.dob.toString() != null ?sign.details.dob.toString():"");
    setPrefValue(Keys.GENDER, sign.details.gender!= null ?sign.details.gender:"");
    setPrefValue(Keys.ADDRESS, sign.details.address!= null ?sign.details.address :"");
    setPrefValue(Keys.STATE, sign.details.state!= null ?sign.details.state:"");
    setPrefValue(Keys.CITY, sign.details.city != null ?sign.details.city :"");
    setPrefValue(Keys.PINCODE, sign.details.pincode != null ? sign.details.pincode :"");
    setPrefValue(Keys.BLOOD_GROUP, sign.details.bloodGroup != null ? sign.details.bloodGroup :"");
    print('Value ${sign.user.avatar}');
    setPrefValue(Keys.PROFILE_PIC, sign.user.avatar==null?null:IMAGE_URL+"avatar_user/"+sign.user.avatar);
  }
}


//----------------------Notification code from here--------------------------------

