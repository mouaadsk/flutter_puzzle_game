import 'package:flutter_puzzle_game/models/screenSize.dart';
import 'package:flutter_puzzle_game/screens/puzzleCardsPage.dart';
import 'package:flutter_puzzle_game/shared/colors.dart';
import 'package:flutter_puzzle_game/widgets/puzzleWideButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PuzzlesChoicePage extends StatefulWidget {
  const PuzzlesChoicePage({Key? key}) : super(key: key);

  @override
  _PuzzlesChoicePageState createState() => _PuzzlesChoicePageState();
}

class _PuzzlesChoicePageState extends State<PuzzlesChoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: context.read<ScreenSize>().height * .03),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: PuzzleWideButton(
                        onPressed: () {
                          ScreenSize screenSize = context.read<ScreenSize>();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MultiProvider(
                                        providers: [
                                          Provider<ScreenSize>(
                                              create: (_) => screenSize),
                                        ],
                                        child: PuzzlesCardsPage(
                                          title: "3 x 3 Puzzles",
                                          numberOfTiles: 9,
                                        ),
                                      )));
                        },
                        trapZoidColor: Colors.white,
                        text: "3 x 3 Puzzles",
                      ),
                    ),
                    SizedBox(
                      height: context.read<ScreenSize>().height * .02,
                    ),
                    PuzzleWideButton(
                      onPressed: () {
                        ScreenSize screenSize = context.read<ScreenSize>();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MultiProvider(
                                      providers: [
                                        Provider<ScreenSize>(
                                            create: (_) => screenSize),
                                      ],
                                      child: PuzzlesCardsPage(
                                        title: "4 x 4 Puzzles",
                                        numberOfTiles: 16,
                                      ),
                                    )));
                      },
                      trapZoidColor: Color(0xff536DFE),
                      text: '4 x 4 Puzzles',
                    ),
                    SizedBox(height: context.read<ScreenSize>().height * .02),
                    PuzzleWideButton(
                        onPressed: () {
                          ScreenSize screenSize = context.read<ScreenSize>();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MultiProvider(
                                        providers: [
                                          Provider<ScreenSize>(
                                              create: (_) => screenSize),
                                        ],
                                        child: PuzzlesCardsPage(
                                          title: "5 x 5 Puzzles",
                                          numberOfTiles: 25,
                                        ),
                                      )));
                        },
                        trapZoidColor: Color(0xffFE8F00),
                        text: ' 5 x 5 Puzzles')
                  ]),
            ),
            Positioned(
              bottom: context.read<ScreenSize>().height * .03,
              left: context.read<ScreenSize>().width * .03,
              child: GestureDetector(
                onTap: () {
                  //TODO : adding the exite button but on Tap
                },
                child: Container(
                  alignment: Alignment.center,
                  height: context.read<ScreenSize>().height * .06,
                  width: context.read<ScreenSize>().width * .3,
                  decoration: BoxDecoration(
                    color: appRed,
                    borderRadius: BorderRadius.all(Radius.circular(
                        context.read<ScreenSize>().width * .07)),
                  ),
                  child: Text(
                    "Exit",
                    style: TextStyle(
                        fontFamily: "Mont",
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: context.read<ScreenSize>().width * .05),
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
