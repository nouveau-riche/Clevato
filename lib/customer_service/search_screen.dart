import 'package:claveto/all_user_types/all_clinics_screen.dart';
import 'package:claveto/all_user_types/all_doctors.dart';
import 'package:claveto/all_user_types/all_labs.dart';
import 'package:claveto/model/home_screen_model.dart';
import 'package:flutter/material.dart';

import '';

class SearchScreen extends StatefulWidget {
  final List<Doctor> allDoctors;

  final List<Symptoms> allsymptoms;

  final List<Category> allcategories;

  final List<Clinic> allclinics;

  final List<Lab> alllabs;

  const SearchScreen(
      {Key key,
      this.allDoctors,
      this.allsymptoms,
      this.allcategories,
      this.allclinics,
      this.alllabs})
      : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Doctor> allDoctors = [];

  List<Symptoms> allSymptoms = [];
  List<Category> allCategories = [];
  List<Clinic> allClinics = [];
  List<Lab> allLabs = [];
  bool isSearchingItems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSearchingItems = false;
    allDoctors = widget.allDoctors;
    allSymptoms = widget.allsymptoms;
    allCategories = widget.allcategories;
    allClinics = widget.allclinics;
    allLabs = widget.alllabs;
  }

  List filteredList = [];
  Map filteredMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
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
        centerTitle: true,
        title: Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white.withOpacity(0.5)),
          child: TextFormField(
            cursorColor: Colors.black,
            onChanged: (value) {
              searchByName(value);
            },
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: 'Search..',
                hintStyle: TextStyle(color: Colors.white),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          ),
        ),
        // actions: [
        //   InkWell(
        //     child: Container(
        //         margin: EdgeInsets.only(left: 5, right: 25),
        //         child: Icon(
        //           Icons.filter_list,
        //           color: Colors.white,
        //         )),
        //   )
        // ],
      ),
      body: Container(
        child: filteredMap == null
            ? Center(
                child: Text('Search Here'),
              )
            : filteredMap.values.toList().isEmpty
                ? Center(child: Text('No item found'))
                : ListView.separated(
                    itemCount: filteredMap.values.toList().length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemBuilder: (BuildContext ctxt, int index) {
                      print(
                          'List ${filteredMap.values.toList().isEmpty} ${filteredMap.values.toList().length}');
                      if (filteredMap.values.toList().isEmpty) {
                        return Center(child: Text('No item found'));
                      } else
                        switch (filteredMap.keys
                            .toList()[index]
                            .toString()
                            .substring(0, 1)) {
                          case '1':
                            return horizontalDoctorCard(filteredMap.values
                                .toList()[index],
                                context);
                            break;
                          case '2': //
                            return horizontalLabCard(filteredMap.values
                                .toList()[index], context);

                          case '3': //
                            return horizontalClinicCard(filteredMap.values
                                .toList()[index], context, allDoctors);
                        }
                      return horizontalClinicCard(filteredMap.values
                          .toList()[index], context, allDoctors);
                    }),
      ),
    );
  }

  searchByName(String name) {
    filteredMap = {};
    isSearchingItems = true;
    setState(() {});
    print('All doctors Length ${allDoctors.length}');
    for (int i = 0; i < allDoctors.length; i++) {
      Doctor element = allDoctors[i];
      bool shouldSearch = true;

      print('Searching $i ${element.middleName}');
      if(shouldSearch) {
        if (element.middleName != null) {
          if (element.middleName.toLowerCase().contains(name.toLowerCase())) {
            print('Element Found ${element.userId}');
            //filteredMap = {'1${element.userId}': element};
            filteredMap['1${element.userId}'] = element;
            shouldSearch = false;
          }
        }
      }
      // else if (element.lastName != null) {
      //   if (element.lastName.toLowerCase().contains(name.toLowerCase())) {
      //     print('Element Found ${element.userId}');
      //     //filteredMap = {'1${element.userId}': element};
      //     filteredMap['1${element.userId}'] = element;
      //   }
      // }
      // else if (element.firstName != null) {
      //   if (element.firstName.toLowerCase().contains(name.toLowerCase())) {
      //     print('Element Found ${element.userId}');
      //     //filteredMap = {'1${element.userId}': element};
      //     filteredMap['1${element.userId}'] = element;
      //   }
      // }


    }
    print('All Labs Length ${allLabs.length}');
    for (int i = 0; i < allLabs.length; i++) {
      Lab element = allLabs[i];
      print('Searching $i ${element.legalName}');
      if (element.legalName != null) {
        if (element.legalName.toLowerCase().contains(name.toLowerCase())) {
          print('Element Found ${element.userId}');
          //filteredMap = {'1${element.userId}': element};
          filteredMap['2${element.userId}'] = element;
        }
      }
    }
    print('All Labs Length ${allLabs.length}');
    for (int i = 0; i < allClinics.length; i++) {
      Clinic element = allClinics[i];
      print('Searching $i ${element.legalName}');
      if (element.legalName != null) {
        if (element.legalName.toLowerCase().contains(name.toLowerCase())) {
          print('Element Found ${element.userId}');
          //filteredMap = {'1${element.userId}': element};
          filteredMap['3${element.userId}'] = element;
        }
      }
    }
    isSearchingItems = false;
    setState(() {});
  }
}
