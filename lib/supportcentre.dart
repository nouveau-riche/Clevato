import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportCentre extends StatefulWidget {
  @override
  _SupportCentreState createState() => _SupportCentreState();
}

class _SupportCentreState extends State<SupportCentre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Support Centre",style:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 20)),),
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

      body:
      SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),padding: EdgeInsets.all(15),
            width:MediaQuery.of(context).size.width ,
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.withOpacity(0.3),width: 2),

            ),
            child:
            Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Text("Your Recent Tickets",style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 15),color: Colors.lightBlueAccent.withOpacity(0.7)))),
                    InkWell(
                      onTap: () {
                        
                      },
                      child: Container(margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: Text("See All",style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 15),color: Colors.lightBlueAccent.withOpacity(0.7)))),
                    )
                  ],),
                Column(
                  children: [
                    ListTile(
                        leading: CircleAvatar(backgroundColor: Colors.grey,),
                        trailing:Container(width: MediaQuery.of(context).size.width*0.2,
                          margin: EdgeInsets.symmetric(horizontal: 1,vertical: 5),padding: EdgeInsets.symmetric(horizontal: 1,vertical: 1),
                          decoration: BoxDecoration(
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
                              child: Text('pending',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 10)),),  onPressed: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => Signup()),
//                );
                          }
                          ),
                        ),
                        title:Text("Ticket title and date"),
                      subtitle: Text('Ticket ID and details'),
                    ),
                    ListTile(
                      leading: CircleAvatar(backgroundColor: Colors.amber,),
                      trailing:Container(width: MediaQuery.of(context).size.width*0.2,
                        margin: EdgeInsets.symmetric(horizontal: 1,vertical: 5),padding: EdgeInsets.symmetric(horizontal: 1,vertical: 1),
                        decoration: BoxDecoration(
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
                            child: Text('pending',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 10)),),  onPressed: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => Signup()),
//                );
                        }
                        ),
                      ),
                      title:Text("Ticket title and date"),
                      subtitle: Text('Ticket ID and details'),
                    ),
                  ],
                ),
              ],
            )

          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),padding: EdgeInsets.all(15),
              width:MediaQuery.of(context).size.width ,
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.withOpacity(0.3),width: 2),

              ),
              child:
              Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: Text("Recent Orders",style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 15),color: Colors.lightBlueAccent.withOpacity(0.7)))),
                      InkWell(
                        onTap: () {

                        },
                        child: Container(margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            child: Text("See All",style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 15),color: Colors.lightBlueAccent.withOpacity(0.7)))),
                      )
                    ],),
                  Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(backgroundColor: Colors.grey,),
                        trailing:Container(width: MediaQuery.of(context).size.width*0.2,
                          margin: EdgeInsets.symmetric(horizontal: 1,vertical: 5),padding: EdgeInsets.symmetric(horizontal: 1,vertical: 1),
                          decoration: BoxDecoration(
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
                              child: Text('Raise \nIssue',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 10)),),  onPressed: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => Signup()),
//                );
                          }
                          ),
                        ),
                        title:Text("Order title and date"),
                        subtitle: Text('Order title and date'),
                      ),
                      ListTile(
                        leading: CircleAvatar(backgroundColor: Colors.amber,),
                        trailing:Container(width: MediaQuery.of(context).size.width*0.2,
                          margin: EdgeInsets.symmetric(horizontal: 1,vertical: 5),padding: EdgeInsets.symmetric(horizontal: 1,vertical: 1),
                          decoration: BoxDecoration(
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
                              child: Text('Raise \nIssue',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 10)),),  onPressed: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => Signup()),
//                );
                          }
                          ),
                        ),
                        title:Text("Order title and date"),
                        subtitle: Text('Order title and date'),
                      ),
                      ListTile(
                        leading: CircleAvatar(backgroundColor: Colors.redAccent,),
                        trailing:Container(width: MediaQuery.of(context).size.width*0.2,
                          margin: EdgeInsets.symmetric(horizontal: 1,vertical: 5),padding: EdgeInsets.symmetric(horizontal: 1,vertical: 1),
                          decoration: BoxDecoration(
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
                              child: Text('Raise \nIssue',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 10)),),  onPressed: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => Signup()),
//                );
                          }
                          ),
                        ),
                        title:Text("Order title and date"),
                        subtitle: Text('Order title and date'),
                      ),
                      ListTile(
                        leading: CircleAvatar(backgroundColor: Colors.pinkAccent,),
                        trailing:Container(width: MediaQuery.of(context).size.width*0.2,
                          margin: EdgeInsets.symmetric(horizontal: 1,vertical: 5),padding: EdgeInsets.symmetric(horizontal: 1,vertical: 1),
                          decoration: BoxDecoration(
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
                              child: Text('Raise \nIssue',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 10)),),  onPressed: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => Signup()),
//                );
                          }
                          ),
                        ),
                        title:Text("Order title and date"),
                        subtitle: Text('Order title and date'),
                      ),
                    ],
                  ),
                ],
              )

          ),



        ],),
      ),
    );
  }
}
