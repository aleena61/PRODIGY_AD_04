import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: TicTacToeHome(),
    );
  }
}

class TicTacToeHome extends StatefulWidget {
  @override
  _TicTacToeHomeState createState() => _TicTacToeHomeState();
}

class _TicTacToeHomeState extends State<TicTacToeHome> {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  bool _gameOver = false;
  String _winner = '';

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = 'X';
      _gameOver = false;
      _winner = '';
    });
  }

  void _makeMove(int index) {
    if (_board[index] == '' && !_gameOver) {
      setState(() {
        _board[index] = _currentPlayer;
        if (_checkWin()) {
          _gameOver = true;
          _winner = _currentPlayer;
        } else if (!_board.contains('')) {
          _gameOver = true;
        } else {
          _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkWin() {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (List<int> pattern in winPatterns) {
      if (_board[pattern[0]] == _currentPlayer &&
          _board[pattern[1]] == _currentPlayer &&
          _board[pattern[2]] == _currentPlayer) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _makeMove(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      _board[index],
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20.0),
          _gameOver
              ? Text(
                  _winner != ''
                      ? 'Player $_winner Wins!'
                      : 'It\'s a Draw!',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                )
              : Text(
                  'Player $_currentPlayer\'s Turn',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _resetGame,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: Text('Reset'),
          ),
        ],
      ),
    );
  }
}