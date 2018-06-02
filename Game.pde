/* 
 ICS4U
 2018/06/02 v3
 Game Summative
 Made by Eren Sulutas and Nabeel Warsalee
 */

Player[] player;
ArrayList<Crate> defenses = new ArrayList<Crate>();
ArrayList<Loot> loot = new ArrayList<Loot>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> zombies = new ArrayList<Enemy>();
Leaderboard leaderboard;
PImage imgHeart1, imgHeart2, imgMap, imgZombieUp, imgZombieDown, imgZombieLeft, imgZombieRight, imgBackground, imgCrate, imgHealth;
PImage imgP1Right, imgP1Left, imgP1Up, imgP1Down, imgP2Right, imgP2Left, imgP2Up, imgP2Down;
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
  score = 0;
  // Resets the objects
  Enemy newZombie = new Enemy((int)random(4, 28) * 50, (int)random(4, 28) * 50);
  zombies.add(newZombie);
  player[0] = new Player(width/2, height/2);
  Crate crate = new Crate(500, 500);
  defenses.add(crate);
  lastSize = 1; // Resets the zombie multiplier
  state = 0; // Game begins
  waves = 1; // Resets the wave counter
  startTime = millis(); // Resets clock
  shots = 0; // Resets the bullet count
  setup();
}

void newState(int state1) {
  state = state1;
}

void setup() {
  size(1600, 1600);
  leaderboard = new Leaderboard();
  // Loads the assets
  setImages();
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
    // Checks if the player(s) is/are dead
    if (gameIsOver()) {
      loot.clear(); // Clearing all the loot
      zombies.clear(); // Clears the zombie array
      bullets.clear(); // Cleans the bullets array
      defenses.clear();
      newState(2);
    }
    gui.gamePlay();
    lootMoves();
    bulletMoves(); // Method to show the bullets' moves
    playerMoves();
    defenseMoves();
    zombieMoves(); // Method to show the moves of the zombies
    // Checks if the wave is over
    if (nextWave()) {
      // Sets the next wave 
      setWave();
      // Sets the loot for the next wave
      setLoot();
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
  } else if (state == 5) {
    // New high score
    gui.highscore();
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
  for (int i = 0; i < spawning(waves); i ++) {
    Enemy newZombie = new Enemy((int)random(4, 28) * 50, (int)random(4, 28) * 50);
    zombies.add(newZombie);
  }
  score += 100; // Adds 100 points to the score for surviving a wave
  waves ++;
}

// Recursive method to set the size of the waves
int spawning(int wave) {
  if (wave < 1) {
    throw new  RuntimeException("Invalid wave number...");
  } else if (wave == 1) {
    return 1;
  } else {
    return ceil(spawning(wave-1) * 1.5);
  }
}

// Sets up a new wave
void setLoot() {
  int random;
  for (int i=0; i < 2; i++) { // Loops twice to see if either of the two lootboxes will be added
    random = (int)random(1, 10);
    if (random == 1 && loot.size() < 2) { // 20% chance of a lootbox dropping
      Loot health = new Loot((int)random(4, 28) * 50, (int)random(4, 28) * 50);
      loot.add(health);
      println("LootBox added!");
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
    } else if (keyCode == ' ' && player[0].canShoot()) {
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
      } else if (keyCode == 16 && player[1].canShoot()) {
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
    try {
      bullets.get(i).show();
      bullets.get(i).move();
      if (bullets.get(i).inBounds() == false ) { // If the bullet is out of bounds, removes bullet from array list (Attempt at optimizing)
        bullets.remove(i);
      }
      // Checking if the bullet hits any crates, removes it if it does
      for (Crate crate : defenses) {
        if (bullets.get(i).intersect(crate)) {
          bullets.remove(i);
        }
      }
    } 
    catch (Exception ArrayOutOfBoundsException) {
      println("Out of bounds...");
    }
  }
}

// Method to show the zombies and their moves
void zombieMoves() {
  for (int i=0; i<zombies.size(); i++) {
    zombies.get(i).show();
    if (!(player[0].isDead())) {
      zombies.get(i).moveStep(player[0]); // Moving towards player 1
    } else {
      zombies.get(i).moveStep(player[1]);
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

// Method to run the processes for the loot
void lootMoves() {
  for (int i=0; i<loot.size(); i++) {
    loot.get(i).show(); // Showing the lootbox
    // Statements to check whether or not the player has picked a loot box up.
    if (loot.get(i).intersect(player[0])) {
      player[0].lifePoint(); // For now, the loot box gives them a life point
      loot.remove(i);
    }
    if (players == 2) { // Checks if it's in two player mod
      if (loot.get(i).intersect(player[1])) {
        player[1].lifePoint();
        loot.remove(i);
      }
    }
  }
}

// Method to show the players and their moves
void playerMoves() {
  // Showing and updating the player's stats
  player[0].show(1);
  player[0].update();
  if (players == 2) { // If the gamemode it 2-player, show the second player
    player[1].show(2);
    player[1].update();
  }
}

// Method to show the defense crates and their moves
void defenseMoves() {
  for (int i=0; i < defenses.size(); i++) {
    defenses.get(i).show();
  }
}

// Method to setup the images
void setImages() {
  // Getting the heart imgs
  imgHeart1 = loadImage("heart1.png");
  imgHeart2 = loadImage("heart2.png");
  // Crate and health crate imgs
  imgCrate = loadImage("Crate-img.png");
  imgHealth = loadImage("Health-img.png");
  // Map imgs
  imgMap = loadImage("MAP1.PNG");
  // Zombie imgs
  imgZombieUp = loadImage("Zombie-up.png");
  imgZombieDown = loadImage("Zombie-down.png");
  imgZombieLeft = loadImage("Zombie-left.png");
  imgZombieRight = loadImage("Zombie-right.png");
  // Background imgs
  imgBackground = loadImage("background.png");
  // P1 imgs
  imgP1Right = loadImage("Player-right.png");
  imgP1Left = loadImage("Player-left.png");
  imgP1Up = loadImage("Player-up.png");
  imgP1Down = loadImage("Player-down.png");
  // P2 imgs
  imgP2Right = loadImage("Player2-right.png");
  imgP2Left = loadImage("Player2-left.png");
  imgP2Up = loadImage("Player2-up.png");
  imgP2Down = loadImage("Player2-down.png");
}

