import 'package:axie_scholarship/enums/puzzleLevel.dart';
import 'package:axie_scholarship/models/puzzleModel.dart';
import 'package:axie_scholarship/models/screenSize.dart';
import 'package:axie_scholarship/screens/puzzlePage.dart';
import 'package:axie_scholarship/shared/colors.dart';
import 'package:axie_scholarship/widgets/puzzleCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PuzzlesCardsPage extends StatefulWidget {
  final String title;
  const PuzzlesCardsPage({Key? key, required this.title}) : super(key: key);

  @override
  _PuzzlesCardsPageState createState() => _PuzzlesCardsPageState();
}

class _PuzzlesCardsPageState extends State<PuzzlesCardsPage> {
  List<PuzzleModel> puzzleModels = [
    PuzzleModel.fromUrl(
        imageLink: "https://i.ibb.co/5T39vkz/insect.jpg",
        imageName: "insect.jpg",
        numberOfTiles: 9,
        puzzleLevel: PuzzleLevel.Easy,
        title: "Insect"),
    PuzzleModel.fromUrl(
        imageLink:
            "https://i.pinimg.com/originals/2f/8e/0f/2f8e0f6ecfda9606aa69419fec19e753.jpg",
        title: "Lion",
        puzzleLevel: PuzzleLevel.Normal),
    PuzzleModel.fromUrl(
        imageLink:
            "https://www.rxwallpaper.site/wp-content/uploads/cool-wolf-desktop-backgrounds-wallpaper-800x800.jpg",
        title: "Wolf",
        puzzleLevel: PuzzleLevel.Hard,
        puzzleDuration: Duration(seconds: 10))
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: context.read<ScreenSize>().width * .04,
              top: context.read<ScreenSize>().width * .04,
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
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
              ),
            ),
            Positioned(
              right: context.read<ScreenSize>().width * .04,
              top: context.read<ScreenSize>().width * .04,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: appMainGrey,
                  borderRadius: BorderRadius.all(
                      Radius.circular(context.read<ScreenSize>().width * .07)),
                ),
                width: context.read<ScreenSize>().width * .40,
                height: context.read<ScreenSize>().width * .13,
                child: Text(
                  widget.title,
                  style: TextStyle(
                      fontFamily: "Mont",
                      color: Colors.white,
                      fontSize: context.read<ScreenSize>().width * .05,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Positioned(
              top: context.read<ScreenSize>().width * .25,
              child: Container(
                height: context.read<ScreenSize>().height -
                    context.read<ScreenSize>().width * .25,
                width: context.read<ScreenSize>().width,
                alignment: Alignment.center,
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  padding:
                      EdgeInsets.all(context.read<ScreenSize>().width * .05),
                  mainAxisSpacing: context.read<ScreenSize>().width * .02,
                  crossAxisSpacing: context.read<ScreenSize>().width * .02,
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  children: List.generate(
                    15,
                    (index) => PuzzleCard(
                      puzzleModel: puzzleModels[index % puzzleModels.length],
                      onTap: () {
                        ScreenSize screenSize = context.read<ScreenSize>();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MultiProvider(
                                      providers: [
                                        Provider<ScreenSize>(
                                          create: (_) => screenSize,
                                        ),
                                      ],
                                      child: PuzzlePage(
                                          puzzleModel: puzzleModels[
                                              index % puzzleModels.length]),
                                    )));
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
