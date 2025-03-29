import 'package:flutter/material.dart';
import 'package:tetris/game_board.dart';
import 'package:tetris/values.dart';

class Piece {
  //tipo de pecas de tetris
  final Tetromino type;

  Piece({required this.type});
  // a peca e apenas uma lista de integers
  List<int> posisao = [];

  Color get cor {
    return tetrominoColors[type] ?? Colors.white;
  }

  //gerar os integers
  void iniciarPeca() {
    switch (type) {
      case Tetromino.L:
        posisao = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        posisao = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        posisao = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        posisao = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        posisao = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetromino.Z:
        posisao = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        posisao = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
    }
  }

  void moverPeca(Direction direction) {
    switch (direction) {
      case Direction.baixo:
        for (int i = 0; i < posisao.length; i++) {
          posisao[i] += rowLength;
        }
        break;
      case Direction.esquerda:
        for (int i = 0; i < posisao.length; i++) {
          posisao[i] -= 1;
        }
        break;

      case Direction.direita:
        for (int i = 0; i < posisao.length; i++) {
          posisao[i] += 1;
        }
        break;
    }
  }

  //rotacionar peca
  int rotationState = 1;
  void rotacionarPeca() {
    //nova posicao
    List<int> novaPosicao = [];

    //rotacionar a peca baseado no seu tipo

    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            //pegar a nova posicao
            novaPosicao = [
              posisao[1] - rowLength,
              posisao[1],
              posisao[1] + rowLength,
              posisao[1] + rowLength + 1,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:
            //pegar a nova posicao
            novaPosicao = [
              posisao[1] - 1,
              posisao[1],
              posisao[1] + 1,
              posisao[1] + rowLength - 1,
            ];
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 2:
            //pegar a nova posicao
            novaPosicao = [
              posisao[1] + rowLength,
              posisao[1],
              posisao[1] - rowLength,
              posisao[1] - rowLength - 1,
            ];
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 3:
            //pegar a nova posicao
            novaPosicao = [
              posisao[1] - rowLength + 1,
              posisao[1],
              posisao[1] + 1,
              posisao[1] - 1,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
        }
        break;
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            //pegar a nova posicao
            novaPosicao = [
              posisao[1] - rowLength,
              posisao[1],
              posisao[1] + rowLength,
              posisao[1] + rowLength - 1,
            ];
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:
            //pegar a nova posicao
            novaPosicao = [
              posisao[1] - rowLength - 1,
              posisao[1],
              posisao[1] - 1,
              posisao[1] + 1,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 2:
            //pegar a nova posicao
            novaPosicao = [
              posisao[1] + rowLength,
              posisao[1],
              posisao[1] - rowLength,
              posisao[1] - rowLength + 1,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 3:
            //pegar a nova posicao
            novaPosicao = [
              posisao[1] + 1,
              posisao[1],
              posisao[1] - 1,
              posisao[1] + rowLength + 1,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
        }
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            //pegar a nova posicao
            novaPosicao = [
              posisao[1] - 1,
              posisao[1],
              posisao[1] + 1,
              posisao[1] + 2,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:
            //pegar a nova posicao
            novaPosicao = [
              posisao[1] - rowLength,
              posisao[1],
              posisao[1] + rowLength,
              posisao[1] + 2 * rowLength,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 2:
            //pegar a nova posicao
            novaPosicao = [
              posisao[1] + 1,
              posisao[1],
              posisao[1] - 1,
              posisao[1] - 2,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 3:
            //pegar a nova posicao
            novaPosicao = [
              posisao[1] + rowLength,
              posisao[1],
              posisao[1] - rowLength,
              posisao[1] - 2 * rowLength,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
        }
      case Tetromino.O:
        break;
      case Tetromino.S:
        switch (rotationState) {
          case 0:
            //pegar a nova posicao
            novaPosicao = [
              posisao[1],
              posisao[1] + 1,
              posisao[1] + rowLength - 1,
              posisao[1] + rowLength,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:
            //pegar a nova posicao
            novaPosicao = [
              posisao[0] - rowLength,
              posisao[0],
              posisao[0] + 1,
              posisao[0] + rowLength + 1,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 2:
            //pegar a nova posicao
            novaPosicao = [
              posisao[1],
              posisao[1] + 1,
              posisao[1] + rowLength - 1,
              posisao[1] + rowLength,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 3:
            //pegar a nova posicao
            novaPosicao = [
              posisao[0] - rowLength,
              posisao[0],
              posisao[0] + 1,
              posisao[0] + rowLength + 1,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
        }
      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            //pegar a nova posicao
            novaPosicao = [
              posisao[0] + rowLength - 2,
              posisao[1],
              posisao[2] + rowLength - 1,
              posisao[3] + 1,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:
            //pegar a nova posicao
            novaPosicao = [
              posisao[0] - rowLength + 2,
              posisao[1],
              posisao[2] - rowLength + 1,
              posisao[3] - 1,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 2:
            //pegar a nova posicao
            novaPosicao = [
              posisao[0] + rowLength - 2,
              posisao[1],
              posisao[2] + rowLength - 1,
              posisao[3] + 1,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 3:
            //pegar a nova posicao
            novaPosicao = [
              posisao[0] - rowLength + 2,
              posisao[1],
              posisao[2] - rowLength + 1,
              posisao[3] - 1,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
        }
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            //pegar a nova posicao
            novaPosicao = [
              posisao[2] - rowLength,
              posisao[2],
              posisao[2] + 1,
              posisao[2] + rowLength,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:
            //pegar a nova posicao
            novaPosicao = [
              posisao[1] - 1,
              posisao[1],
              posisao[1] + 1,
              posisao[1] + rowLength,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 2:
            //pegar a nova posicao
            novaPosicao = [
              posisao[1] - rowLength,
              posisao[1] - 1,
              posisao[1],
              posisao[1] + rowLength,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 3:
            //pegar a nova posicao
            novaPosicao = [
              posisao[2] - rowLength,
              posisao[2] - 1,
              posisao[2],
              posisao[2] + 1,
            ];
            //atualiza a posicao
            if (piecePositionValid(novaPosicao)) {
              posisao = novaPosicao;
              //atualizar rotation State
              rotationState = (rotationState + 1) % 4;
            }

            break;
        }
    }
  }

  bool posicaoValida(int position) {
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  bool piecePositionValid(List<int> posicaoDaPeca) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;
    for (int pos in posicaoDaPeca) {
      if (!posicaoValida(pos)) {
        return false;
      }
      int col = pos % rowLength;

      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }
    return !(firstColOccupied && lastColOccupied);
  }
}
