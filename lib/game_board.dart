import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/values.dart';
/*
  GAME BOARD

  e um 2x2 grid com null representando um espaco vazio



*/

//criar a game board
List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({
    super.key,
  });

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  //peca atual
  Piece pecaAtual = Piece(type: Tetromino.L);

  //score inical
  int scoreAtual = 0;

  //velocidade
  Timer? gameTime;

  //game over status
  bool gameOver = false;
  //inicia o jogo
  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    pecaAtual.iniciarPeca();

    // frameRate
    setState(() {
      gameLoop();
    });
  }

  //game loop
  void gameLoop() {
    gameTime?.cancel();
    Duration? frameRate;

    if (scoreAtual <= 2) {
      frameRate = const Duration(milliseconds: 400);
    } else if (scoreAtual > 2 && scoreAtual < 7) {
      frameRate = const Duration(milliseconds: 300);
    } else if (scoreAtual > 6) {
      frameRate = const Duration(milliseconds: 200);
    }
    gameTime = Timer.periodic(frameRate!, (timer) {
      setState(() {
        limparLinha();
        //checkar ocupacao
        checkarOcupacao();

        if (gameOver == true) {
          timer.cancel();
          showGameOverDialog();
        }
        //mover peca para baixo
        pecaAtual.moverPeca(Direction.baixo);
      });
    });
  }

  void showGameOverDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('FIM DE JOGO'),
              content: Text('SEU SCORE FOI $scoreAtual'),
              actions: [
                TextButton(
                    onPressed: () {
                      resetGame();
                      Navigator.pop(context);
                    },
                    child: Text('jogar novamente'))
              ],
            ));
  }

  void resetGame() {
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(
        rowLength,
        (j) => null,
      ),
    );
    gameOver = false;
    scoreAtual = 0;
    criarNovaPeca();
    startGame();
  }

  //checkar colisao na proxima posicao
  // retornar true -> se colidir
  // retornar false -> se nao colidir
  bool chekarColisao(Direction direction) {
    for (int i = 0; i < pecaAtual.posisao.length; i++) {
      //calculando a coluna e linha da peca atual
      int row = (pecaAtual.posisao[i] / rowLength).floor();
      int col = pecaAtual.posisao[i] % rowLength;

      //ajustando a linha e a coluna com base a direcao
      if (direction == Direction.esquerda) {
        col -= 1;
      } else if (direction == Direction.direita) {
        col += 1;
      } else if (direction == Direction.baixo) {
        row += 1;
      }
      // Verificar colisão com as bordas do tabuleiro
      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      }
      // Verificar colisão com peças já fixadas no tabuleiro
      if (row >= 0 && col >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }
    //retorna false caso nao tenha colisao
    return false;
  }

  void checkarOcupacao() {
    //se a espaco de baixo esta ocupado
    if (chekarColisao(Direction.baixo)) {
      //marcar a posicao como ocupada no game board
      for (int i = 0; i < pecaAtual.posisao.length; i++) {
        int row = (pecaAtual.posisao[i] / rowLength).floor();
        int col = pecaAtual.posisao[i] % rowLength;
        if (row >= 0 && row < colLength && col >= 0 && col < rowLength) {
          gameBoard[row][col] = pecaAtual.type;
        }
      }
      criarNovaPeca();
    }
  }

  void criarNovaPeca() {
    //cria um objeto aleatoria para gerar um tetromino aleatorio
    Random rand = Random();
    //cria uma nova peca com o tipo aleatorio
    Tetromino pecaAleatoria =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    pecaAtual = Piece(type: pecaAleatoria);
    pecaAtual.iniciarPeca();
    if (isGameOver()) {
      gameOver = true;
    }
  }

  //mover para a esquerda
  void moverEsquerda() {
    if (!chekarColisao(Direction.esquerda)) {
      setState(() {
        pecaAtual.moverPeca(Direction.esquerda);
      });
    }
  }

  //mover para a direita
  void moverDireita() {
    if (!chekarColisao(Direction.direita)) {
      setState(() {
        pecaAtual.moverPeca(Direction.direita);
      });
    }
  }

  //rotacionar peca
  void girarPeca() {
    setState(() {
      pecaAtual.rotacionarPeca();
    });
  }

  //limpar linha
  void limparLinha() {
    //loop por cada linha do game board de baixo para cima
    for (int row = colLength - 1; row >= 0; row--) {
      //inicalizando a variavel que mosta se a linha esta full
      bool rowIsFull = true;
      //verifica se a linha esta full
      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] = List.generate(row, (index) => null);

        setState(() {
          scoreAtual++;
          gameLoop();
        });
      }
    }
  }

  //game over
  bool isGameOver() {
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //game grid
          Expanded(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: rowLength * colLength,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rowLength,
              ),
              itemBuilder: (context, index) {
                //pegar a linha e a coluna de cada index
                int row = (index / rowLength).floor();
                int col = index % rowLength;

                //peca atual
                if (pecaAtual.posisao.contains(index)) {
                  return Pixel(
                    cor: pecaAtual.cor,
                  );
                } //peca Posicionadas
                else if (gameBoard[row][col] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(
                    cor: tetrominoColors[tetrominoType],
                  );
                }
                //pixel do fundo
                else {
                  return Pixel(
                    cor: Colors.grey[900],
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Score : ${scoreAtual.toString()}',
              style: TextStyle(color: Colors.white, fontSize: 19),
            ),
          ),
          //game controls
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //mover para a esquerda
                Expanded(
                  child: IconButton(
                    iconSize: 40,
                    onPressed: moverEsquerda,
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                  ),
                ),
                //rotacionar peca
                Expanded(
                  child: IconButton(
                    iconSize: 40,
                    onPressed: girarPeca,
                    icon: Icon(Icons.rotate_right),
                    color: Colors.white,
                  ),
                ),
                //mover para a direita
                Expanded(
                  child: IconButton(
                    iconSize: 40,
                    onPressed: moverDireita,
                    icon: Icon(Icons.arrow_forward_ios),
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
