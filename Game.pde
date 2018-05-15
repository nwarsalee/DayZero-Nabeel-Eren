/* 
ICS4U
2018/05/15
Game Summative
Made by Eren Sulutas and Nabeel Warsalee
*/

int state = 0;

void setup() {
  size(1600, 1600);
  // Initializes the objects
  
  // Outline (MOVE to GUI method)
  background(0);
  fill(255, 0, 0);
  rect(0, 0, width, width/160); 
  noStroke();
  rect(width - width/160, 0, width/160, height); 
  noStroke();
  rect(0, height-height/160, width, width/160); 
  noStroke();
  rect(0, 0, height/160, height); 
  noStroke();
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