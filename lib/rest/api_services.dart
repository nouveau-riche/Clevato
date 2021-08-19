import 'dart:convert';

import 'package:claveto/common/constant.dart';
import 'package:claveto/common/keys.dart';
import 'package:claveto/model/change_password_model.dart';
import 'package:claveto/model/edit_profile_model.dart';
import 'package:claveto/model/forgot_password_model.dart';
import 'package:claveto/model/get_family_member_model.dart';
import 'package:claveto/model/home_screen_model.dart';
import 'package:claveto/model/register_fail.dart';
import 'package:claveto/model/register_success.dart';
import 'package:claveto/models/faq/faq_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:claveto/model/signIn_model.dart';
import 'package:claveto/models/appointement/all_blogs_response.dart';
import 'package:claveto/models/appointement/book_appointment_body.dart';
import 'package:claveto/models/appointement/check_befor_appointement.dart';
import 'package:claveto/models/diagnosis_model/diagnosis_response_model.dart';
import 'package:claveto/models/diagnosis_model/report_response_model.dart';
import 'package:claveto/models/my_appointments/my_appointments.dart';
import 'package:claveto/models/reviews/review_resonse.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http/http.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as fileUtil;

const String BASE_URL = "https://claveto.com/mainsite/public/api/";
const String IMAGE_URL = "https://claveto.s3.ap-south-1.amazonaws.com/";
const String BLOG_ENDPOINT = 'blog_post_images/';
const String ICONS = "icons";
const String FAMILY_MEMBER = "family_image/";
const String AVTAR = "avatar_user/";
const String AVTAR_DOCTOR = 'avatar_doctor/';



const String LOGIN = "login";
const String FORGOT_PASSWORD = "forgot_password";
const String CHANGE_PASSWORD = "changePassword";
const String REGISTER = "register";
const String EDIT_PROFILE = "user-home";
const String GET_MEMBER = "user-family-member";
const String CHECK_BEFORE = "check-before";
  String getDoctorAppointment(String doctorID)=>'book-appointment/$doctorID';


String get token => getPrefValue(Keys.TOKEN);

// 1. Login API
Future<dynamic> login(emailId,password) async {
  Map<String, String> body = {
    'email': emailId,
    'password': password,
  };
  Map<String, String> requestHeaders = {
    // 'Content-Type' : 'application/json',
    // 'Authorization': 'Bearer $token',
  };

  final response = await http.post(
    BASE_URL + LOGIN,
    headers: requestHeaders,
    body: body,
  );
  print('Signin respnse ${response.body}');
  if(response.statusCode == 401)
    {
      return response.body;
    }
  else{
    return signInModelFromMap(response.body);

  }
}

// 2. Register API
Future<dynamic> register(name,email,phone,password/*,gender,dob,state,city,pincode*/) async {
  Map<String, String> body = {
    'name': name,
    'email': email,
    'phone': phone,
    'password': password,
    // 'gender': gender,
    // 'dob': dob,
    // 'state': state,
    // 'city': city,
    // 'pincode': pincode,
  };
  Map<String, String> requestHeaders = {
    // 'Content-Type' : 'application/json',
    // 'Authorization': 'Bearer $token',
  };


  final response = await http.post(
    BASE_URL + REGISTER,
    headers: requestHeaders,
    body: body,
  );
  print(BASE_URL + REGISTER);
  print(response.statusCode);
  return response.body;


//  var temp=json.decode(response.body);
//  print(temp);
//  if(temp["message"] != null || temp["message"].toString().isNotEmpty){
//    print("fail");
//    Map map= Map<String, dynamic>();
// //   map.addAll({"success":"true","fail":RegisterFail.fromMap(response.body)});
//    //return registerFailFromMap(response.body);
//}
//  else{
//  //  return registerSuccessFromMap(response.body);
//  }

}
// 3. Forgot password API
Future<dynamic> forgotPassword(emailId) async {
  Map<String, String> body = {
    'email': emailId,
  };
  Map<String, String> requestHeaders = {
    // 'Content-Type' : 'application/json',
   //  'Authorization': 'Bearer $token',
  };

  final response = await http.post(
    BASE_URL + FORGOT_PASSWORD,
    headers: requestHeaders,
    body: body,
  );
  if(response.statusCode == 401)
  {
    return response.body;
  }
  else{
    return forgotPasswordModelFromMap(response.body);

  }
}
// 4. Change password API
Future<ChangePassword>changePassword(oldPassword,newPassword) async {
  Map<String, String> requestHeaders = {
    // 'Content-Type' : 'application/json',
      'Authorization': 'Bearer $token',
  };
  print("$token");
 // print(body);
  print(BASE_URL + CHANGE_PASSWORD +"?oldPassword="+oldPassword+"&newPassword="+newPassword);

  final response = await http.post(
    BASE_URL + CHANGE_PASSWORD +"?oldPassword="+oldPassword+"&newPassword="+newPassword,
    headers: requestHeaders,
   // body: body,
  );
  return changePasswordFromMap(response.body);
}

//5. Edit profile data
Future<EditProfileModel>editProfile(dob,gender,address,bloodGroup,name,email,phone,fn,mn,ln,state,city,pincode) async {

  Map<String, String> body = {
  '_method':"PATCH",
  'first_name':fn,
  'last_name':ln,
  'middle_name':mn,
  'dob':dob,
  'gender':gender,
  'address':address,
  'state':state,
  'city':city,
  'pincode':pincode,
  'blood_group':bloodGroup,
  'name':name,
  'email':email,
  'phone':phone
  };

  Map<String, String> requestHeaders = {
    // 'Content-Type' : 'application/json',
    'Authorization': 'Bearer $token',
  };
print(body);
print(BASE_URL + EDIT_PROFILE +"/"+getPrefValue(Keys.ID));
  final response = await http.post(
    BASE_URL + EDIT_PROFILE +"/"+getPrefValue(Keys.ID),
    headers: requestHeaders,
     body: body,
  );
  print('Respnse ${response.body}');
  //jsonDecode(response.body)['']
  return editProfileModelFromMap(response.body);
}

setCoordinates(double lat,double long) async {



  final response = await http.post(
    BASE_URL + 'user-new-home',
    headers: {
    'Authorization': 'Bearer $token',
  },
    body: {
      'lat':lat.toString(),
      'long':long.toString()

    }
  );
  print('Resonse ${response.body}');
}


editProfileWithProfilePic(imageFile,dob,gender,address,bloodGroup,name,email,phone,fn,mn,ln,state,city,pincode,callBack) async {
  print('Edit profile pic ${imageFile} $email');
Map<String, String> body = {
  //'image':imageFile,
  '_method':"PATCH",
  'hidden_image':getPrefValue(Keys.PROFILE_PIC),
  'first_name':fn,
  'last_name':ln,
  'middle_name':mn,
  'dob':dob,
  'gender': gender,
  'address':address,
  'state':state,
  'city':city,
  'pincode':pincode,
  'blood_group':bloodGroup,
  'name':name,
  'email':email,
  'phone':phone
  };

 // http.MultipartFile.fromBytes('image', )
  var url = Uri.parse(
      BASE_URL + EDIT_PROFILE +"/"+getPrefValue(Keys.ID));
  var request = new http.MultipartRequest("POST", url);
  request.headers.addAll({
    'Authorization': 'Bearer $token'
  });
  request.files.add(
    http.MultipartFile(
      'image',
      imageFile.readAsBytes().asStream(),
      imageFile.lengthSync(),
      filename: 'z',
      contentType: MediaType('image','jpeg'),
    ),
  );

  request.fields.addAll(body);
  var response = await request.send();
  //.then((response) async {
  print("test");
  print(response.statusCode);
  var x;
  print('Response ${x = ((await http.Response.fromStream(response)).body)}');
  //http.Response res = await http.Response.fromStream(response);

  if (response.statusCode == 200) {
    print("Uploaded! $x");
    print('Data Type ${x.runtimeType}');
    callBack(x);
    // Map data1 = jsonDecode((await http.Response.fromStream(response)).body)["doctor_details"];
    // Map data2 = jsonDecode((await http.Response.fromStream(response)).body)["user"];
    //UpdateProfileResponse updateProfileResponse = UpdateProfileResponse.fromJson(jsonDecode((await http.Response.fromStream(response)).body));

    // data1.addAll(data2);
    //
    // print('Date ${data1.toString()}');
    // DoctorDetails mo = DoctorDetails.fromJson(
    //     data1
    // );
    // print(mo.toJson());
  }
  // return
  //   response.
  //   statusCode;
  // var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  // print('Stream in profile pic update ${stream} ${body.toString()}');
  // var length = await imageFile.length();
  // var uri = Uri.parse( BASE_URL + EDIT_PROFILE +"/"+getPrefValue(Keys.ID));
  // var request = new http.MultipartRequest("POST", uri);
  // var multipartFile = new http.MultipartFile('image', stream, length,
  //     filename: '${DateTime.now().millisecond}');
  // request.files.add(multipartFile);
  // request.fields.addAll(body);
  // request.headers.addAll({
  //   'Authorization': 'Bearer $token'
  // });
  // var response = await request.send();
  //
  //
  // response.stream.transform(utf8.decoder).listen((value) {
  //   print('add item Response : $value');
  //
  //   callBack(value);
  //
  //
  // });
}




// 6. Get HomeScreenData
Future<HomeScreen> getHomeData() async {

  Map<String, String> requestHeaders = {
    'Authorization': 'Bearer $token',
  };
  print('Token $token');
  final response =
  await http.get(BASE_URL + EDIT_PROFILE, headers: requestHeaders);
  print('Home screen ${response.body}');
  Map x = jsonDecode(response.body);
  print('Labs ${x['labs']}');
  print('Clinics ${x['clinics']}');
  x.keys.toList().forEach((element) {
    print(element.toString());
  });

  return homeScreenFromMap(response.body);
}

// 7. Get FamilyMember
Future<GetFamilyMember> getFamilyMemberList() async {
  print('Token $token');
  Map<String, String> requestHeaders = {
    'Authorization': 'Bearer $token',
  };
  final response =
  await http.get(BASE_URL + GET_MEMBER, headers: requestHeaders);
  print('Get family member api ${response.body}');
  return getFamilyMemberFromMap(response.body);
}
//8. Add FamilyMember
Future<dynamic>addFamilyMember(first_name,last_name,middle_name,dob,gender,bloodGroup,relation) async {

  Map<String, String> body = {
    'first_name':first_name,
    'last_name':last_name,
    'middle_name':middle_name,
    'dob':dob,
    'gender':gender,
    'blood_group':bloodGroup,
    'relationship':relation,

  };

  Map<String, String> requestHeaders = {
    // 'Content-Type' : 'application/json',
    'Authorization': 'Bearer $token',
  };

  final response = await http.post(
    BASE_URL + GET_MEMBER ,
    headers: requestHeaders,
    body: body,
  );
  print(response.body);
  return response.body;
}

Future<dynamic> checkBeforeAppointment(CheckBeforeRequestModel checkBeforeRequestModel) async {

  Map<String, dynamic> body = checkBeforeRequestModel.toJson();

  Map<String, String> requestHeaders = {
    'Authorization': 'Bearer $token',
  };

  final response = await http.post(
    BASE_URL + CHECK_BEFORE ,
    headers: requestHeaders,
    body: body,
  );
  print(response.body);
  return response.body;
}

addFamilyMemberWithProfilePic(imageFile,first_name,last_name,middle_name,dob,gender,bloodGroup,relation,callBack) async {
  Map<String, String> body = {
    'first_name':first_name,
    'last_name':last_name,
    'middle_name':middle_name,
    'dob':dob,
    'gender':gender,
    'blood_group':bloodGroup,
    'relationship':relation,

  };
  var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  var length = await imageFile.length();
  var uri = Uri.parse(BASE_URL+GET_MEMBER);
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = new http.MultipartFile('image', stream, length,
      filename: imageFile.path);
  request.files.add(multipartFile);
  request.fields.addAll(body);
  request.headers.addAll({
    'Authorization': 'Bearer $token'
  });
  var response = await request.send();

  print(imageFile.path);
  print(BASE_URL+GET_MEMBER);
  response.stream.transform(utf8.decoder).listen((value) {
    callBack(value);
    print('add item Response :'+value);

  });
}

//8. Edit FamilyMember
Future<dynamic>editFamilyMember(hidden_image,first_name,last_name,middle_name,dob,gender,bloodGroup,relation,memberId) async {

  Map<String, String> body = {
    'hidden_image':hidden_image,
    '_method':"PATCH",
    'first_name':first_name,
    'last_name':last_name,
    'middle_name':middle_name,
    'dob':dob,
    'gender':gender,
    'blood_group':bloodGroup,
    'relationship':relation,

  };

  Map<String, String> requestHeaders = {
    // 'Content-Type' : 'application/json',
    'Authorization': 'Bearer $token',
  };
  final response = await http.post(
    BASE_URL + GET_MEMBER +"/"+memberId.toString(),
    headers: requestHeaders,
    body: body,
  );
  return response.body;
}

editFamilyMemberWithProfilePic(imageFile,hidden_image,first_name,last_name,middle_name,dob,gender,bloodGroup,relation,memberId,callBack) async {
  Map<String, String> body = {
    'hidden_image':hidden_image,
    '_method':"PATCH",
    'first_name':first_name,
    'last_name':last_name,
    'middle_name':middle_name,
    'dob':dob,
    'gender':gender,
    'blood_group':bloodGroup,
    'relationship':relation,

  };
  var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  var length = await imageFile.length();
  var uri = Uri.parse( BASE_URL + GET_MEMBER +"/"+memberId.toString());
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = new http.MultipartFile('image', stream, length,
      filename: imageFile.path);
  request.files.add(multipartFile);
  request.fields.addAll(body);
  request.headers.addAll({
    'Authorization': 'Bearer $token'
  });
  var response = await request.send();

  print(imageFile.path);
  print(BASE_URL+GET_MEMBER);
  response.stream.transform(utf8.decoder).listen((value) {
    callBack(value);
    print('add item Response :'+value);

  });
}

Future<AllBlogsResponse> getBlogs() async {

http.Response response;
  try{
     response = await http.get(
      BASE_URL + 'blogs' ,
       //headers: requestHeaders,
      // body: body,
    );
  }
  catch(e){
    throw Exception('Error while fetching data');
  }
  print('Blogs Length ${AllBlogsResponse.fromJson(jsonDecode(response.body)).blogs.length}');
  return AllBlogsResponse.fromJson(jsonDecode(response.body));

}


Future<ReviewsModel> getReviews(String id) async {

  http.Response response;
  try{
    response = await http.get(
      BASE_URL + 'get-doc-lab-review/'+id ,
      headers: requestHeaders,
      // body: body,
    );
  }
  catch(e){
    throw Exception('Error while fetching data');
  }
  print(response.body);
  return ReviewsModel.fromJson(jsonDecode(response.body));

}

Future<MyAppointmentsModel> getMyAppointments() async {

  http.Response response;
  try{
    response = await http.get(
      BASE_URL + 'user-appointments' ,
      headers: requestHeaders,
      // body: body,
    );
  }
  catch(e){
    throw Exception('Error while fetching data');
  }
  print(response.body);
  return MyAppointmentsModel.fromJson(jsonDecode(response.body));

}

Future<ReportResponseModel> getReports() async {

  http.Response response;
  try{
    response = await http.get(
      BASE_URL + 'reports' ,
      headers: requestHeaders,
      // body: body,
    );
  }
  catch(e){
    throw Exception('Error while fetching data');
  }
  print(response.body);
  return ReportResponseModel.fromJson(jsonDecode(response.body));

}
Future<DiagnosisResponseModel> getDiagnosis() async {

  http.Response response;
  try{
    response = await http.get(
      BASE_URL + 'diagnosis' ,
      headers: requestHeaders,
      // body: body,
    );
  }
  catch(e){
    throw Exception('Error while fetching data');
  }
  print(response.body);
  return DiagnosisResponseModel.fromJson(jsonDecode(response.body));

}

Future<dynamic> bookAppointment(BookAppointmentRequestModel bookAppointment) async {
  Map<String, dynamic> body = bookAppointment.toJson();

  print('Json decode ${json.encode(body)}');

  http.Response response;
  try{
    response = await http.post(
      BASE_URL + 'book-appointment' ,
      headers: requestHeaders,
      body: json.encode(body),
    );
    //print('Response ${response.body}');
  }

  catch(e){
    //print('Response ${response.body}');
    print('Error ${e.toString()}');
    throw Exception('Error while fetching data');
  }
  print(response.body);
  return response.body;

}


Future<dynamic> checkNewUserDiscount() async {
  //Map<String, dynamic> body = bookAppointment.toJson();
  http.Response response;
  try{
    response = await http.get(
      BASE_URL + 'check-discount' ,
      headers: requestHeaders,
    //  body: body,
    );
  }
  catch(e){
    print('Error ${e.toString()}');
    throw Exception('Error while fetching data');
  }
  print(response.body);
  return response.body;

}

Future<FAQResponseModel> getFaq()async{
  http.Response response;
  try{
    response = await http.get(
      BASE_URL + 'user-faq',
      headers: requestHeaders,
      // body: body,
    );
    if(jsonDecode(response.body)['status']!=200){
      // todo deleter return line
      return FAQResponseModel.fromJson({
        "status": 200,
        "faqs": [
          {
            "id": 2,
            "que": "How to Use Faq?",
            "ans": "Add Faq From Admin Portal .",
            "created_at": "2020-12-16T12:50:56.000000Z",
            "updated_at": "2020-12-16T12:50:56.000000Z"
          }
        ]
      });
      //throw Exception('Error while fetching data');
    }
  }
  catch(e){
    // todo deleter return line
    return FAQResponseModel.fromJson({
      "status": 200,
      "faqs": [
        {
          "id": 2,
          "que": "How to Use Faq?",
          "ans": "Add Faq From Admin Portal .",
          "created_at": "2020-12-16T12:50:56.000000Z",
          "updated_at": "2020-12-16T12:50:56.000000Z"
        }
      ]
    });
    //throw Exception('Error while fetching data');
  }
  print(response.body);
  return FAQResponseModel.fromJson(jsonDecode(response.body));
}
Map<String, String> requestHeaders = {
  // 'Content-Type' : 'application/json',
   'Content-type': 'application/json',
    'Accept': 'application/json',
  'Authorization': 'Bearer $token',
};

