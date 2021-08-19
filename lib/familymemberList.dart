import 'package:claveto/add_family_member.dart';
import 'package:claveto/common/loading.dart';
import 'package:claveto/edit_family_member.dart';
import 'package:claveto/model/get_family_member_model.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FamilyMemberList extends StatefulWidget {
  @override
  _FamilyMemberListState createState() => _FamilyMemberListState();
}

class _FamilyMemberListState extends State<FamilyMemberList> {
  List<FamilyMember> allFamilyMember = List<FamilyMember>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1000), () {
      getFmilyMemberAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Members",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMember()),
          );
        },
        //backgroundColor: ,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff14B4A5),
                Color(0xff3883EF),
              ],
            ),
          ),
          child: Icon(Icons.add, size: 40),
        ),
      ),
      body: allFamilyMember.length==0?Center(
        child: Text('No Family Member'),
      ):ListView.builder(
        itemCount: allFamilyMember.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      allFamilyMember[index].firstName,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 18)),
                    ),
                    Text(
                      allFamilyMember[index].middleName,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 18)),
                    ),
                    Text(
                      allFamilyMember[index].lastName,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 18)),
                    ),
                    Text(
                      ", " + allFamilyMember[index].relationship,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 16)),
                    ),
                  ],
                ),
                InkWell(
                    onTap: () {
                    var temp=  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditMember(familyMember: allFamilyMember[index],)),
                      ).then((value) {
                      print(value);

                      if(value == true){
                          getFmilyMemberAPI();
                        }
                    });
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.lightBlueAccent.withOpacity(0.5),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> getFmilyMemberAPI() async {
    showDialog(context: context, builder: (context) => Loading());
    await getFamilyMemberList().then((response) {
      allFamilyMember = response.familyMembers;
      print(allFamilyMember.length);
      setState(() {});
    });
    Navigator.pop(context);
  }
}
