import 'dart:convert';

import 'package:claveto/models/appointement/all_blogs_response.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/material.dart';

import 'detailed_blog.dart';

class AllBlogs extends StatefulWidget {
  @override
  _AllBlogsState createState() => _AllBlogsState();
}

class _AllBlogsState extends State<AllBlogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: FutureBuilder<AllBlogsResponse>(
          future: getBlogs(),
          builder: (context, snapshot) {
            print('Called snapshot ${snapshot}');
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(snapshot.hasError){
              return Center(
                child: Text(
                  'Error while fetching blogs'
                ),
              );
            }
            else
            return ListView.builder(
                itemCount: snapshot.data.blogs.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  Blogs model = snapshot.data.blogs[index];
                  return new Container(
                    margin: EdgeInsets.all(15),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailedBlog(
                            model: model,
                          )),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xff14B4A5),
                              Color(0xff3883EF),
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  height: 160,
                                  width: MediaQuery.of(context).size.width-30,

                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            topLeft: Radius.circular(15)),
                                        child: Image.network(
                                          'https://s3.cointelegraph.com/uploads/2020-12/a90f95bb-1d64-4b72-80c1-5b27568bdcc6.jpg',
                                          //IMAGE_URL+BLOG_ENDPOINT +model.featuredImage,
                                          fit: BoxFit.fitWidth,
                                        )),
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(model.title,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15))),

                                // Container(
                                //     alignment: Alignment.centerLeft,
                                //     width: MediaQuery.of(context).size.width*0.6,
                                //     padding: EdgeInsets.symmetric(
                                //         horizontal: 10, vertical: 5),
                                //     child: Text(
                                //         model.sortDescription,
                                //
                                //         overflow: TextOverflow.ellipsis,
                                //         maxLines: 2,
                                //         style: TextStyle(
                                //             color: Colors.white,
                                //             fontSize: 18,
                                //             fontWeight: FontWeight.bold))),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Text(model.createdAt.substring(0,10),
                                            style: TextStyle(color: Colors.white,fontSize: 12))),
                                    // Container(
                                    //     padding: EdgeInsets.symmetric(
                                    //         horizontal: 10, vertical: 5),
                                    //     child: Text('5 min read',
                                    //         style: TextStyle(color: Colors.white))),
                                  ],
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        ),
      ),
    );
  }


}
