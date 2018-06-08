/* 
 ICS4U
 2018/06/08 v1
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
    imageMode(CENTER);
    show(imgBackground, width/2, height/2, 1600, 1600); // Background image
    // Mute/Unmute image
    if (!mute) { 
      show(imgVol1, 100, 1500, 100, 100);
    } else {
      show(imgVol2, 100, 1500, 100, 100);
    }
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
    show(imgLogo, 800, 400, 1000, 300);
    textSize(width/20);
    text("Singleplayer", width/2, height/2);
    text("2 Players", width/2, 5 * height/8);
    text("How to play", width/2, 3 * height/4);
    text("Leaderboard", width/2, 7 * height/8);
    textSize(35);
    text("Made by: Eren Sulutas & Nabeel Warsalee", 1200, 1550);
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
    show(imgMap, width/2, height/2, 1200, 1200);
    stroke(255);
    fill(0);
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
    // Converts the milliseconds into seconds
    seconds = currentTime / 1000;
    // Once the second timer reaches 59, the minute timer resets and minutes increases
    if (seconds == 59) {
      startTime = millis();
      minutes ++;
    }
    text(minutes + ":" + seconds, width/2, 125);
    // Displays the waves
    text("Wave: " + waves, width/2, height - 75);
    textSize(width/40);
    strokeWeight(10);
    stroke(255);
    text("P1", 1500, height/2 - 575);
    // Displays the points
    text("Points", 100, height/2 - 320);
    text(score + " XP", 100, height/2 - 225);
    // Displays thet amounts of zombies
    text("Zombies", 100, height/2 + 300);
    text(zombiesLeft, 100, height/2 + 400);
    line(1475, height/2 - 555, 1525, height/2 - 555); // Line under player 1 health
    line(25, height/2 - 300, 175, height/2 - 300); // Line under the points tab
    line(25, height/2 + 320, 175, height/2 + 320); // Line under the zombies tab
    if (players == 2) {
      // Adds player 2 health if the game is multiplayer  
      text("P2", 1500, height/2);
      text("P2", 1500, height/2);
      line(1475, height/2 + 20, 1525, height/2 + 20); // Line under player 2 health 
      // Displays the hearts for player 2
      for (int i = 0; i < player[1].getLives(); i ++) {
        if (i > 2) { // User has extra health that will be dispalyed as gold 
          show(imgHeart2, 1500, height/2 + 90 + 100 * i, 75, 75);
        } else { // Normal health will be displayed red
          show(imgHeart1, 1500, height/2 + 90 + 100 * i, 75, 75);
        }
      }
    }
    // Displays the hearts for player 1
    for (int i = 0; i < player[0].getLives(); i ++) {
      if (i > 2) { // User has extra health that will be displayed as gold 
        show(imgHeart2, 1500, height/2 - 490 + 100 * i, 75, 75);
      } else { // Normal health will be displayed red
        show(imgHeart1, 1500, height/2 - 490 + 100 * i, 75, 75);
      }
    }

    // Displays the bullets for the players
    for (int i = 0; i < players; i ++) {
      if (player[i].getBullets() != 0) {
        text("P" + (i+1) + ": " + player[i].getBullets()  + "/7", 400 + (i*menuMultiplier), 1500);
      } else {
        if (player[i].getProgress() >= 0 && player[i].getProgress() <= 20) {
          text("P" + (i+1) + ":  .", 400 + (i*menuMultiplier), 1500);
        } else if (player[i].getProgress() > 20 && player[i].getProgress() <= 40) {
          text("P" + (i+1) + ":  ..", 400 + (i*menuMultiplier), 1500);
        } else {
          text("P" + (i+1) + ":  ...", 400 + (i*menuMultiplier), 1500);
        }
      }

      if (player[i].getBullets() <= 1) {
        show(imgBullet3, 520 + (i*menuMultiplier), 1485, 50, 50);
      } else if (player[i].getBullets() >= 2 && player[i].getBullets() <= 4) {
        show(imgBullet2, 520 + (i*menuMultiplier), 1485, 50, 50);
      } else {
        show(imgBullet1, 520 + (i*menuMultiplier), 1485, 50, 50);
      }
    }
    strokeWeight(1);
    textAlign(CORNER);
  }

  // Instance method that displays the game over screen
  void gameOver() {
    if (newHighscore() && callLeaderboard) { // Checks if the user has a new high score
      newState(5);
    }
    showBorder();
    deaths = (score - 100 * (waves - 1)) / 10;
    textAlign(CENTER);
    textSize(width/10);
    fill(255, 0, 0);
    text("GAME OVER", width/2, height/5);
    fill(255);
    textSize(width/30);
    text("Score: " + score + " XP | Waves Survived: " + (waves - 1), width/2, height/2 - 300);
    if (minutes >= 1) {
      text("Time elapsed: " + minutes + "m " + seconds + "s", width/2, height/2 - 100);
    } else {
      text("Time elapsed: " + seconds + "s", width/2, height/2 - 100);
    }
    text("Zombies Slain: " + deaths, width/2, height/2 + 100);
    text("Bullets Shot: " + shots + " | Weapon Accuracy: " + Math.round(((double)deaths / (double)shots) * 1000.0) / 10.0 + "%", width/2, height/2 + 300);
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
    rect(width/2, height/2 - 150, 650, 10);
    rect(width/2, height/2 + 50, 170, 10);
    rectMode(CORNER);
    // Each text is 100 px beneath the last 
    text("MOVEMENT CONTROLS", width/2, height/3 - 100);
    text("Player 1 : W, A, S, D | Player 2: I, J, K, L", width/2, height/3);
    text("FIRE GUN / RELOAD GUN", width/2, height/3 + 90);
    text("Player 1: SPACE / R | Player 2: SHIFT / P", width/2, height/3 + 200);
    text("RULES", width/2, height/3 + 300);
    textAlign(LEFT);
    text("-  Each player has 3 hearts", width/16, height/3 + 400);
    text("-  Zombies come in endless waves", width/16, height/3 + 500);
    text("-  Golden hearts are armour and serve as extra health", width/16, height/3 + 600);
    text("-  Game is over when both players have no more hearts", width/16, height/3 + 700);
    text("-  Your objective is to survive for as long as possible", width/16, height/3 + 800);
    returnToMenu();
  }

  // Instance method that displays the leaderboard to the user 
  void leaderboard() {
    showBorder();
    textAlign(CENTER);
    textSize(width/10);
    fill(255, 0, 0);
    text("LEADERBOARD", width/2, height/6);
    leaderboard.display();
    returnToMenu();
  }

  // Instance method that lets the user enter a new high score entry 
  void highscore() {
    showBorder();
    textAlign(CENTER);
    textSize(width/10);
    fill(252, 229, 10);
    text("HIGH SCORE!", width/2, height/4);
    textSize(width/20);
    fill(255);
    text("Score: " + score + " XP", width/2, height/4 + 100);
    text("Name: " + input, width/2, height/2);
    textSize(width/30);
    text("Enter Name to Claim High Score:", width/2, height/2 - 100);
    if (input.length() == 3) {
      text("Press Enter to Continue", width/2, height/2 + 100);
      if (inputComplete) {
        if (callLeaderboard) {
          // Replaces the score
          leaderboard.write(leaderboard.replaceScore(score, players), score, waves, input, players);
          callLeaderboard = false;
        }
      }
    }
  }

  // Instance method that displays an image
  void show(PImage img, int x, int y, int w, int h) {
    image(img, x, y, w, h);
  }

  // Instance method that checks if the user has a new high score
  boolean newHighscore() {
    if (score > leaderboard.lowestScore(players)) {
      return true;
    } else {
      return false;
    }
  }
}
