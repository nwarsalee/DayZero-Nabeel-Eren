/* 
 ICS4U
 2018/05/26 v5
 Game Summative
 Made by Eren Sulutas and Nabeel Warsalee
 */

Player[] player;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> zombies = new ArrayList<Enemy>();
PImage imgHeart1, imgHeart2;
int players = 0;
int state = 1;
int startTime;
int lastSize = 1;
int waves = 1;
int score = 0;
int shots = 0;
Interface gui;

void reset() {
  // Resets the score
  // Resets the objects
  player[0] = new Player(width/2, height/2);
  // Adding enemies
  Enemy newZombie = new Enemy(200, 200);
  zombies.add(newZombie);
  lastSize = 1; // Resets the zombie multiplier
  state = 0; // Game begins
  waves = 1; // Resets the wave counter
  startTime = millis(); // Resets clock
  score = 0; // Resets the score
  shots = 0; // Resets the bullet count
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
    // Checks if the player(s) is/are dead
    if (gameIsOver()) {
      for (int i=0; i<zombies.size(); i++) { // Traversing the zombie arrayList to remove all the zombies.
        zombies.remove(i);
      }
      newState(2);
    }
    // Checks if the waves is over
    if (nextWave()) {
      // Sets the next wave 
      setWave();
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

boolean gameIsOver() {
  // Checks if the players are out of health points then sets the state to main menu
  if (players == 1) {
    if (player[0].getLives() == 0) {
      return true;
    } else {
      return false;
    }
  } else {
    if (player[0].getLives() == 0 && player[1].getLives() == 0) {
      return true;
    } else {
      return false;
    }
  }
}

// Checks if the wave is over
boolean nextWave() {
  if (zombies.size() == 0) {
    return true;
  } else {
    return false;
  }
}

// Sets up a new wave
void setWave() {
  lastSize = lastSize + ceil(0.5 * lastSize);
  for (int i = 1; i < lastSize; i ++) {
    Enemy newZombie = new Enemy((int)random(4, 28) * 50, (int)random(4, 28) * 50);
    zombies.add(newZombie);
  }
  score += 100; // Adds 100 points to the score for surviving a wave
  waves ++;
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
      shots ++; // Adds a bullet shot 
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
        shots ++; // Adds a bullet shot
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
    println("Number of zombies: " + zombies.size());
    zombies.get(i).show();
    if (!player[0].isDead()) {
      zombies.get(i).move(player[0]); // Moving towards player 1 (Add functionality to move towards second player if P1 isn't alive)
    } else {
      zombies.get(i).move(player[1]);
    }
    if (zombies.get(i).attacking(player[0])) { // Method to check if the zombie is on top of the player
      player[0].hit(); // Has the player get hit and lose one heart...
    } else if (zombies.get(i).attacking(player[1])) {
      player[1].hit(); // Has the second player get hit
    }
    // Checking if the zombie is hit
    if (zombies.get(i).isHit(bullets)) {
      zombies.get(i).hit(); // Having the zombie take damage
      bullets.remove(zombies.get(i).bulletHit(bullets)); // Removes the bullet that hit the zombie (index given with bulletHit method)
      if (zombies.get(i).isDead()) { // If the zombie is dead, remove the zombie
        println("Zombie " + (i+1) + " has died... Lives at " + zombies.get(i).getLives());
        zombies.remove(i); // Removing the zombie from the arrayList/game
        score += 10; // Adds 10 points to the score for killing a zombie
      }
    }
  }
}

// Method to show the players and their moves
void playerMoves() {
  // Loop to go through all the players
  if (!player[0].isDead()) {
    player[0].show();
  } else {
    
  }
}
