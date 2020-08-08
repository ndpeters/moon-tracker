import 'package:flutter/material.dart';
import 'package:moon_tracker/utils/clipper.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 122,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black87,
            Colors.transparent,
          ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: AppBarClipper(),
            child: SafeArea(
                          child: Container(
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.width,
                // color: Color(0xFFaba197),
                 decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Color(0xFFaba197),
              Colors.blue,
              Color(0xFFffffff),
              // Color(0xFF00c473),
            ],
          ),
        ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 10 - 10,
            left: MediaQuery.of(context).size.width / 2 - 25,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey.shade100,
                ),
                CircleAvatar(
                  radius: 23,
                  // TODO: set a profile image
                  // backgroundImage: null,
                  backgroundColor: Colors.grey.shade500,
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 7 - 13,
            left: MediaQuery.of(context).size.width / 1.79,
            child: CircleAvatar(
              radius: 8.5,
              backgroundColor: Colors.white,
              // ----------------
              child: FittedBox(
                              child: Icon(
                  Icons.add,
                  color: Colors.black87,
                ),
              ),
              // ----------------
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 60.0, 15.0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu, size: 32,), 
                color: Colors.black.withBlue(155).withAlpha(155), 
                onPressed: (){print('menu pressed');},
                ),
                IconButton(
                icon: Icon(Icons.exit_to_app, size: 32,), 
                color: Colors.black.withBlue(155).withAlpha(155), 
                onPressed: (){print('log out pressed');},
                ),
            ],),
          ),
        ],
      ),
    );
  }
}
