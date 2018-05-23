/* 
 ICS4U
 2018/05/23 v2
 Game Summative
 Interface class
 Made by Eren Sulutas and Nabeel Warsalee
 */

class Interface {

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
    // Y axis 
    for (int i = width/8 + width/160; i <= width - width/8 + width/160; i += (width - width/4) / 24) {
      line(i - width/160, width/8 - width/160, i - width/160, width - width/8 + width/160);
    }
    // X axis
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
    text("Player1 : W, A, S, D | Player2: ARROW KEYS", width/2, height/3);
    text("FIRE GUN", width/2, height/3 + 100);
    text("Player1: SPACE | Player2: SHIFT", width/2, height/3 + 200);
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
}
