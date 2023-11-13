

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/gameColor/gameskin.dart';

class MinMax extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MinMaxState();
  }


}

class MinMaxState extends State<MinMax> {

  List<String> board = ['','','','','','','','',''];

  var humanPlayer = "0";
  var aiPlayer = "X";



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

  bool turnPLayerX = false;
  String result = " ";
  Key _refreshKey = UniqueKey();


  static var customFont = GoogleFonts.coiny(
    textStyle: const TextStyle(
    color: Colors.white,
    letterSpacing: 3,
    fontSize: 28,
  ));



 void resetButton()
  {
    for (int i=0; i<9; i++) {
      board[i] = '';
    }
    setState(() {
      _refreshKey = UniqueKey();
      result = " ";
      turnPLayerX = false;
    });
  }




 void Move(int index) {
    setState(() {
      if (turnPLayerX == false && (board[index] == "" && board[index] != "0" && board[index] != "X" )) {
        if (turnPLayerX == false && (board[index] == '0' || board[index] == 'X')) {
          turnPLayerX = false;
        } else {
           board[index] = "0";

           turnPLayerX = !turnPLayerX;
           checkedWinner();
        }
      } else if (turnPLayerX == true) {
        if (board[index] == "") {
          board[index] = "X";
          turnPLayerX = !turnPLayerX;
          checkedWinner();
        }
      }
    });
  }


  void makeAiMove()
  {
    int bestMove = FindBestMove(board);
    Move(bestMove);
    
  }

  int FindBestMove(List<String> currentBoard){
    int? bestMove;
    int bestScore = -1000;

    for (int i=0; i<9; i++) {
      if (currentBoard[i] == "") {
        currentBoard[i] = aiPlayer;
        int Boardscore = MinMax(board, 0, false);
        board[i] = "";
        if (Boardscore > bestScore) {
          bestScore = Boardscore;
          bestMove = i;
        }
      }
    }
    return bestMove!;
  }





  bool isMoveleft(List<String> board) {
    for (int i=0; i<9; i++) {
      if (board[i] == "") {
        return true;
      } 
    }
    return false;
  }



  int evaluate(List<String> currentBoard) {

    if(currentBoard[0] == currentBoard[1] && currentBoard[0] == currentBoard[2] && currentBoard[0] != "") {       //First Row
      if (currentBoard[0] == aiPlayer) {
        return 10;
      } else if (currentBoard[0] == humanPlayer) {
        return -10;
      }
    }

    if(currentBoard[3] == currentBoard[4] && currentBoard[3] == currentBoard[5] && currentBoard[3] != "") {   //Second Row
      if (currentBoard[3] == aiPlayer) {
        return 10;
      } else if (currentBoard[3] == humanPlayer) {
        return -10;
      }
    }

    if(currentBoard[6] == currentBoard[7] && currentBoard[6] == currentBoard[8] && currentBoard[6] != "") {       //Third Row
      if (currentBoard[6] == aiPlayer) {
        return 10;
      } else if (currentBoard[6] == humanPlayer) {
        return -10;
      }
    }

    if(currentBoard[0] == currentBoard[3] && currentBoard[0] == currentBoard[6] && currentBoard[0] != "") {    //  First Column
      if (currentBoard[0] == aiPlayer) {
        return 10;
      } else if (currentBoard[0] == humanPlayer) {
        return -10;
      }
    }

    if(currentBoard[1] == currentBoard[4] && currentBoard[1] == currentBoard[7] && currentBoard[1] != "") {    //  second Column
      if (currentBoard[1] == aiPlayer) {
        return 10;
      } else if (currentBoard[1] == humanPlayer) {
        return -10;
      }
    }

    if(currentBoard[2] == currentBoard[5] && currentBoard[2] == currentBoard[8] && currentBoard[2] != "") {    //  third Column
      if (currentBoard[2] == aiPlayer) {
        return 10;
      } else if (currentBoard[2] == humanPlayer) {
        return -10;
      }
    }

    if(currentBoard[0] == currentBoard[4] && currentBoard[0] == currentBoard[8] && currentBoard[0] != "") {    //  First Diagonals
      if (currentBoard[0] == aiPlayer) {
        return 10;
      } else if (currentBoard[0] == humanPlayer) {
        return -10;
      }
    }

    if(currentBoard[2] == currentBoard[4] && currentBoard[2] == currentBoard[6] && currentBoard[2] != "") {    //  Second Diagonals
      if (currentBoard[2] == aiPlayer) {
        return 10;
      } else if (currentBoard[2] == humanPlayer) {
        return -10;
      }
    }
    return 0;           //For Draw
    
}


  int MinMax(List<String> currentBoard, int depth, bool Max) {
    int evaluateScore = evaluate(currentBoard);

    if (evaluateScore == 10) {
      return evaluateScore;
    }

    if (evaluateScore == -10) {
      return evaluateScore;
    }

    if (isMoveleft(board) == false) {   
      return 0;
    }

    if (Max) {
      int bestScore = -1000;
      for (int i=0; i<9; i++) {
        if (currentBoard[i] == "") {
          currentBoard[i] = aiPlayer;
          bestScore = max(bestScore, MinMax(currentBoard, depth+1, !Max));
          currentBoard[i] = "";
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i=0; i<9; i++) {
        if (currentBoard[i] == "") {
          currentBoard[i] = humanPlayer;
          bestScore = min(bestScore,  MinMax(currentBoard, depth+1, !Max));
          currentBoard[i] = "";
        }
      }
      return bestScore;
    }

  }

  void checkedWinner()
  {
    for (var winPattern in winPatterns) {
      if (board[winPattern[0]] == board[winPattern[1]] && board[winPattern[1]] == board[winPattern[2]] && board[winPattern[0]] != "") {
        result = "Player"+ " " + board[winPattern[0]] + " " + " wins";
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
                            if(turnPLayerX == false) {
                              Move(index);
                            } else if(turnPLayerX == true) {
                              makeAiMove();
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: SkinColor.secondaryColor,
                                  border: Border.all(
                                      width: 5, color: SkinColor.primaryColor)),
                              child: Center(
                                child: Text(
                                  board[index],
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