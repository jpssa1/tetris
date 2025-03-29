import 'package:flutter/material.dart';

enum Direction {
  esquerda,
  direita,
  baixo,
}

//dimensoes da grid
int rowLength = 10;
int colLength = 16;

enum Tetromino {
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
}

const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Colors.blue,
  Tetromino.J: Colors.yellow,
  Tetromino.I: Colors.deepOrangeAccent,
  Tetromino.O: Colors.pinkAccent,
  Tetromino.S: Colors.lightGreenAccent,
  Tetromino.T: Colors.purple,
  Tetromino.Z: Colors.red,
};
