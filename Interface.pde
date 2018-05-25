/* 
 ICS4U
 2018/05/25 v2
 Game Summative
 Interface class
 Made by Eren Sulutas and Nabeel Warsalee
 */

class Interface {
  int currentTime;
  int minutes;
  int seconds;

  // Constructor which displays the game borders
  Interface() {
    showBorder();
  }

  // Instance which displays the borders when they are erased
  void showBorder() {
    background(0);
    fill(255, 0, 0);
    noStroke();
    rect(0, 0, width, width/160); 
    rect(width - width/160, 0, width/160, height); 
    rect(0, height-height/160, width, width/160); 
    rect(0, 0, height/160, height);
  }

  // Instance method that displays the main menu
  void menu() { 
    // Title screen
    showBorder();
    textAlign(CENTER);
    textSize(width/10);
    fill(255);
    text("ZOMBIE SURVIVAL", width/2, height/4);
    textSize(width/20);
    text("Singleplayer", width/2, height/2);
    text("2 Players", width/2, 5 * height/8);
    text("How to play", width/2, 3 * height/4);
    text("Leaderboard", width/2, 7 * height/8);
    noFill();
    stroke(255, 0, 0);
    rectMode(CENTER);
    rect(width/2, height/2.06, width/3, height/15);
    rect(width/2, 5 * height/8 - 23, width/3, height/15);
    rect(width/2, 3 * height/4 - 23, width/3, height/15);
    rect(width/2, 7 * height/8 - 23, width/3, height/15);
    rectMode(CORNER);
  }

  // Instance method that displays the proper interface for gameplay 
  void gamePlay() {
    // Game grid
    showBorder();
    stroke(255);
    fill(0);
    // Y axis grid
    for (int i = width/8 + width/160; i <= width - width/8 + width/160; i += (width - width/4) / 24) {
      line(i - width/160, width/8 - width/160, i - width/160, width - width/8 + width/160);
    }
    // X axis grid
    for (int i = height/8 + height/160; i <= height - height/8 + height/160; i += (height - height/4) / 24) {
      line(height/8 - height/160, i - width/160, height - height/8 + height/160 - width/160, i - width/160);
    }
    fill(255, 0, 0);
    noStroke();
    // Game box
    rect(width/8 - width/160, width/8 - width/160, width - 2 * width/8 + width/140, width/160);
    rect(width/8 - width/160, width - width/8 + width/140 - width/160, width - 2 * width/8 + width/140, width/160);
    rect(width/8 - width/160, width/8 - width/160, width/160, width - 2 * width/8 + width/140);
    rect(width - width/8 + width/140 - width/160, width/8 - width/160, width/160, width - 2 * width/8 + width/75);
    // In-game GUI
    fill(255);
    textAlign(CENTER);
    textSize(width/20);
    // Displays the time 
    currentTime = millis() - startTime;
    seconds = currentTime / 1000;
    if (seconds == 59) {
    startTime = millis();
    minutes ++;
    }
    text(minutes + ":" + seconds, width/2, 125);
    // Displays the waves
    text("Waves: " + "99", width/2, height - 75);
    textSize(width/40);
    strokeWeight(10);
    stroke(255);
    text("P1", 1500, height/2 - 575);
    // Displays the points
    text("Points", 100, height/2 - 320);
    text("0001" + " XP", 100, height/2 - 225);
    line(1475, height/2 - 555, 1525, height/2 - 555); // Line under player 1 health
    line(25, height/2 - 300, 175, height/2 - 300); // Line under the points tab
    if (players == 2) {
      // Adds player 2 health if the game is multiplayer  
      text("P2", 1500, height/2);
      text("P2", 1500, height/2);
      line(1475, height/2 + 20, 1525, height/2 + 20); // Line under player 2 health 
      // Displays the hearts for player 2
      for (int i = 0; i < player[0].getLives(); i ++) {
        if (i > 2) { // User has extra health that will be dispalyed as gold 
          show(imgHeart2, 1500, height/2 + 90 + 100 * i);
        } else { // Normal health will be displayed red
          show(imgHeart1, 1500, height/2 + 90 + 100 * i);
        }
      }
    }
    imageMode(CENTER);
    // Displays the hearts for player 1
    for (int i = 0; i < player[0].getLives(); i ++) {
      if (i > 2) { // User has extra health that will be displayed as gold 
      show(imgHeart2, 1500, height/2 - 490 + 100 * i);
      } else { // Normal health will be displayed red
      show(imgHeart1, 1500, height/2 - 490 + 100 * i);
      }
    }
    strokeWeight(1);
    textAlign(CORNER);
  }

  // Instance method that displays the game over screen
  void gameOver() {
    textAlign(CENTER);
    textSize(width/10);
    fill(255, 0, 0);
    text("GAME OVER", width/2, height/5);
    fill(255);
    textSize(width/30);
    text("Score: " + "1337" + " XP | Waves Survived: " + "9001", width/2, height/2 - 300);
    text("Time elapsed: " + "00:25:12", width/2, height/2 - 100);
    text("Zombies Slain: " + "60", width/2, height/2 + 100);
    text("Bullets Shot: " + "420" + " | Weapon Accuracy: " + "99.9" + "%", width/2, height/2 + 300);
    returnToMenu();
    text("Leaderboard", width/2, 7 * height/8 - 100);
    rectMode(CENTER);
    rect(width/2, 7 * height/8 - 123, width/3, height/15);
    rectMode(CORNER);
  }

  // Instance method which returns to the main menu when needed
  void returnToMenu() {
    textAlign(CENTER);
    textSize(width/30);
    fill(255);
    text("<-- Return to Main Menu", width/2, height - 100);
    noFill();
    stroke(255, 0, 0);
    rectMode(CENTER);
    rect(width/2, height - 115, width/2.2, height/15);
    rectMode(CORNER);
  }

  // Instance method that displays the game instructions
  void instructions() {
    showBorder();
    textAlign(CENTER);
    textSize(width/10);
    fill(255, 0, 0);
    text("HOW TO PLAY", width/2, height/6);
    fill(255);
    textSize(width/30);
    textAlign(CENTER);
    rectMode(CENTER);
    rect(width/2, height/3 - 70, 650, 10);
    rect(width/2, height/2 - 150, 250, 10);
    rect(width/2, height/2 + 50, 170, 10);
    rectMode(CORNER);
    // Each text is 100 px beneath the last 
    text("MOVEMENT CONTROLS", width/2, height/3 - 100);
    text("Player 1 : W, A, S, D | Player 2: ARROW KEYS", width/2, height/3);
    text("FIRE GUN", width/2, height/3 + 100);
    text("Player 1: SPACE | Player 2: SHIFT", width/2, height/3 + 200);
    text("RULES", width/2, height/3 + 300);
    textAlign(LEFT);
    text("-  Each player has 3 hearts", width/16, height/3 + 400);
    text("-  Zombies come in endless waves", width/16, height/3 + 500);
    text("-  Golden hearts are armour and serve as extra health", width/16, height/3 + 600);
    text("-  Game is over when both players have no more hearts", width/16, height/3 + 700);
    text("-  Your objective is to survive as long as possible", width/16, height/3 + 800);
    returnToMenu();
  }

  // Instance method that displays the leaderboard to the user 
  void leaderboard() {
    showBorder();
    textAlign(CENTER);
    textSize(width/10);
    fill(255, 0, 0);
    text("LEADERBOARD", width/2, height/6);
    returnToMenu();
  }

  // Instance method that displays an image
  void show(PImage img, int x, int y) {
    image(img, x, y, 75, 75);
  }
}
