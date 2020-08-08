import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:moon_tracker/services/news_factory.dart';



class MyNewsArticle extends StatefulWidget {
  final screenWidth;
  final i;

  MyNewsArticle({@required this.screenWidth, @required this.i});

  @override
  _MyNewsArticleState createState() => _MyNewsArticleState();
}

class _MyNewsArticleState extends State<MyNewsArticle> {
String key = '0a57e72ce8474c749595f074dd00bb32';
List<Map<String, dynamic>> articles = [
          {
          'author': '',
          'title': '',
          'description': '',
          'img': '',
          'url': '',
        },
        {
          'author': '',
          'title': '',
          'description': '',
          'img': '',
          'url': '',
        },
        {
          'author': '',
          'title': '',
          'description': '',
          'img': '',
          'url': '',
        },
        {
          'author': '',
          'title': '',
          'description': '',
          'img': '',
          'url': '',
        },
];
bool requestComplete;

@override
initState(){
requestComplete = false;
getNews();
super.initState();
}

getNews() async {
String url = 'http://newsapi.org/v2/top-headlines?country=ca&category=business&apiKey=$key';
  NewsFactory newsFactory = new NewsFactory(url);
  newsFactory.getData().then((value) {
    // print(value[0]['author']);
    articles[0] = value[0];
    articles[1] = value[1];
    articles[2] = value[2];
    articles[3] = value[3];
    // print(articles);
      
    requestComplete = true;
    setState(() {
      
    });
  });
  // // // This example uses the Google Books API to search for books about http.
  // // // https://developers.google.com/books/docs/overview
  // // // var url = 'https://www.googleapis.com/books/v1/volumes?q={$arguments}';

  // // // Await the http get response, then decode the json-formatted response.
  // // var response = await http.get(url);
  // // if (response.statusCode == 200) {
  // //   var jsonResponse = convert.jsonDecode(response.body);
  // //   print(response.body);
  // //   var itemCount = jsonResponse['totalItems'];
  // //   // print('Number of books about http: $itemCount.');
  // // } else {
  // //   print('Request failed with status: ${response.statusCode}.');
  // // }
}

  @override
  Widget build(BuildContext context) {

    if(requestComplete){

      return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 3.0, 8.0, 3.0),
      child: Container(
        height: 70,
        width: widget.screenWidth - 16,
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: new BorderRadius.all(Radius.circular(15.0)),
            color: Colors.white.withOpacity(.30)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          //TODO: create card styles and a seperate widget
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    //! this will be the article image
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            child: Image.network(articles[widget.i]['img'], fit: BoxFit.cover,),
                          ),
                        ],
                      ),
                    ),
                    //! this will be the article headline + author
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0, left: 4.0),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text('${articles[widget.i]['title'].toString().substring(0, 13).trim()}...',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              ),
                              Container(
                                height: 25,
                                child: articles[widget.i]['author'].toString().length >15 ? 
                                Text('${articles[widget.i]['author'].toString().substring(0, 15)}...',
                                    style: TextStyle(fontSize: 12)):
                                    Text('${articles[widget.i]['author'].toString().substring(0)}...',
                                    style: TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                      //! this will be a small portion of the content
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Container(
                              width: widget.screenWidth / 2.15,
                              child: Text(
                                  '${articles[widget.i]['description'].toString().substring(0, 95)}...',
                                  style: TextStyle(fontSize: 10)),
                            ),
                          ),
                        ],
                      ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    } else {
      return Center(child: Container(child: Text('...'),));
    }
  }
}
