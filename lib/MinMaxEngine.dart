

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

  bool turnPLayerX = true;
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
          board[index] = turnPLayerX ? 'X' : '0';
          turnPLayerX = !turnPLayerX;
          checkedWinner();
        }
      }
    });
  }


  void makeAiMove()
  {
    int bestMove = FindBestMove();
    Move(bestMove);
    
  }

  int FindBestMove(){
    int? bestMove;
    int bestScore = -1000;

    for (int i=0; i<9; i++) {
      if (board[i] == "") {
        board[i] = "X";
        int score = MinMax(board, 0, false);
        board[i] = "";
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }
    return bestMove!;
  }

  int evaluate(List<String> currentBoard) {
  

  for (var pattern in winPatterns) {
    if (currentBoard[pattern[0]] == 'X' &&
        currentBoard[pattern[1]] == 'X' &&
        currentBoard[pattern[2]] == 'X') {
      return 1; // Player X wins
    } else if (currentBoard[pattern[0]] == 'O' &&
        currentBoard[pattern[1]] == 'O' &&
        currentBoard[pattern[2]] == 'O') {
      return -1; // Player O wins
    }
  }

  return 0; // It's a draw
}


  int MinMax(List<String> currentBoard, int depth, bool Max) {
    int results = evaluate(currentBoard);
    if (results == 1|| results == -1) {
      return results;
    }
    if (results == 0) {
      return 0;
    }

    if (Max) {
      int bestScore = -1000;
      for (int i=0; i<9; i++) {
        if (currentBoard[i] == "") {
          currentBoard[i] = "X";
          int score  = MinMax(currentBoard, depth+1, false);
          currentBoard[i] = "";
          bestScore = max(bestScore, score);


        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i=0; i<9; i++) {
        if (currentBoard[i] == "") {
          currentBoard[i] = "X";
          int score = MinMax(currentBoard, depth+1, true);
          currentBoard[i] = "";
          bestScore = max(bestScore, score);
        }
      }
      return bestScore;
    }

  }
  

  void checkedWinner()
  {
    for (var winPattern in winPatterns) {
      if (board[winPattern[0]] == board[winPattern[1]] && board[winPattern[1]] == board[winPattern[2]] && board[winPattern[0]] != "") {
        result = "Player "+ "fuck " + board[winPattern[0]] + " " + " wins";
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
                            Move(index);
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