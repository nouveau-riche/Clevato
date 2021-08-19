import 'package:claveto/models/appointement/all_blogs_response.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailedBlog extends StatefulWidget {
  final Blogs model;

  const DetailedBlog({Key key, this.model}) : super(key: key);
  @override
  _DetailedBlogState createState() => _DetailedBlogState();
}

class _DetailedBlogState extends State<DetailedBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,
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
        ),centerTitle: true,
        // title: Container(width: MediaQuery.of(context).size.width*0.65,height: 45,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(25),
        //       color: Colors.white.withOpacity(0.5)
        //   ),
        //   child: TextFormField(
        //     cursorColor: Colors.black,
        //
        //     decoration: new InputDecoration(
        //         border: InputBorder.none,
        //         focusedBorder: InputBorder.none,
        //         enabledBorder: InputBorder.none,
        //         errorBorder: InputBorder.none,
        //         disabledBorder: InputBorder.none,
        //         contentPadding:
        //         EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
        //         hintText: 'Blog',
        //         hintStyle: TextStyle(color: Colors.white),suffixIcon: Icon(Icons.search,color: Colors.white,)
        //
        //     ),
        //   ),
        // ),
        // actions: [
        //   InkWell(
        //     child: Container(margin: EdgeInsets.only(left: 5,right: 25),
        //         child: Icon(Icons.filter_list,color: Colors.white,)),
        //   )
        // ],
      ),
      body: Container(
        child: ListView.builder
          (
            itemCount: 1,
            itemBuilder: (BuildContext ctxt, int index) {
              return new Container(margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),

                child: InkWell(

                  child: Container(decoration: BoxDecoration(

                   color: Colors.grey.withOpacity(0.1)
                  ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(widget.model.title,style: TextStyle(fontSize: 28),),
                          subtitle: Text(widget.model.sortDescription,style: TextStyle(fontSize: 18),),
                          trailing: Text(widget.model.createdAt.substring(0,10),),
                        ),
                        Container(
                          child:Image.network(IMAGE_URL+BLOG_ENDPOINT + widget.model.featuredImage),
                        ),
                        //HtmlTextView(data: '<body>Hello world! <a href="www.html5rocks.com">HTML5 rocks!'),
                        html(widget.model.description)
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
  Widget html(a) => Html(
    data: """
        $a
      """,
    //Optional parameters:
   // backgroundColor: Colors.white70,
    onLinkTap: (url) {
      // open url in a webview
      print('Url open');
      _launchURL(url);
    },
    style: {
      "div": Style(

      ),
    },
    onImageTap: (src) {
      // Display the image in large form.
    },
  );
  _launchURL(url) async {

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
