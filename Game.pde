/* 
ICS4U
2018/05/17 v0.1
Game Summative
Made by Eren Sulutas and Nabeel Warsalee
*/

int players = 0;
int state = 1;
Interface gui;

void setup() {
  size(1600, 1600);
  // Initializes the objects
  
  // Outline
  gui = new Interface();
}

void reset() {
  // Resets the score
  // Resets the objects
  // Returns to the main menu
  state = 1; 
  // Resets the game mode 
  players = 0;
  setup();
}

void draw() {
  if (state == 0) {
    // Game in progress
    gui.gamePlay();
  } else if (state == 1) {
    // Main menu
    gui.menu();
  } else if (state == 2) {
    // Game over
    gui.gameOver();
  }
  
}

void gameIsOver() {
  // Checks if the players are out of health points
  state = 1;
}

// Keeps track of user key inputs  
void keyPressed() {
  // Checks if the game is in progress
  if (state == 0) { 
    // Player 1 controls 
    if (keyCode == 'W') {
      player[0].move('u');
    } else if (keyCode == 'S') {
      player[0].move('d');
    } else if (keyCode == 'A') {
      player[0].move('l');
    } else if (keyCode == 'D') {
      player[0].move('r');
    } 
    // Player 2
    if (players == 2) {
      if (keyCode == UP) {
        player[1].move('u');
      } else if (keyCode == DOWN) {
        player[1].move('d');
      } else if (keyCode == LEFT) {
        player[1].move('l');
      } else if (keyCode == RIGHT) {
        player[1].move('r');
      }
    }
  }
}
