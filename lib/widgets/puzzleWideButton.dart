import 'package:axie_scholarship/models/screenSize.dart';
import 'package:axie_scholarship/shared/colors.dart';
import 'package:axie_scholarship/shared/trapZoidClipper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PuzzleWideButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color trapZoidColor;
  final String text;
  const PuzzleWideButton(
      {Key? key,
      required this.onPressed,
      required this.trapZoidColor,
      required this.text})
      : super(key: key);

  @override
  _PuzzleWideButtonState createState() => _PuzzleWideButtonState();
}

class _PuzzleWideButtonState extends State<PuzzleWideButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.all(
            Radius.circular(context.read<ScreenSize>().width * .0227)),
        child: Container(
          width: context.read<ScreenSize>().width * .9,
          height: context.read<ScreenSize>().height * .12,
          color: appMainGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipPath(
                clipper: TrapZoidClipper(),
                child: Container(
                    width: context.read<ScreenSize>().width * .23,
                    height: context.read<ScreenSize>().height * .12,
                    color: widget.trapZoidColor),
              ),
              Container(
                margin: EdgeInsets.only(
                    right: context.read<ScreenSize>().width * .18),
                child: Text(widget.text,
                    style: TextStyle(
                        fontFamily: "Mont",
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: context.read<ScreenSize>().width * .055)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
