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
  List<List<int>> winPatterns = [
  [0, 1, 2], // Top row
  [3, 4, 5], // Middle row
  [6, 7, 8], // Bottom row
  [0, 3, 6], // Left column
  [1, 4, 7], // Middle column
  [2, 5, 8], // Right column
  [0, 4, 8], // Diagonal from top-left to bottom-right
  [2, 4, 6], // Diagonal from top-right to bottom-left
];

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
           checkWinner();
        }
       
      } else if (turnO == false && (displayXO[index] == "" && displayXO[index] != '0' && displayXO[index] != "X")) {
        if (turnO == false && (displayXO[index] == '0' || displayXO[index] == 'X')) {
          turnO = false;
        } else {
          displayXO[index] = "X";
          turnO = !turnO;
          filledBox++;
          checkWinner();
        }
      }
      
    });
  }

   void checkWinner()
  {
    for (var winPattern in winPatterns) {
      if (displayXO[winPattern[0]] == displayXO[winPattern[1]] && displayXO[winPattern[1]] == displayXO[winPattern[2]] && displayXO[winPattern[0]] != "") {
        result = "Player "+ " " + displayXO[winPattern[0]] + " " + " wins";
      }
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

