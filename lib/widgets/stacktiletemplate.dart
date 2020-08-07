import 'package:flutter/material.dart';

class StackTileTemplate extends StatelessWidget {
  final double positionedValue;
  final double containerHeight;
  final double cardWidth;
  final double cardHeight;
  final int cardAmount;
  final Widget content;

  StackTileTemplate(
      {@required this.positionedValue,
      this.cardWidth,
      this.cardHeight,
      this.containerHeight,
      this.cardAmount,
      this.content});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: positionedValue,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            Container(
              height: (containerHeight + ((2 * cardAmount) * 2)),
              width: cardWidth,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    for (var i = 0; i < cardAmount; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Container(
                          height: cardHeight,
                          width: cardWidth,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                            color: Colors.white.withOpacity(.30)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: content,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
