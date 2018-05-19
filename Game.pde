/* 
 ICS4U
 2018/05/19 v0.3
 Game Summative
 Made by Eren Sulutas and Nabeel Warsalee
 */

Player[] player;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
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

void setup() {
  size(1600, 1600);
  // Initializes the objects
  player = new Player[2];
  player[0] = new Player(width/2, height/2);
  player[1] = new Player(width/2 - 100, height/2);
  // Outline
  gui = new Interface();
}

void draw() {
  if (state == 0) {
    // Game in progress
    gui.gamePlay();
    player[0].show();
    // Loop to go through all bullets
    for (Bullet bullet : bullets) {
      bullet.show();
      bullet.move();
    }
    if (players == 2) {
      player[1].show();
    }
  } else if (state == 1) {
    // Main menu
    gui.menu();
  } else if (state == 2) {
    // Game over
    gui.gameOver();
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
      println("Sent key = " + player[0].getDir());
      Bullet bullet = new Bullet(player[0].getX(), player[0].getBottom(), player[0].getDir());
      bullets.add(bullet); // Addin new bullet
      println("Length of bullet array: " + bullets.size());
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
  }
}


// Method which keeps track of mouse clicks 
void mousePressed() {
  if (state == 1) { // Menu
    if (singleplayer()) {
      players = 1;
      reset();
    } else if (multiplayer()) {
      players = 2;
      reset();
    }
  }
}

// Instance method that checks if the user's mouse is on the singleplayer option
boolean singleplayer() {
  if (mouseX >= width/2 - 0.5 * width/3 && mouseX <= 5 * width / 6 - 0.5 * width/3 && mouseY >= width/2.06 - 0.5 * width/15 && mouseY <= 853 * width / 1545 - 0.5 * width/15) {
    return true;
  } else { 
    return false;
  }
}

// Instance method that checks if the user's mouse is on the multipayer option
boolean multiplayer() {
  if (mouseX >= width/2 - 0.5 * width/3 && mouseX <= 5 * width / 6 - 0.5 * width/3 && mouseY >= width/1.538 - 0.5 * width/15 && mouseY <= 8269 * width / 11535 - 0.5 * width/15) {
    return true;
  } else { 
    return false;
  }
}
