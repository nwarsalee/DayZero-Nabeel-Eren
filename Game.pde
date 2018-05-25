/* 
 ICS4U
 2018/05/23 v3
 Game Summative
 Made by Eren Sulutas and Nabeel Warsalee
 */

Player[] player;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> zombies = new ArrayList<Enemy>();
PImage imgHeart1;
PImage imgHeart2;
int players = 0;
int state = 1;
Interface gui;

void reset() {
  // Resets the score
  // Resets the objects
  player[0] = new Player(width/2, height/2);
  // Game begins 
  state = 0; 
  setup();
}

void newState(int state1) {
  state = state1;
}

void setup() {
  size(1600, 1600);
  // Loads the assets
  imgHeart1 = loadImage("heart1.png");
  imgHeart2 = loadImage("heart2.png");
  // Initializes the objects
  player = new Player[2];
  player[0] = new Player(width/2 - 100, height/2);
  player[1] = new Player(width/2, height/2);
  // Adding enemies
  Enemy newZombie = new Enemy(200, 200);
  zombies.add(newZombie);
  // Outline
  gui = new Interface();
}

void draw() {
  if (state == 0) {
    // Game in progress
    gui.gamePlay();
    player[0].show();
    zombieMoves(); // Method to show the moves of the zombies
    bulletMoves(); // Method to show and move the bullets
    if (players == 2) {
      player[1].show();
    }
  } else if (state == 1) {
    // Main menu
    gui.menu();
  } else if (state == 2) {
    // Game over
    gui.gameOver();
  } else if (state == 3) {
    // How to play
    gui.instructions();
  } else if (state == 4) {
    // Leaderboard;
    gui.leaderboard();
  }
}

void gameIsOver() {
  // Checks if the players are out of health points then sets the state to main menu
  if (players == 1) {
    if (player[0].getLives() == 0) {
      state = 1;
    }
  } else {
    if (player[0].getLives() + player[1].getLives() == 0) {
      state = 1;
    }
  }
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
    } else if (keyCode == ' ') {
      Bullet bullet = new Bullet(player[0].getX(), player[0].getBottom(), player[0].getDir());
      bullets.add(bullet); // Addin new bullet
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
      } else if (keyCode == 16) {
        Bullet bullet = new Bullet(player[1].getX(), player[1].getBottom(), player[1].getDir());
        bullets.add(bullet); // Adding new bullet
      }
    }
  } else if (state == 3) { // How to play menu
    gui.instructions();
  } else if (state == 4) { // Leaderboard 
    gui.leaderboard();
  }
}

// Method which keeps track of mouse clicks 
void mousePressed() {
  if (state == 1) { // Menu
    if (singleplayer()) { // Singleplayer option is chosen
      players = 1;
      reset();
    } else if (multiplayer()) { // Multiplayer option is chosen
      players = 2;
      reset();
    } else if (instructions()) { // How to play screen 
      newState(3);
    } else if (leaderboard()) { // Leaderboard screen
      newState(4);
    }
  } else if (state != 0 && state != 1) { // Leaderboard or instructions page 
    if (backToMenu()) { // Returns to main menu
      newState(1);
    } 
    if (leaderboard2()) { // View leaderboard from end-game screen
      newState(4);
    }
  }
}

// Instance method that checks if the user's mouse is on the singleplayer option
boolean singleplayer() {
  if (mouseX >= width/2 - 0.5 * width/3 && mouseX <= 5 * width / 6 - 0.5 * width/3 && mouseY >= width/2.06 - width/30 && mouseY <= 853 * width / 1545 - width/30) {
    return true;
  } else { 
    return false;
  }
}

// Instance method that checks if the user's mouse is on the multipayer option
boolean multiplayer() {
  if (mouseX >= width/2 - 0.5 * width/3 && mouseX <= 5 * width / 6 - 0.5 * width/3 && mouseY >= height/2 + height/8 - 23 - width/30 && mouseY <= 3251 / 3 - width/30) {
    return true;
  } else { 
    return false;
  }
}

// Instance method that checks if the user's mouse is on the instructions option
boolean instructions() {
  if (mouseX >= width/2 - 0.5 * width/3 && mouseX <= 5 * width / 6 - 0.5 * width/3 && mouseY >= height/2 + height/4 - 23 - height/30 && mouseY <= 3851 / 3 - height/30) {
    return true;
  } else { 
    return false;
  }
}

// Instance method that checks if the user's mouse is on the leaderboad option
boolean leaderboard() {
  if (mouseX >= width/2 - 0.5 * width/3 && mouseX <= 5 * width / 6 - 0.5 * width/3 && mouseY >= 7 * height/8 - 23 - height/30 && mouseY <= 4451/3 - height/30) {
    return true;
  } else { 
    return false;
  }
}

// Instance method that checks if the user's mouse is on the leaderboad option when in end game screen
boolean leaderboard2() {
  if (mouseX >= width/2 - 0.5 * width/3 && mouseX <= 5 * width / 6 - 0.5 * width/3 && mouseY >= 7 * height/8 - 123 - height/30 && mouseY <= 4451/3 - height/30  - 123) {
    return true;
  } else { 
    return false;
  }
}

// Instance method that checks if the user's mouse is on the back to menu option
boolean backToMenu() {
  if (mouseX >= width/2 - 0.5 * width/2.2 && mouseX <= 21 * width / 22 - 0.5 * width/2.2 && mouseY >= height - 115 - width/30 && mouseY <= 16  * height / 15 - 115 - width/30) {
    return true;
  } else { 
    return false;
  }
}

// Method to show the bullets
void bulletMoves() {
  // Loop to go through the bullets
  for (int i=0; i<bullets.size(); i++) {
    bullets.get(i).show();
    bullets.get(i).move();
    if (bullets.get(i).inBounds() == false) { // If the bullet is out of bounds, removes bullet from array list (Attempt at optimizing)
      println("Removed bullet at index " + i);
      bullets.remove(i);
      println("Number of bullets: " + bullets.size()); // Println statement can be DELETED later
    }
  }
}

// Method to show the zombies and their moves
void zombieMoves() {
  for (int i=0; i<zombies.size(); i++) {
    zombies.get(i).show();
    zombies.get(i).move(player[0]);
    // Add move function...
    if (zombies.get(i).isDead(bullets)) {
      println("A zombie died!");
      zombies.remove(i);
      // ADD AMOUNT ONTO SCORE
    }
  }
}
