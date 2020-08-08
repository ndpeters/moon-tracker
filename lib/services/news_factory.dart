import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsFactory {
  NewsFactory(this.url);
  final String url;

  Future <List<Map<String, dynamic>>> getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;

      /*
        Below I returned the data which is a String.
            
            -   I'm not sure if jsonDecode is needed since there 
                aren't any other values within the response 
                besides the fact. 
            -   I have left the original code for jsonDecode if you
                decide to mess around with the data.
      */
      List<Map<String, dynamic>> object = [
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
      object[0] = {
        'author': jsonDecode(data)['articles'][0]['author'],
        'title': jsonDecode(data)['articles'][0]['title'],
        'description': jsonDecode(data)['articles'][0]['description'],
        'img': jsonDecode(data)['articles'][0]['urlToImage'],
        'url': jsonDecode(data)['articles'][0]['url']
      };
      object[1] = {
        'author': jsonDecode(data)['articles'][1]['author'],
        'title': jsonDecode(data)['articles'][1]['title'],
        'description': jsonDecode(data)['articles'][1]['description'],
        'img': jsonDecode(data)['articles'][1]['urlToImage'],
        'url': jsonDecode(data)['articles'][1]['url']
      };
      object[2] = {
        'author': jsonDecode(data)['articles'][2]['author'],
        'title': jsonDecode(data)['articles'][2]['title'],
        'description': jsonDecode(data)['articles'][2]['description'],
        'img': jsonDecode(data)['articles'][2]['urlToImage'],
        'url': jsonDecode(data)['articles'][2]['url']
      };
      object[3] = {
        'author': jsonDecode(data)['articles'][3]['author'],
        'title': jsonDecode(data)['articles'][3]['title'],
        'description': jsonDecode(data)['articles'][3]['description'],
        'img': jsonDecode(data)['articles'][3]['urlToImage'],
        'url': jsonDecode(data)['articles'][3]['url']
      };
print(object);
      // return jsonDecode(data);
      // print(jsonDecode(data)['articles'][0]['author']);
      // print(jsonDecode(data)['articles'][2]['title']);
      // print(jsonDecode(data)['articles'][0]['description']);
      // print(jsonDecode(data)['articles'][0]['url']);
      return object;
    } else {
      print(response.statusCode);
    }
  }
}
