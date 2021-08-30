import 'package:axie_scholarship/models/screenSize.dart';
import 'package:axie_scholarship/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const BackButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: SvgPicture.asset(
        "assets/vectors/leftArrow.svg",
        color: Colors.white,
        height: context.read<ScreenSize>().width * .05,
        width: context.read<ScreenSize>().width * .05,
      ),
      constraints: BoxConstraints(
          maxHeight: context.read<ScreenSize>().width * .12,
          maxWidth: context.read<ScreenSize>().width * .12,
          minHeight: context.read<ScreenSize>().width * .12,
          minWidth: context.read<ScreenSize>().width * .12),
      fillColor: appMainGrey,
      shape: CircleBorder(),
    );
  }
}
