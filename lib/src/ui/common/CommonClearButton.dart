import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CommonClearButton extends StatelessWidget {
  final Function onTab;
  final double height;

  const CommonClearButton({
    Key? key,
    required this.onTab,
    this.height = 112,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTab();
      },
      child: Card(
        // margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
              alignment: Alignment.center,
              color: Color(0xffF5F5F5),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text("Clear",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 14, color: Colors.black))),
        ),
      ),
    );
  }
}
