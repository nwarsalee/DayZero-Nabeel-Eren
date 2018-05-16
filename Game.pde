/* 
ICS4U
2018/05/16 0.1
Game Summative
Made by Eren Sulutas and Nabeel Warsalee
*/

int state = 0;
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
  state = 0; 
  setup();
}

void draw() {
  if (state == 0) {
    // Main menu
  } else if (state == 1) {
    // Game over
  } else if (state == 2) {
    // Game in progress
  }
  
}

void gameIsOver() {
  // Checks if the players are out of health points
  state = 0;
}
