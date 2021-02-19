import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FacebookButton extends StatelessWidget {
  final GestureTapCallback onTap;
  const FacebookButton({Key key, @required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: ScreenUtil.screenWidthDp * .95,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFF4267B3),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(
              FontAwesome.facebook,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: VerticalDivider(
                thickness: 2,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Text('Logar com Facebook',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50),
                  textScaleFactor: ScreenUtil().scaleText),
            )
          ],
        ),
      ),
    );
  }
}
