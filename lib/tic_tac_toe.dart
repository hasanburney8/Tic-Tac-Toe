import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  //Border state to keep track of moves
  final List<String> board = List.filled(9, "");
  //for current player
  String currentPlayer = "X";
  //Variable to store winner
  String winner = "";
  //Flag to indicate a tie
  bool isTie = false;

  //function to handle a player's move
  player(int index){
    if(winner == "X" || winner == "O" || board[index] != ""){
      return; //if game is already won or the cell is empty do nothing
    }
    setState(() {

      board[index] = currentPlayer; //set the current cell to the current players symbol

      if (currentPlayer == "X") {
        currentPlayer = "O";
      } else {
        currentPlayer = "X";
      } //switch from one to another player

      checkForWinner();



    });
  }
  //funtion to check for winner or tie
  checkForWinner(){
    //check for each winning combination
    List<List<int>> lines = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6],
    ];

    // check each winning combination
    for (List<int> line in lines){
      String player1 = board[line[0]];
      String player2 = board[line[1]];
      String player3 = board[line[2]];
      if(player1 == "" || player2 == "" || player3 == ""){
        continue; //if any cell in the combination is empty skip this combination
      }
      if(player1 == player2 && player2 == player3){
        setState(() {
          winner = player1; //if all the cells in the combination are the same, set the winner
        });
        return;
      }
    }

    // Check for a tie
    if(!board.contains("")){
      setState(() {
        isTie = true; //if no cells are empty and there is no winner then its a tie
      });
    }

  }


  //function to reset the game state and play the new game
  resetGame(){

    setState(() {

      board.fillRange(0, 9, '');
      currentPlayer = 'X';
      winner = '';
      isTie = false ;

    });
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Display the players
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: currentPlayer == "X" ? Colors.amber : Colors.transparent
                  ),
                  boxShadow: [
                      BoxShadow(color: Colors.black38, blurRadius: 3)
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: currentPlayer == "X" ? Colors.amber : Colors.white,
                        size: 55,
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Player 1",
                        style: TextStyle(
                          fontSize: 30,
                          color: currentPlayer == "X" ? Colors.amber : Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "X",
                        style: TextStyle(
                            fontSize: 30,
                            color: currentPlayer == "X" ? Colors.amber : Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: size.width*0.08,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: currentPlayer == "O" ? Colors.amber : Colors.transparent
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black38, blurRadius: 3)
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        color: currentPlayer == "O" ? Colors.amber : Colors.white ,
                        size: 55,
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Player 2",
                        style: TextStyle(
                            fontSize: 30,
                            color: currentPlayer == "O" ? Colors.amber : Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "O",
                        style: TextStyle(
                            fontSize: 30,
                            color: currentPlayer == "O" ? Colors.amber : Colors.white ,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height*0.04,),
          // Display the winner message
          if( winner == "X" || winner == "O" )Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                winner,
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                " WON!",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Display tie message
          if(isTie) Text(
            "It's a tie",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.red
            ),
          ),


          //for game board
          Padding(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: 9,

              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10
              ),
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    player(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          //Reset button
          if( winner == "X" || winner == "O" || isTie )
            ElevatedButton(
              onPressed: resetGame,
              child: const Text("Play Again"),
            ),
        ],
      ),
    );
  }
}
