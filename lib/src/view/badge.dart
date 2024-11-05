library icon_badge;

import 'package:flutter/material.dart';

class IconBadge extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;
  final int itemCount;
  final bool hideZero;
  final Color badgeColor;
  final Color itemColor;
  final double top;
  final double right;
  final int maxCount;

  const IconBadge({
    Key? key,
    this.onTap,
    required this.icon,
    this.itemCount = 0,
    this.hideZero = false,
    this.badgeColor = const Color(0xFF56C3E3),
    this.itemColor = Colors.white,
    this.maxCount = 99,
    this.top = 8.0,
    this.right = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return itemCount == 0 && hideZero
        ? GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: 65,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Image.asset(icon),
                    ],
                  ),
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: 65,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Image.asset(icon),
                    ],
                  ),
                  Positioned(
                    top: top,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: badgeColor,
                      ),
                      alignment: Alignment.center,
                      child: itemCount > maxCount
                          ? Text(
                              '$maxCount+',
                              style: TextStyle(
                                color: itemColor,
                                fontSize: 8.0,
                              ),
                            )
                          : Text(
                              '$itemCount',
                              style: TextStyle(
                                color: itemColor,
                                fontSize: 8.0,
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
