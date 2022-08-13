import 'package:flutter_puzzle_game/models/screenSize.dart';
import 'package:flutter_puzzle_game/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PuzzleCustomDialog extends StatefulWidget {
  final String textBody, title;
  final List<Widget> actions;
  const PuzzleCustomDialog({
    Key? key,
    required this.textBody,
    required this.title,
    required this.actions,
  }) : super(key: key);

  @override
  _PuzzleCustomDialogState createState() => _PuzzleCustomDialogState();
}

class _PuzzleCustomDialogState extends State<PuzzleCustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(context.read<ScreenSize>().width * .02))),
      insetPadding: EdgeInsets.symmetric(
        horizontal: context.read<ScreenSize>().width * .05,
      ),
      contentPadding: EdgeInsets.all(context.read<ScreenSize>().width * .01),
      backgroundColor: Color(0xff212121),
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "Mont",
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.textBody,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Mont",
                color: Colors.white,
                fontWeight: FontWeight.w200),
          ),
          Container(
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: widget.actions,
            ),
          )
        ],
      ),
    );
  }
}
