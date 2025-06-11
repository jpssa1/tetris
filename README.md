# 🧱 Tetris em Flutter

Projeto de Tetris desenvolvido com Flutter, recriando o clássico jogo de blocos com interface moderna e lógica de colisão precisa. Ideal para estudos de animações, controle de tempo, lógica de jogo e renderização customizada na tela.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![Game](https://img.shields.io/badge/Game-Tetris-orange?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)

---

## 🎮 Funcionalidades

- 🔄 Movimentação lateral e rotação de peças
- ⬇️ Queda automática com aumento progressivo da velocidade
- 🧱 Detecção de colisões com paredes e peças
- ❌ Remoção de linhas completas
- 💯 Contador de pontos
- ⏸️ Pausar e reiniciar jogo

---

## 📸 Screenshots


### 🟪 Jogo em execução
<img src="tetris app.png" width="300" />

---

## 🚀 Tecnologias utilizadas

- **Flutter** + **Dart**
- `CustomPaint` e `Canvas` para desenhar peças
- `Timer`/`Ticker` para controlar o tempo do jogo
- Lógica de colisão e preenchimento em matriz
- Responsividade para diferentes tamanhos de tela

---

## 📦 Como rodar

```bash
git clone https://github.com/jpssa1/tetris.git
cd tetris
flutter pub get
flutter run
