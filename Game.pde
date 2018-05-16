/* 
ICS4U
2018/05/16 v0.2
Game Summative
Made by Eren Sulutas and Nabeel Warsalee
*/

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
  state = 0;
}
