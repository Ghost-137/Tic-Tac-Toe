import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/gameColor/gameskin.dart';

class GameEngine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GameState();
  }
}

class GameState extends State<GameEngine> {

  List<String> displayXO = ['','','','','','','','',''];
  

  String result = " ";

  int scoreO = 0;
  int scoreX = 0;

  Key _refreshKey = UniqueKey();

  bool turnO = true;

  int filledBox = 1;


  void resetButton()
  {
    for (int i=0; i<9; i++) {
      displayXO[i] = '';
    }
    setState(() {
      _refreshKey = UniqueKey();
      result = " ";
    });
  }



  static var customFont = GoogleFonts.coiny(
    textStyle: const TextStyle(
    color: Colors.white,
    letterSpacing: 3,
    fontSize: 28,
  ));

  


  void tapped(int index) {
    setState(() {
      if (turnO == true && (displayXO[index] == "" && displayXO[index] != '0' && displayXO[index] != "X")) {
        if (turnO == true && (displayXO[index] == '0' || displayXO[index] == 'X')) {
          turnO = true;
        } else {
           displayXO[index] = "0";

           turnO = !turnO;
           filledBox++;
           checkedWinner();
        }
       
      } else if (turnO == false && (displayXO[index] == "" && displayXO[index] != '0' && displayXO[index] != "X")) {
        if (turnO == false && (displayXO[index] == '0' || displayXO[index] == 'X')) {
          turnO = false;
        } else {
          displayXO[index] = "X";
          turnO = !turnO;
          filledBox++;
          checkedWinner();
        }
      }
      
    });
  }

  void checkedWinner()
  {
    if(displayXO[0] == displayXO[1] && displayXO[0] == displayXO[2] && displayXO[0] != "") {
      setState(() {
        result = "player" +" "+ displayXO[0]+" " + "wins";
      });
    }
    if(displayXO[3] == displayXO[4] && displayXO[3] == displayXO[5] && displayXO[3] != "") {
      setState(() {
        result = "player" +" "+ displayXO[3]+" " + "wins";
      });
    }
    if(displayXO[6] == displayXO[7] && displayXO[6] == displayXO[8] && displayXO[6] != "") {
      setState(() {
        result = "player" +" "+ displayXO[6]+" " + "wins";
      });
    }

    if(displayXO[0] == displayXO[4] && displayXO[0] == displayXO[8] && displayXO[0] != "") {
      setState(() {
        result = "PLayer " + " " + displayXO[0] + " "+ "Wins";
      });
    }
    if (displayXO[2] == displayXO[4] && displayXO[2] == displayXO[6] &&  displayXO[2] != "") {
      setState(() {
        result = "PLayer "+ " "+ displayXO[2] + " " + "Wins";
      });
    }
    if (displayXO[0] == displayXO[3] && displayXO[0] == displayXO[6] && displayXO[0] != "" ) {
      setState(() {
        result = "Player" + " " + displayXO[0] + " " + "wins";
      });
    }
    if (displayXO[1] == displayXO[4] && displayXO[1] == displayXO[7] && displayXO[1] != "" ) {
      setState(() {
        result = "Player" + " " + displayXO[1] + " " + "wins";
      });
    }
    if (displayXO[2] == displayXO[5] && displayXO[2] == displayXO[8] && displayXO[2] != "" ) {
      setState(() {
        result = "Player" + " " + displayXO[2] + " " + "wins";
      });
    } else if(filledBox == 9) {
      setState(() {
        result = "Tie";
      });
    }

  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: SkinColor.primaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    "Player",
                    style: customFont,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: GridView.builder(
                    key: _refreshKey,
                      itemCount: 9,
                    
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            tapped(index);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: SkinColor.secondaryColor,
                                  border: Border.all(
                                      width: 5, color: SkinColor.primaryColor)),
                              child: Center(
                                child: Text(
                                  displayXO[index],
                                  style: GoogleFonts.coiny(
                                    textStyle: TextStyle(
                                      fontSize: 64,
                                      color: SkinColor.primaryColor,
                                    )
                                  )
                                ),
                              )),
                        );
                      }),
                ),
                 Expanded(
                  child: Text(result, style: customFont,),
                ),

                ElevatedButton(
                  
                  onPressed: () {
                    resetButton();
                  },
                  child:  Text(
                    "Reset",
                    style: GoogleFonts.coiny(
                      color: Colors.black
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  
}

