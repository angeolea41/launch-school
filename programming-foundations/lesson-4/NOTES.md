Tic Tac Toe is a 2 player game played on a 3x3 board. Each player takes a turn and marks a square on the board.
First player to reach 3 squares in a row, including diagonals, wins. If all 9 squares are marked and no player has 3 squares in a row, then the game is a tie.

1. Display the initial empty 3x3 board.
2. Ask the user to mark a square.
3. Computer marks a square.
4. Display the updated board state.
5. If winner, display winner.
6. if board is full, display tie.
7. If neither winner nor board is full, go to #2
8. Play again?
9. If yes, go to #1
10. Good bye!

How to determine if there's an immediate threat.

1. Take in current board as parameter
2. Check if the opposing player has to markers in a row
3. Check to see if the third square is an available move
4. If it's an available move place marker in that square
5. If not select random square
