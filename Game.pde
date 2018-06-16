/* 
 ICS4U
 2018/06/16 v3
 Game Summative
 Made by Eren Sulutas and Nabeel Warsalee
 */

import processing.sound.*; // Importing sound libraries for sound output
SoundFile menu, game, zombie, shoot, hit, scream, reload; // Different sound files

int winSize = 1600; // Integer variable for the size of the window (ADJUST THIS DEPENDING ON SCREEN SIZE)

Player[] player;
ArrayList<Crate> defenses = new ArrayList<Crate>();
ArrayList<Loot> loot = new ArrayList<Loot>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Enemy> zombies = new ArrayList<Enemy>();
Leaderboard leaderboard;
PImage imgHeart1, imgHeart2, imgMap, imgZombieUp, imgZombieDown, imgZombieLeft, imgZombieRight, imgBackground, imgCrate, imgHealth, imgVol1, imgVol2, imgBullet1, imgBullet2, imgBullet3, imgLogo, imgNELogo;
PImage[][] playerImg = new PImage[2][4]; // 2D array for the player imgs
String[] zeroes;
PrintWriter pw;
BufferedReader br;
float gridSize; // Float variable for the size of a block (grid size), the size of a block for a given width is (3*width)/96
int players = 0;
int state = 6;
int startTime;
int lastSize = 1;
int waves = 1;
int score = 0;
int shots = 0;
int currentTime = 0;
int minutes = 0;
int seconds = 0;
int deaths = 0;
int menuMultiplier;
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
  setDefenses();
  lastSize = 1; // Resets the zombie multiplier
  state = 0; // Game begins
  waves = 1; // Resets the wave counter
  zombiesSpawned = 0; // Resets the number of zombies spawned
  zombiesLeft = spawning(waves);
  startTime = millis(); // Resets clock
  zeroes[0] = "";
  zeroes[1] = "";
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
  size(winSize,winSize, P3D);
  leaderboard = new Leaderboard();
  // Loads the assets
  if (!loadAssets) {
    try {
      setImages();
      setAudio();
    } 
    catch (NullPointerException e) {
      println("A required file is not present. Please refer to the GitHub repository and make sure all necessary files are downloaded and with the correct name.");
    }
    loadAssets = true;
  }
  // Initializes the objects
  player = new Player[2];
  player[0] = new Player(width/2, height/2);
  player[1] = new Player(17 * width/32, height/2);
  // Setting the grid size
  gridSize = (3*width)/96;
  // Initializes the timer display
  zeroes = new String[2];
  // Outline
  gui = new Interface();
  menuMultiplier = width/2;
  font = createFont("Arial", width/50, true);
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
      // Checks if the user has a new high score
      if (gui.newHighscore() && callLeaderboard) { 
        newState(5);
      } else {
        // Game over
        newState(2);
      }
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

    if (!mute) {
      if (!soundPlayed) { // If the sound hasn't played yet, plays the music
        menu.loop();
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
    if (callLeaderboard) {
      gui.highscore();
    } else {
      newState(2);
    }
  } else if (state == 6) {
    // Loading screen
    if (runLoadingScreen) {
      gui.loadingScreen();
    } else {
      // Returns to the menu when the animation is over
      noTint();
      newState(1);
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
  zombiesLeft = spawning(waves); // The number of zombies left starts at what the wave number of zombies is
}

// Recursive method to set the size of the waves
int spawning(int wave) {
  // Throws error if the wave number is below 1.
  if (wave < 1) {
    throw new  RuntimeException("Invalid wave number...");
  } else if (wave == 1) { // Terminating sequence that returns 1
    return 1;
  } else { // If the wave is above 1, returns the recursive sequence t(n) = ceil(t(n-1) * 1.5)
    return ceil(spawning(wave-1) * 1.5);
  }
}

// Method to spawn the zombies throughout the round.
void spawnZombies() {
  int waveZombies = spawning(waves); // The zombies for the wave is the return value of the recursive method
  for (int i=0; i < 65; i++) {
    if (waveZombies > zombiesSpawned && (int)random(1, 25) == 1 && currentTime % 10 == 0) { // If the number of zombies spawned has not reached the limit for the round, and the time is divisible by 100ms, spawns
      setZombies();
      zombiesSpawned++;
    }
  }
}

// Sets up the loot in a new wave
void setLoot() {
  int random, x, y; // Integers for the random number, and the x, y position.
  for (int i=0; i < 2; i++) { // Loops twice to see if either of the two lootboxes will be added
    random = (int)random(1, 10);
    if (random == 1 && loot.size() < 2) { // 10% chance of a lootbox dropping
      do { // Gets a value for the position and makes sure it's not on the house blocks
        x = (int)random(4, 28);
        y = (int)random(4, 28);
      } while (x >= 6 && x <= 15 && y >= 7 && y <= 13);
      Loot health = new Loot(x * gridSize, y * gridSize); // Creates new loot object
      loot.add(health); // Adds that loot object to the ArrayList
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
        if (!mute) {
          reload.play();
          reload.amp(5);
        }
      } else if (keyCode == ' ' && player[0].canShoot()) {
        createBullet(0); // Creates the bullet for player 1
        if (player[0].getBullets() == 0) {
         if (!mute) {
          reload.play();
          reload.amp(5);
          }
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
        if (!mute) {
          reload.play();
          reload.amp(5);
        }
      } else if (keyCode == 16 && player[1].canShoot()) {
        createBullet(1); // Creates the bullet for player 2
        if (player[1].getBullets() == 0) {
         if (!muite) {
          reload.play();
          reload.amp(5);
          }
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
    }
  } else if (state == 6) { // Loading screen
    if (keyCode == ' ') {
      // Skips the loading screen
      noTint();
      newState(1);
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
        game.loop(); // Playing the in-game music
      }
    } else if (multiplayer()) { // Multiplayer option is chosen
      players = 2;
      reset();
      if (!mute) {
        game.loop(); // Playing the in-game music
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
        menu.loop();
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
  if (mouseX >= width/3 && mouseX <= 2 * width/3 && mouseY >= 1397 * width/3090 && mouseY <= 1603 * width / 3090) {
    return true;
  } else { 
    return false;
  }
}

// Instance method that checks if the user's mouse is on the multipayer option
boolean multiplayer() {
  if (mouseX >= width/3 && mouseX <= 2 * width/3 && mouseY >= 71 * width/120 && mouseY <= 3091 * width/4800) {
    return true;
  } else { 
    return false;
  }
}

// Instance method that checks if the user's mouse is on the instructions option
boolean instructions() {
  if (mouseX >= width/3 && mouseX <= 2 * width/3 && mouseY >= 3371 * height/4800 && mouseY <= 3691 * height/4800) {
    return true;
  } else { 
    return false;
  }
}

// Instance method that checks if the user's mouse is on the leaderboad option
boolean leaderboard() {
  if (mouseX >= width/3 && mouseX <= 2 * width/3 && mouseY >= 3971 * height/4800 && mouseY <= 4291 * height/4800) {
    return true;
  } else { 
    return false;
  }
}

// Instance method that checks if the user's mouse is on the leaderboad option when in the end game screen
boolean leaderboard2() {
  if (mouseX >= width/3 && mouseX <= 2 * width/3 && mouseY >= 3671 * height/4800 && mouseY <= 1961 * width/2400) {
    return true;
  } else { 
    return false;
  }
}

// Instance method that checks if the user's mouse is on the back to menu option
boolean backToMenu() {
  if (mouseX >= 3 * width/11 && mouseX <= 8 * width/11 && mouseY >= 859 * width/960 && mouseY <= 923 * width/960) {
    return true;
  } else { 
    return false;
  }
}

// Instance method that checks if the user's mouse is on the mute/unmute button
boolean muteVolume() { 
  if (mouseX >= width/32 && mouseX <= 3 * width/32 && mouseY >= 29 * width/32 && mouseY <= 31 * width/32) {
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
      if (bullets.get(i).inBounds() == false) { // If the bullet is out of bounds, removes bullet from array list
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
      // Used to catch errors where the bullet has already been deleted, yet the comparison between the crate and the bullet still tries to occur
    }
  }
}

void zombieMoves() {
  for (int i=0; i<zombies.size(); i++) {
    try {
      zombies.get(i).show(); // Showing the zombie on screen
      if (zombies.get(i).getPlayer() == 1) { // If the zombie is programmed to player 1, follows player 1.
        zombies.get(i).moveStep(player[0]);
      } else { // If it's programmed to player 2, follows player 2.
        zombies.get(i).moveStep(player[1]);
      }
      // If a player dies, changes which player it follows.
      if (player[0].isDead()) {
        if (zombies.get(i).getPlayer() == 1) {
          zombies.get(i).setPlayer(2); // Moving towards player 2 now after P1 dies
        }
      } else if (player[1].isDead()) {
        if (zombies.get(i).getPlayer() == 2) {
          zombies.get(i).setPlayer(1); // Moving towards player 1 now after P2 dies
        }
      }
      if (zombies.get(i).attacking(player[0])) { // Method to check if the zombie is on top of the player
        player[0].hit(); // Has the player get hit and lose one heart...
        if (!mute) {
          hit.play(); // Playing hit sound effect
        }
        if (player[0].isDead()) {
          player[0].setPos(0, 0); // If the player dies, sets their position outside of the player area
        }
      } else if (zombies.get(i).attacking(player[1])) {
        player[1].hit(); // Has the second player get hit
        if (!mute) {
        hit.play(); // Playing hit sound effect
        }
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
    catch (Exception ArrayOutOfBoundsException) {
      // Used to catch any errors surrounding the array index
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
      if (players == 2) { // Checks if it's in two player mode
        if (loot.get(i).intersect(player[1]) && player[1].getLives() < 5) {
          player[1].lifePoint();
          loot.remove(i);
        }
      }
    } 
    catch (IndexOutOfBoundsException e) {
      // Used to catch any error regarding the array being out of bounds
      println("There is no loot box present...");
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
  if (players == 2 && !player[1].isDead()) { // If the gamemode is 2-player, show the second player
    player[1].show(2);
    player[1].update();
  }
}

// Method to create a bullet and play the bullet sound
void createBullet(int index) {
  Bullet bullet = new Bullet(player[index].getX(), player[index].getBottom(), player[index].getDir()); // Creates new bullet at the current location of the player
  bullets.add(bullet); // Adding new bullet
  shots ++; // Adds a bullet shot
  player[index].shoot(); // Has the player shoot and lose a bullet in the magazine
  if (!mute) {
    shoot.play(); // Playing the bullet sound
    shoot.amp(0.5);
  }
}

// Method to set the defense crates
void setDefenses() {
  // Setting up the walls of the cabin on the map (MAP1.png)
  // Setting up the left wall
  Crate crate = new Crate(3 * width/16, 7 * width/32);
  defenses.add(crate);
  crate = new Crate(3 * width/16, width/4);
  defenses.add(crate);
  crate = new Crate(3 * width/16, 9 * width/32);
  defenses.add(crate);
  crate = new Crate(3 * width/16, 5 * width/16);
  defenses.add(crate);
  crate = new Crate(3 * width/16, 11 * width/32);
  defenses.add(crate);
  crate = new Crate(3 * width/16, 3 * width / 8);
  defenses.add(crate);
  crate = new Crate(3 * width/16, 13 * width/32);
  defenses.add(crate);
  // Setting up the top wall
  crate = new Crate(7 * width/32, 7 * width/32);
  defenses.add(crate);
  crate = new Crate(9 * width/32, 7 * width/32);
  defenses.add(crate);
  crate = new Crate(5 * width/16, 7 * width/32);
  defenses.add(crate);
  crate = new Crate(11 * width/32, 7 * width/32);
  defenses.add(crate);
  crate = new Crate(3 * width / 8, 7 * width/32);
  defenses.add(crate);
  crate = new Crate(13 * width/32, 7 * width/32);
  defenses.add(crate);
  crate = new Crate(7 * width/16, 7 * width/32);
  defenses.add(crate);
  crate = new Crate(15 * width/32, 7 * width/32);
  defenses.add(crate);
  // Setting up the right wall
  crate = new Crate(15 * width/32, width/4);
  defenses.add(crate);
  crate = new Crate(15 * width/32, 3 * width / 8);
  defenses.add(crate);
  crate = new Crate(15 * width/32, 13 * width/32);
  defenses.add(crate);
  // Setting up the bottom wall
  crate = new Crate(7 * width/16, 13 * width/32);
  defenses.add(crate);
  crate = new Crate(13 * width/32, 13 * width/32);
  defenses.add(crate);
  crate = new Crate(3 * width / 8, 13 * width/32);
  defenses.add(crate);
  crate = new Crate(9 * width/32, 13 * width/32);
  defenses.add(crate);
  crate = new Crate(width/4, 13 * width/32);
  defenses.add(crate);
  for (int i=0; i<6; i++) {
    int x, y;
    x = (int)random(5, 27);
    y = (int)random(5, 27);
    // If the values chosen don't interfere with the crates of the house, spawn them
    if (!(x >= 6 && x <= 15 && y >= 7 && y <= 13)) {
      crate = new Crate(x * gridSize, y * gridSize);
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
    y = (int)random(4, 28); // Sets random y position
  } else { // 50 % chance of spawning on the sides
    y = random(4, 28);
    if (y < 16) { // Spawn on top
      y = 4;
      dir = 'd';
    } else { // Spawn on bottom
      y = 27;
      dir = 'u';
    }
    x = (int)random(4, 28); // Sets random x position
  }
  if (players == 2) {
    player = (int)random(1, 3);
  } else {
    player = 1;
  }
  Enemy newZombie = new Enemy(dir, (int)x * gridSize, (int)y * gridSize, player);
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
  reload = new SoundFile(this, "reload.wav");
  hit = new SoundFile(this, "hit-sound.wav");
  scream = new SoundFile(this, "scream-sound.wav");
}
