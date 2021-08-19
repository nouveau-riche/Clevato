
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'chatScreen.dart';

Color bg = Colors.black;
// TODO Change bg color
class Chat extends StatelessWidget {
  final String peerId, userID,id;
  final Uint8List uint8list;
  final String patientName;
  Chat({
    Key key,
    @required this.peerId,
    @required this.userID, this.uint8list, this.id, this.patientName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        appBar: AppBar(
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
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Text('Customer Support'),
          centerTitle: false,
          actions: [

          ],

        ),
        backgroundColor: bg,
        body: ChatScreen(
          userID: userID,
          adminId: peerId,
uint8list: uint8list,
          id: id,
          pateintName: patientName,
        ),
      ),
    );
  }
}
