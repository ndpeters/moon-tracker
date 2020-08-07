import 'package:flutter/material.dart';
import 'package:moon_tracker/utils/clipper.dart';

class MyNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: NavClipper(),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFffffff),
              Colors.blue,
            ],
          ),
        ),
      ),
    );
  }
}

class MyNavButton extends StatelessWidget {
  MyNavButton({Key key, this.text, this.icon, this.active}) : super(key: key);
  final String text;
  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: active ? 100 : 75,
      width: 90,
      // color: Colors.red,
      child: Column(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(seconds:5),
                      child: CircleAvatar(
              radius: active ? 30 : 20,
              backgroundColor: active ? Colors.black.withBlue(155).withAlpha(155) : Colors.black54,
              child: CircleAvatar(
                radius: active ? 25 : 15,
                backgroundColor:
                    active ? Colors.white : Colors.grey.shade100,
                child: Icon(
                  icon,
                  color: active ? Colors.black.withBlue(155).withAlpha(155) : Colors.black54,
                ),
              ),
            ),
          ),
          SizedBox(height: active ? 13 : 14),
          Text(
            text,
            style: active
                ? TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)
                : TextStyle(fontSize: 0, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
