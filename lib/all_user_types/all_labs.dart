import 'package:claveto/lab/lab.dart';
import 'package:claveto/model/home_screen_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../aboutdoctors.dart';

class AllLabsScreen extends StatefulWidget {
  final List<Lab> allLabs;

  const AllLabsScreen({Key key, this.allLabs}) : super(key: key);

  @override
  _AllLabsScreenState createState() => _AllLabsScreenState();
}

class _AllLabsScreenState extends State<AllLabsScreen> {
  List<Lab> allLabs;

  @override
  void initState() {
    allLabs = widget.allLabs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Labs'),
      ),
      body: ListView.builder(
        itemCount: allLabs.length,
        itemBuilder: (_, index) {
          return horizontalLabCard(allLabs[index], context);
        },
      ),
    );
  }
}

Widget horizontalLabCard(Lab lab, BuildContext context) {
  // todo zeyan change the ui and use values from doctor model

  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LabScreen(
                    lab: lab,
                  )));
    },
    child:  Container(margin: EdgeInsets.all(15),
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
          child:  Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  child: Text('Lab\'s ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 130,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(color: Colors.white,child: Image.network('https://img2.pngio.com/download-free-png-experiment-lab-laboratory-icon-with-png-and-lab-vector-png-512_512.png')))),
                  Flexible(
                    child: Container(margin: EdgeInsets.symmetric(horizontal: 9,vertical: 0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Lab Name: ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              Expanded(child: Text('${lab.legalName}',style: TextStyle(color: Colors.white),)),
                            ],
                          ),
                          Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name: ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              Expanded(child: Text('${lab.firstName+" "+lab.middleName+" "+lab.lastName}',style: TextStyle(color: Colors.white),)),
                            ],
                          ),

                          Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Address: ',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              Expanded(child: Text('${lab.address}',style: TextStyle(color: Colors.white,),))
                            ],
                          ),
                          Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('City: ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              Expanded(child: Text('${lab.city}',style: TextStyle(color: Colors.white,),))
                            ],
                          ),
                          Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('State: ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              Text('${lab.state}',style: TextStyle(color: Colors.white,),)
                            ],
                          ),


                          Row(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('PinCode: ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              Text('${lab.pincode}',style: TextStyle(color: Colors.white,),)
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
        ),
      ),
    ),
  );
}
