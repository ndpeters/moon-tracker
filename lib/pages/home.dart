import 'package:flutter/material.dart';
import 'package:moon_tracker/pages/friends.dart';
import 'package:moon_tracker/pages/messages.dart';
import 'package:moon_tracker/pages/news.dart';
import 'package:moon_tracker/widgets/myappbar.dart';
import 'package:moon_tracker/widgets/mynav.dart';
import 'package:moon_tracker/shared/constants.dart' as Constants;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selected = 'News';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //!_______ Body _________
          loadBodyContent(_selected) ?? Container(),
          //!_______ AppBar _________
          MyAppBar(),
          //!_______ Navbar _________
          Positioned(
            bottom: 0,
            child: MyNavBar(),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _selected = changeNavSelection('Friends');
                      });
                    },
                    child: MyNavButton(
                        text: 'Friends',
                        icon: Icons.group,
                        active: _selected == 'Friends')),
                SizedBox(width: 1),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _selected = changeNavSelection('News');
                      });
                    },
                    child: MyNavButton(
                        text: 'News',
                        icon: Icons.storage,
                        active: _selected == 'News')),
                SizedBox(width: 1),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _selected = changeNavSelection('Messages');
                      });
                    },
                    child: MyNavButton(
                        text: 'Messages',
                        icon: Icons.forum,
                        active: _selected == 'Messages')),
              ],
            ),
          ),
          //! this is for testing
          // Positioned(
          //   bottom: 105,
          //   child: Center(
          //     child: Container(
          //       width: MediaQuery.of(context).size.width,
          //       child: FloatingActionButton(onPressed: () {
          //         setState(() {
          //           // (context as Element).reassemble();
          //           Navigator.pushReplacement(context,
          //               MaterialPageRoute(builder: (context) => HomePage()));
          //         });
          //       }),
          //     ),
          //   ),
          // ),
          
          //! this is for testing
          // Positioned(
          //   bottom: 185,
          //   child: Center(
          //     child: GestureDetector(
          //       onTap: () => Navigator.pop(context),
          //       child: Container(
          //         color: Colors.red,
          //         height: 25,
          //         width: MediaQuery.of(context).size.width,
          //         child: null,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  String changeNavSelection(newSelection) {
    String selected;
    selected = newSelection;
    return selected;
  }

  loadBodyContent(_selection) {
    try {
      switch (_selection) {
        case 'Friends':
          return AnimatedContainer(
              duration: Duration(milliseconds: Constants.FADE_TIMER),
              color: Colors.red.shade100,
              child: MyFriends());
          break;
        case 'News':
          return AnimatedContainer(
              duration: Duration(milliseconds: Constants.FADE_TIMER),
              color: Colors.yellow.shade100,
              child: MyNews());
          break;
        case 'Messages':
          return AnimatedContainer(
              duration: Duration(milliseconds: Constants.FADE_TIMER),
              color: Colors.blue.shade100,
              child: MyMessages());
          break;
        default:
      }
    } catch (e) {
      print(e);
    }
  }
}
