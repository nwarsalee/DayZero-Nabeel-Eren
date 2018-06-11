/* 
 ICS4U
 2018/06/11 v3
 Game Summative
 Made by Eren Sulutas and Nabeel Warsalee
 */

import processing.sound.*; // Importing sound libraries for sound output
SoundFile menu, game, zombie, shoot, hit, scream; // Different sound files

Player[] player;
ArrayList<Crate> defenses = new ArrayList<Crate>();
ArrayList<Loot> loot = new ArrayList<Loot>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> zombies = new ArrayList<Enemy>();
Leaderboard leaderboard;
PImage imgHeart1, imgHeart2, imgMap, imgZombieUp, imgZombieDown, imgZombieLeft, imgZombieRight, imgBackground, imgCrate, imgHealth, imgVol1, imgVol2, imgBullet1, imgBullet2, imgBullet3, imgLogo, imgNELogo;
PImage[][] playerImg = new PImage[2][4]; // 2D array for the player imgs
PrintWriter pw;
BufferedReader br;
int players = 0;
int state = 1;
int startTime;
int lastSize = 1;
int waves = 1;
int score = 0;
int shots = 0;
int currentTime = 0;
int minutes = 0;
int seconds = 0;
int deaths = 0;
int menuMultiplier = 800;
int zombiesLeft = 0, zombiesSpawned = 0;
int colourIncrement = 0;
String input = "";
boolean loadAssets = false;
boolean increase = true;
boolean runLoadingScreen = true;
boolean fadeMenu = true;
boolean inputComplete = false;
boolean callLeaderboard = true;
boolean mute = false;
boolean soundPlayed;
PFont font;
Interface gui;

void reset() {
  // Clears all the game assets from previous rounds
  loot.clear(); // Clearing all the loot
  zombies.clear(); // Clears the zombie array
  bullets.clear(); // Cleans the bullets array
  defenses.clear();
  // Resets the score
  score = 0;
  // Resets the objects
  //Enemy newZombie = new Enemy((int)random(4, 28) * 50, (int)random(4, 28) * 50);
  //zombies.add(newZombie);
  //setZombies();
  setDefenses();
  player[0] = new Player(width/2, height/2);
  lastSize = 1; // Resets the zombie multiplier
  state = 0; // Game begins
  waves = 1; // Resets the wave counter
  zombiesSpawned = 0; // Resets the number of zombies spawned
  zombiesLeft = spawning(waves);
  startTime = millis(); // Resets clock
  shots = 0; // Resets the bullet count
  input = "";
  // Resets time
  currentTime = 0;
  minutes = 0;
  seconds = 0;
  callLeaderboard = true; // Sets the leaderboard caller 
  inputComplete = false;
  soundPlayed = false;
  menu.stop();
  setup();
}

void newState(int state1) {
  state = state1;
}

void setup() {
  size(1600, 1600);
  leaderboard = new Leaderboard();
  // Loads the assets
  if (!loadAssets) {
    setImages();
    setAudio();
    loadAssets = true;
  }
  // Initializes the objects
  player = new Player[2];
  player[0] = new Player(width/2 - 100, height/2);
  player[1] = new Player(width/2, height/2);
  // Outline
  gui = new Interface();
  font = createFont("Arial", 32, true);
}

void draw() {
  if (state == 0) {
    // Game in progress
    // Checks if the player(s) is/are dead
    if (gameIsOver()) {
      game.stop(); // Stops the in-game music
      if (!mute) {
        scream.play();
      }
      newState(2);
    }
    gui.gamePlay();
    spawnZombies();
    lootMoves();
    bulletMoves(); // Method to show the bullets' moves
    playerMoves();
    defenseMoves();
    zombieMoves(); // Method to show the moves of the zombies
    // Checks if the wave is over
    if (nextWave()) {
      setWave();
      // Sets the loot for the next wave
      setLoot();
    }
  } else if (state == 1) {
    // Main menu
    gui.menu();
    
    // Runs for the first time
    if (runLoadingScreen) {
      gui.loadingScreen();
    }
    
    if (!mute) {
      if (!soundPlayed) { // If the sound hasn't played yet, plays the music
        menu.play();
        soundPlayed = true;
      }
    }
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
    if (!callLeaderboard) {
      newState(2);
    }
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
  if (zombiesLeft == 0) {
    return true;
  } else {
    return false;
  }
}

// Sets up a new wave
void setWave() {
  // Awards player for surviving the round
  score += 100; // Adds 100 points to the score for surviving a wave
  waves ++;
  zombiesSpawned = 0; // Resets the number of zombies spawned
  zombiesLeft = spawning(waves);
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

// Method to spawn the zombies throughout the round.
void spawnZombies() {
  int waveZombies = spawning(waves);
  for (int i=0; i < 65; i++) {
    if (waveZombies > zombiesSpawned && (int)random(1, 50) == 1 && currentTime % 100 == 0) { // 2% chance of spawning a zombie on a frame
      setZombies();
      println("Spawning a zombie.");
      zombiesSpawned++;
    }
  }
}

// Sets up a new wave
void setLoot() {
  int random, x, y;
  for (int i=0; i < 2; i++) { // Loops twice to see if either of the two lootboxes will be added
    random = (int)random(1, 10);
    if (random == 1 && loot.size() < 2) { // 10% chance of a lootbox dropping
      do { // Gets a value for the position and makes sure it's not on the house blocks
        x = (int)random(4, 28);
        y = (int)random(4, 28);
      } while (x >= 6 && x <= 15 && y >= 7 && y <= 13);
      Loot health = new Loot(x * 50, y * 50);
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
    if (!player[0].isDead()) {
      if (keyCode == 'W') {
        player[0].move('u');
      } else if (keyCode == 'S') {
        player[0].move('d');
      } else if (keyCode == 'A') {
        player[0].move('l');
      } else if (keyCode == 'D') {
        player[0].move('r');
      } else if (keyCode == 'R') {
        player[0].reload(); // Reload
      } else if (keyCode == ' ' && player[0].canShoot()) {
        Bullet bullet = new Bullet(player[0].getX(), player[0].getBottom(), player[0].getDir());
        bullets.add(bullet); // Addin new bullet
        shots ++; // Adds a bullet shot
        player[0].shoot(); // Has the player shoot and lose a bullet in the magazine
        if (!mute) {
          shoot.play(); // Playing the bullet sound
          shoot.amp(0.5);
        }
      }
    }
    // Player 2
    if (players == 2 && !player[1].isDead()) {
      if (keyCode == 'I') {
        player[1].move('u');
      } else if (keyCode == 'K') {
        player[1].move('d');
      } else if (keyCode == 'J') {
        player[1].move('l');
      } else if (keyCode == 'L') {
        player[1].move('r');
      } else if (keyCode == 'P') {
        player[1].reload();
      } else if (keyCode == 16 && player[1].canShoot()) {
        Bullet bullet = new Bullet(player[1].getX(), player[1].getBottom(), player[1].getDir());
        bullets.add(bullet); // Adding new bullet
        shots ++; // Adds a bullet shot
        player[1].shoot(); // Has the player shoot and lose a bullet in the magazine
        if (!mute) {
          shoot.play(); // Playing the bullet sound
          shoot.amp(0.5);
        }
      }
    }
  } else if (state == 3) { // How to play menu
    gui.instructions();
  } else if (state == 4) { // Leaderboard 
    gui.leaderboard();
  } else if (state == 5) { // New high score
    if (keyCode == BACKSPACE && input.length() > 0) {
      // Checks if the user wants to delete a character
      input = input.substring(0, input.length() - 1);
    } else if ((key >= 'A' && key <= 'Z' || key >= 'a' && key <= 'z') && input.length() < 3) {
      // User entry 
      input = input + Character.toUpperCase(key);
    } else if (input.length() == 3 && keyCode == ENTER) {
      inputComplete = true;
      newState(2); // Returns to endgame screen
    }
  }
}

// Method which keeps track of mouse clicks 
void mousePressed() {
  if (state == 1) { // Menu
    if (singleplayer()) { // Singleplayer option is chosen
      players = 1;
      reset();
      if (!mute) {
        game.play(); // Playing the in-game music
      }
    } else if (multiplayer()) { // Multiplayer option is chosen
      players = 2;
      reset();
      if (!mute) {
        game.play(); // Playing the in-game music
      }
    } else if (instructions()) { // How to play screen 
      newState(3);
    } else if (leaderboard()) { // Leaderboard screen
      newState(4);
    }
  } else if (state != 0 && state != 1 && state != 5) { // Leaderboard or instructions page
    if (backToMenu()) { // Returns to main menu
      newState(1);
    }
    if (leaderboard2()) { // View leaderboard from end-game screen
      newState(4);
    }
  }
  if (muteVolume()) { // Checks if the user muted the volume 
    if (mute) {
      if (state == 0) { // Game in progress
        game.play();
      } else {
        menu.play();
      }
      mute = false;
    } else {
      menu.stop();
      game.stop();
      mute = true;
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

// Instance method that checks if the user's mouse is on the mute/unmute button
boolean muteVolume() { 
  //100, 1500, 100, 100)
  if (mouseX >= 50 && mouseX <= 150 && mouseY >= 1450 && mouseY <= 1550) {
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

void zombieMoves() {
  for (int i=0; i<zombies.size(); i++) {
    zombies.get(i).show();
    if (zombies.get(i).getPlayer() == 1) {
      zombies.get(i).moveStep(player[0]);
    } else {
      zombies.get(i).moveStep(player[1]);
    }
    // If a player dies, changes which player it follows.
    if (player[0].isDead()) {
      if (zombies.get(i).getPlayer() == 1) {
        zombies.get(i).setPlayer(2); // Moving towards player 2 now after P1 dies
      }
    } else if (player[1].isDead()) {
      if (zombies.get(i).getPlayer() == 2) {
        zombies.get(i).setPlayer(1); // Moving towards player 1
      }
    }
    if (zombies.get(i).attacking(player[0])) { // Method to check if the zombie is on top of the player
      player[0].hit(); // Has the player get hit and lose one heart...
      if (!mute) {
        hit.play(); // Playing hit sound effect
      }
      if (player[0].isDead()) {
        player[0].setPos(0, 0); // Sets its position outisde of the player area
      }
    } else if (zombies.get(i).attacking(player[1])) {
      player[1].hit(); // Has the second player get hit
      hit.play(); // Playing hit sound effect
      if (player[1].isDead()) {
        player[1].setPos(0, 0); // Sets its position outisde of the player area
      }
    }
    // Checking if the zombie is hit
    if (zombies.get(i).isHit(bullets)) {
      zombies.get(i).hit(); // Having the zombie take damage
      bullets.remove(zombies.get(i).bulletHit(bullets)); // Removes the bullet that hit the zombie (index given with bulletHit method)
      if (zombies.get(i).isDead()) { // If the zombie is dead, remove the zombie
        zombies.remove(i); // Removing the zombie from the arrayList/game
        zombiesLeft--; // Decreases the zombies left counter...
        score += 10; // Adds 10 points to the score for killing a zombie
      }
    }
  }
  if ((int)random(200) == 1) { // Has a 20% chance of playing a zombie sound
    if (!mute)
      zombie.play();
    zombie.amp(0.5);
  }
}

// Method to run the processes for the loot
void lootMoves() {
  for (int i=0; i<loot.size(); i++) {
    try {
      loot.get(i).show(); // Showing the lootbox
      // Statements to check whether or not the player has picked a loot box up.
      if (loot.get(i).intersect(player[0]) && player[0].getLives() < 5) {
        player[0].lifePoint(); // For now, the loot box gives them a life point
        loot.remove(i);
      }
      if (players == 2) { // Checks if it's in two player mod
        if (loot.get(i).intersect(player[1]) && player[1].getLives() < 5) {
          player[1].lifePoint();
          loot.remove(i);
        }
      }
    } 
    catch (IndexOutOfBoundsException e) {
      println("There is not loot box present...");
    }
  }
}

// Method to show the players and their moves
void playerMoves() {
  // Showing and updating the player's stats
  if (!player[0].isDead()) {
    player[0].show(1);
    player[0].update();
  }
  if (players == 2 && !player[1].isDead()) { // If the gamemode it 2-player, show the second player
    player[1].show(2);
    player[1].update();
  }
}

// Method to set the defense crates
void setDefenses() {
  // Setting up the walls of the cabin on the map (MAP1.png)
  // Setting up the left wall
  Crate crate = new Crate(300, 350);
  defenses.add(crate);
  crate = new Crate(300, 400);
  defenses.add(crate);
  crate = new Crate(300, 450);
  defenses.add(crate);
  crate = new Crate(300, 500);
  defenses.add(crate);
  crate = new Crate(300, 550);
  defenses.add(crate);
  crate = new Crate(300, 600);
  defenses.add(crate);
  crate = new Crate(300, 650);
  defenses.add(crate);
  // Setting up the top wall
  crate = new Crate(350, 350);
  defenses.add(crate);
  crate = new Crate(450, 350);
  defenses.add(crate);
  crate = new Crate(500, 350);
  defenses.add(crate);
  crate = new Crate(550, 350);
  defenses.add(crate);
  crate = new Crate(600, 350);
  defenses.add(crate);
  crate = new Crate(650, 350);
  defenses.add(crate);
  crate = new Crate(700, 350);
  defenses.add(crate);
  crate = new Crate(750, 350);
  defenses.add(crate);
  // Setting up the right wall
  crate = new Crate(750, 400);
  defenses.add(crate);
  crate = new Crate(750, 600);
  defenses.add(crate);
  crate = new Crate(750, 650);
  defenses.add(crate);
  // Setting up the bottom wall
  crate = new Crate(700, 650);
  defenses.add(crate);
  crate = new Crate(650, 650);
  defenses.add(crate);
  crate = new Crate(600, 650);
  defenses.add(crate);
  crate = new Crate(450, 650);
  defenses.add(crate);
  crate = new Crate(400, 650);
  defenses.add(crate);
  println("Number of blocks to make up house: " + defenses.size());
  for (int i=0; i<6; i++) {
    int x, y;
    x = (int)random(5, 27);
    y = (int)random(5, 27);
    // If the values chosen don't interfere with the crates of the house, spawn them
    if (!(x >= 6 && x <= 15 && y >= 7 && y <= 13)) {
      println("x: " + x + " y: " + y);
      crate = new Crate(x * 50, y * 50);
      defenses.add(crate);
    }
  }
}

// Method to show the defense crates and their moves
void defenseMoves() {
  for (int i=23; i < defenses.size(); i++) { // Only shows the crates that are not apart of the house structure
    defenses.get(i).show();
  }
}

// Method to set the zombies
void setZombies() {
  float x, y; // Floats for the x and y position the zombie spawns at
  int player; // Int for which player the zombie follows (random)
  char dir; // Character to set the direction of the zombie
  if (random(100) > 50) { // 50 % chance of spawning on the top or bottom
    x = random(4, 28);
    if (x < 16) { // Spawn on left
      x = 4;
      dir = 'r';
    } else { // Spawn on right
      x = 27;
      dir = 'l';
    }
    y = (int)random(4, 28);
  } else { // 50 % chance of spawning on the sides
    y = random(4, 28);
    if (y < 16) { // Spawn on top
      y = 4;
      dir = 'd';
    } else { // Spawn on bottom
      y = 27;
      dir = 'u';
    }
    x = (int)random(4, 28);
  }
  if (players == 2) {
    player = (int)random(1, 3);
    println("Player set to " + player);
  } else {
    player = 1;
  }
  Enemy newZombie = new Enemy(dir, (int)x * 50, (int)y * 50, player);
  zombies.add(newZombie);
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
  // Logo imgs
  imgLogo = loadImage("DAY-ZERO.png");
  // Zombie imgs
  imgZombieUp = loadImage("Zombie-up.png");
  imgZombieDown = loadImage("Zombie-down.png");
  imgZombieLeft = loadImage("Zombie-left.png");
  imgZombieRight = loadImage("Zombie-right.png");
  // Background imgs
  imgBackground = loadImage("background.png");
  // P1 imgs
  playerImg[0][0] = loadImage("Player-right.png");
  playerImg[0][1] = loadImage("Player-left.png");
  playerImg[0][2] = loadImage("Player-up.png");
  playerImg[0][3] = loadImage("Player-down.png");
  // P2 imgs
  playerImg[1][0] = loadImage("Player2-right.png");
  playerImg[1][1] = loadImage("Player2-left.png");
  playerImg[1][2] = loadImage("Player2-up.png");
  playerImg[1][3] = loadImage("Player2-down.png");
  // Menu images
  imgNELogo = loadImage("devlogo.png");
  imgVol1 = loadImage("volumeWhite1.png");
  imgVol2 = loadImage("volumeWhite2.png");
  // Bullet images
  imgBullet1 = loadImage("bullet1.png");
  imgBullet2 = loadImage("bullet2.png");
  imgBullet3 = loadImage("bullet3.png");
}

// Method to set up the audio files
void setAudio() {
  menu = new SoundFile(this, "menu-music.mp3");
  game = new SoundFile(this, "in-game-music.mp3");
  zombie = new SoundFile(this, "zombie-moan.wav");
  shoot = new SoundFile(this, "gun-fire.wav");
  hit = new SoundFile(this, "hit-sound.wav");
  scream = new SoundFile(this, "scream-sound.wav");
}
