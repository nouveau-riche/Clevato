// To parse this JSON data, do
//
//     final homeScreen = homeScreenFromMap(jsonString);

import 'dart:convert';

HomeScreen homeScreenFromMap(String str) => HomeScreen.fromMap(json.decode(str));

String homeScreenToMap(HomeScreen data) => json.encode(data.toMap());

class HomeScreen {
  HomeScreen({
    this.doctors,
    this.symptoms,
    this.categories,
    this.clinics,
    this.labs,
    this.banners
  });

  List<Doctor> doctors;
  List<Symptoms> symptoms;
  List<Category> categories;
  List<Clinic> clinics;
  List<Lab> labs;
  List<Banners> banners;

  factory HomeScreen.fromMap(Map<String, dynamic> json) => HomeScreen(
    doctors: List<Doctor>.from(json["doctors"].map((x) => Doctor.fromMap(x))),
    symptoms: List<Symptoms>.from(json["symptoms"].map((x) => Symptoms.fromMap(x))),
    categories: List<Category>.from(json["categories"].map((x) => Category.fromMap(x))),
    clinics: List<Clinic>.from(json["clinics"].map((x) => Clinic.fromMap(x))),
    labs: List<Lab>.from(json["labs"].map((x) => Lab.fromMap(x))),
    banners: List<Banners>.from(json["banners"].map((x) => Banners.fromJson(x))),
  );

  Map<String, dynamic> toMap() => {
    "doctors": List<dynamic>.from(doctors.map((x) => x.toMap())),
    "symptoms": List<dynamic>.from(symptoms.map((x) => x.toMap())),
    "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
    "clinics": List<dynamic>.from(clinics.map((x) => x.toMap())),
    "labs": List<dynamic>.from(labs.map((x) => x.toMap())),
    "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
  };
}

class Symptoms {
  Symptoms({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.icon,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  String icon;

  factory Symptoms.fromMap(Map<String, dynamic> json) => Symptoms(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    icon: json["icon"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "icon": icon,
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.fees,
    this.createdAt,
    this.updatedAt,
    this.icon,
  });

  int id;
  String name;
  String fees;
  DateTime createdAt;
  DateTime updatedAt;
  String icon;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    fees: json["fees"] == null ? null : json["fees"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    icon: json["icon"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "fees": fees == null ? null : fees,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "icon": icon,
  };
}

class Clinic {
  Clinic({
    this.id,
    this.userId,
    this.legalName,
    this.firstName,
    this.middleName,
    this.lastName,
    this.address,
    this.state,
    this.city,
    this.pincode,
    this.long,
    this.lat,
    this.googleSearchName,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String legalName;
  String firstName;
  String middleName;
  String lastName;
  String address;
  String state;
  String city;
  String pincode;
  String long;
  String lat;
  String googleSearchName;
  DateTime createdAt;
  DateTime updatedAt;

  factory Clinic.fromMap(Map<String, dynamic> json) => Clinic(
    id: json["id"],
    userId: json["user_id"],
    legalName: json["legal_name"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    address: json["address"],
    state: json["state"],
    city: json["city"],
    pincode: json["pincode"],
    long: json["long"],
    lat: json["lat"],
    googleSearchName: json["google_search_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "legal_name": legalName,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "address": address,
    "state": state,
    "city": city,
    "pincode": pincode,
    "long": long,
    "lat": lat,
    "google_search_name": googleSearchName,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
class Doctor {
  int id;
  String name;
  String email;
  String phone;
  String emailVerifiedAt;
  String avatar;
  int isAdmin;
  String userType;
  int isActive;
  String createdAt;
  String updatedAt;
  int userId;
  int clinicDetailsId;
  String firstName;
  String middleName;
  String lastName;
  String dob;
  String gender;
  String expCerti;
  String degreeCerti;
  String grNo;
  int catagoryId;
  String startTime;
  String endTime;
  String adharNo;
  String address;
  String state;
  String city;
  String pincode;
  String appType;
  String speciality;
  String description;
  int isFeatured;

  Doctor(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.emailVerifiedAt,
        this.avatar,
        this.isAdmin,
        this.userType,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.clinicDetailsId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.dob,
        this.gender,
        this.expCerti,
        this.degreeCerti,
        this.grNo,
        this.catagoryId,
        this.startTime,
        this.endTime,
        this.adharNo,
        this.address,
        this.state,
        this.isFeatured,
        this.city,
        this.pincode,
        this.appType,
        this.speciality,
        this.description});

  Doctor.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    avatar = json['avatar'];
    isAdmin = json['is_admin'];
    userType = json['user_type'];
    isActive = json['is_active'];
    isFeatured = json['is_featured'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    clinicDetailsId = json['clinic_details_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    dob = json['dob'];
    gender = json['gender'];
    expCerti = json['exp_certi'];
    degreeCerti = json['degree_certi'];
    grNo = json['gr_no'];
    catagoryId = json['catagory_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    adharNo = json['adhar_no'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    appType = json['app_type'];
    speciality = json['speciality'];
    description = json['description'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['avatar'] = this.avatar;
    data['is_admin'] = this.isAdmin;
    data['user_type'] = this.userType;
    data['is_active'] = this.isActive;
    data['is_featured']=this.isFeatured;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['clinic_details_id'] = this.clinicDetailsId;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['exp_certi'] = this.expCerti;
    data['degree_certi'] = this.degreeCerti;
    data['gr_no'] = this.grNo;
    data['catagory_id'] = this.catagoryId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['adhar_no'] = this.adharNo;
    data['address'] = this.address;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['app_type'] = this.appType;
    data['speciality'] = this.speciality;
    data['description'] = this.description;
    return data;
  }
}

// class Doctor {
//   Doctor({
//     this.id,
//     this.userId,
//     this.clinicDetailsId,
//     this.firstName,
//     this.middleName,
//     this.lastName,
//     this.dob,
//     this.gender,
//     this.expCerti,
//     this.degreeCerti,
//     this.grNo,
//     this.catagoryId,
//     this.startTime,
//     this.endTime,
//     this.adharNo,
//     this.address,
//     this.state,
//     this.city,
//     this.pincode,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   int id;
//   int userId;
//   int clinicDetailsId;
//   String firstName;
//   String middleName;
//   String lastName;
//   DateTime dob;
//   String gender;
//   String expCerti;
//   String degreeCerti;
//   String grNo;
//   int catagoryId;
//   String startTime;
//   String endTime;
//   String adharNo;
//   String address;
//   String state;
//   String city;
//   String pincode;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory Doctor.fromMap(Map<String, dynamic> json) => Doctor(
//     id: json["id"],
//     userId: json["user_id"],
//     clinicDetailsId: json["clinic_details_id"],
//     firstName: json["first_name"] == null ? null : json["first_name"],
//     middleName: json["middle_name"] == null ? null : json["middle_name"],
//     lastName: json["last_name"] == null ? null : json["last_name"],
//     dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
//     gender: json["gender"] == null ? null : json["gender"],
//     expCerti: json["exp_certi"] == null ? null : json["exp_certi"],
//     degreeCerti: json["degree_certi"] == null ? null : json["degree_certi"],
//     grNo: json["gr_no"] == null ? null : json["gr_no"],
//     catagoryId: json["catagory_id"],
//     startTime: json["start_time"] == null ? null : json["start_time"],
//     endTime: json["end_time"] == null ? null : json["end_time"],
//     adharNo: json["adhar_no"] == null ? null : json["adhar_no"],
//     address: json["address"] == null ? null : json["address"],
//     state: json["state"] == null ? null : json["state"],
//     city: json["city"] == null ? null : json["city"],
//     pincode: json["pincode"] == null ? null : json["pincode"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "user_id": userId,
//     "clinic_details_id": clinicDetailsId,
//     "first_name": firstName == null ? null : firstName,
//     "middle_name": middleName == null ? null : middleName,
//     "last_name": lastName == null ? null : lastName,
//     "dob": dob == null ? null : "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
//     "gender": gender == null ? null : gender,
//     "exp_certi": expCerti == null ? null : expCerti,
//     "degree_certi": degreeCerti == null ? null : degreeCerti,
//     "gr_no": grNo == null ? null : grNo,
//     "catagory_id": catagoryId,
//     "start_time": startTime == null ? null : startTime,
//     "end_time": endTime == null ? null : endTime,
//     "adhar_no": adharNo == null ? null : adharNo,
//     "address": address == null ? null : address,
//     "state": state == null ? null : state,
//     "city": city == null ? null : city,
//     "pincode": pincode == null ? null : pincode,
//     "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//     "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//   };
// }

class Lab {
  Lab({
    this.id,
    this.userId,
    this.legalName,
    this.firstName,
    this.middleName,
    this.lastName,
    this.labCerti,
    this.permissionCerti,
    this.pci,
    this.cea,
    this.startTime,
    this.endTime,
    this.address,
    this.state,
    this.city,
    this.pincode,
    this.long,
    this.lat,
    this.googleSearchName,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String legalName;
  String firstName;
  String middleName;
  String lastName;
  String labCerti;
  String permissionCerti;
  String pci;
  String cea;
  String startTime;
  String endTime;
  String address;
  String state;
  String city;
  String pincode;
  String long;
  String lat;
  String googleSearchName;
  dynamic createdAt;
  DateTime updatedAt;

  factory Lab.fromMap(Map<String, dynamic> json) => Lab(
    id: json["id"],
    userId: json["user_id"],
    legalName: json["legal_name"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    labCerti: json["lab_certi"],
    permissionCerti: json["permission_certi"],
    pci: json["pci"],
    cea: json["cea"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    address: json["address"],
    state: json["state"],
    city: json["city"],
    pincode: json["pincode"],
    long: json["long"],
    lat: json["lat"],
    googleSearchName: json["google_search_name"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "legal_name": legalName,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "lab_certi": labCerti,
    "permission_certi": permissionCerti,
    "pci": pci,
    "cea": cea,
    "start_time": startTime,
    "end_time": endTime,
    "address": address,
    "state": state,
    "city": city,
    "pincode": pincode,
    "long": long,
    "lat": lat,
    "google_search_name": googleSearchName,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
  };
}
class Banners {
  int id;
  String bannerName;
  String bannerImage;
  String createdAt;
  String updatedAt;

  Banners(
      {this.id,
        this.bannerName,
        this.bannerImage,
        this.createdAt,
        this.updatedAt});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerName = json['banner_name'];
    bannerImage = json['banner_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner_name'] = this.bannerName;
    data['banner_image'] = this.bannerImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}