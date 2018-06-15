/* 
 ICS4U
 2018/06/14 v2
 Game Summative
 Interface class
 Made by Eren Sulutas and Nabeel Warsalee
 */

class Interface {

  // Instance which displays the borders when they are erased
  void showBorder() {
    imageMode(CENTER);
    image(imgBackground, width/2, height/2, width, height); // Background image
    // Mute/Unmute image
    if (!mute) { 
      image(imgVol1, width/16, 15 * width/16, width/16, width/16);
    } else {
      image(imgVol2, width/16, 15 * width/16, width/16, width/16);
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
    image(imgLogo, width/2, width/4, 5 * width/8, 3 * width/16);
    textSize(width/20);
    text("Singleplayer", width/2, height/2);
    text("2 Players", width/2, 5 * height/8);
    text("How to play", width/2, 3 * height/4);
    text("Leaderboard", width/2, 7 * height/8);
    textSize(7 * width/320);
    text("Made by: Eren Sulutas & Nabeel Warsalee", 3 * width/4, 31 * width/32);
    noFill();
    stroke(255, 0, 0);
    rectMode(CENTER);
    rect(width/2, height/2.06, width/3, height/15);
    rect(width/2, 977 * width/1600, width/3, height/15);
    rect(width/2, 1177 * height/1600, width/3, height/15);
    rect(width/2, 1377 * height/1600, width/3, height/15);
    rectMode(CORNER);
  }

  // Instance method that displays the loading screen 
  void loadingScreen() {
    background(0);
    // Logo
    if (increase && colourIncrement < 255) {
      // Fades in
      fade(15);
      if (colourIncrement == 255) {
        // Logo in full
        delay(700);
        increase = false;
      }
    } else if (!increase && colourIncrement > 0) {
      // Fade out
      fade(-15);
    }

    if (!increase && colourIncrement == 0) {
      // End of loading screen
      runLoadingScreen = false;
    } else {
      // Logo
      imageMode(CENTER);
      tint(255, colourIncrement);
      image(imgNELogo, width/2, width/2, 3 * width/4, 3 * width/4);
    }
  }

  // Instance method to change the fade on the screen
  void fade (int speed) {
    colourIncrement += speed;
  }

  // Instance method that displays the proper interface for gameplay 
  void gamePlay() {
    // Game grid
    showBorder();
    image(imgMap, width/2, height/2, 3 * width / 4, 3 * width / 4);
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
    rect(19 * width/160, 19 * width/160, 53 * width/70, width/160);
    rect(19 * width/160, 981 * width/1120, 53 * width/70, width/160);
    rect(19 * width/160, 19 * width/160, width/160, 53 * width/70);
    rect(981 * width/1120, 19 * width/160, width/160, 229 * width/300);
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
    if (minutes < 10) { // Single minute digits
      zeroes[0] = "0";
    } else {
      zeroes[0] = "";
    }
    if (seconds < 10) { // Single second digits
      zeroes[1] = "0";
    } else {
      zeroes[1] = "";
    }
    text(zeroes[0] + minutes + ":" + zeroes[1] + seconds, width/2, 5 * width/64);
    // Displays the waves
    text("Wave: " + waves, width/2, 61 * height/64);
    textSize(width/40);
    strokeWeight(width/160);
    stroke(255);
    text("P1", 15 * width/16, 9 * height/64);
    // Displays the points
    text("Points", width/16, 3 * height/10);
    text(score + " XP", width/16, 23 * height/64);
    // Displays thet amounts of zombies
    text("Zombies", width/16, 11 * height/16);
    text(zombiesLeft, width/16, 3 * height/4);
    line(59 * width/64, 49 * height/320, 61 * width/64, 49 * height/320); // Line under player 1 health
    line(width/64, 5 * height/16, 7 * width/64, 5 * width/16); // Line under the points tab
    line(width/64, 7 * height/10, 7 * width/64, 7 * height/10); // Line under the zombies tab
    if (players == 2) {
      // Adds player 2 health if the game is multiplayer  
      text("P2", 15 * width/16, height/2);
      text("P2", 15 * width/16, height/2);
      line(59 * width/64, 41 * height/80, 1525, 41 * height/80); // Line under player 2 health 
      // Displays the hearts for player 2
      for (int i = 0; i < player[1].getLives(); i ++) {
        if (i > 2) { // User has extra health that will be dispalyed as gold 
          image(imgHeart2, 15 * width/16, 89 * height/160 + width/16 * i, 3 * width/64, 3 * width/64);
        } else { // Normal health will be displayed red
          image(imgHeart1, 15 * width/16, 89 * height/160 + width/16 * i, 3 * width/64, 3 * width/64);
        }
      }
    }
    // Displays the hearts for player 1
    for (int i = 0; i < player[0].getLives(); i ++) {
      if (i > 2) { // User has extra health that will be displayed as gold 
        image(imgHeart2, 15 * width/16, 31 * height/160 + width/16 * i, 3 * width/64, 3 * width/64);
      } else { // Normal health will be displayed red
        image(imgHeart1, 15 * width/16, 31 * height/160 + width/16 * i, 3 * width/64, 3 * width/64);
      }
    }

    // Displays the bullets for the players
    for (int i = 0; i < players; i ++) {
      if (player[i].getBullets() != 0) {
        text("P" + (i+1) + ": " + player[i].getBullets()  + "/7", width/4 + (i*menuMultiplier), 15 * width/16);
      } else {
        if (player[i].getProgress() >= 0 && player[i].getProgress() <= 20) {
          text("P" + (i+1) + ":  .", width/4 + (i*menuMultiplier), 15 * width/16);
        } else if (player[i].getProgress() > 20 && player[i].getProgress() <= 40) {
          text("P" + (i+1) + ":  ..", width/4 + (i*menuMultiplier), 15 * width/16);
        } else {
          text("P" + (i+1) + ":  ...", width/4 + (i*menuMultiplier), 15 * width/16);
        }
      }

      if (player[i].getBullets() <= 1) {
        image(imgBullet3, 13 * width/40 + (i*menuMultiplier), 297 * width/320, width/32, width/32);
      } else if (player[i].getBullets() >= 2 && player[i].getBullets() <= 4) {
        image(imgBullet2, 13 * width/40 + (i*menuMultiplier), 297 * width/320, width/32, width/32);
      } else {
        image(imgBullet1, 13 * width/40 + (i*menuMultiplier), 297 * width/320, width/32, width/32);
      }
    }
    strokeWeight(1);
    textAlign(CORNER);
  }

  // Instance method that displays the game over screen
  void gameOver() {
    showBorder();
    deaths = (score - 100 * (waves - 1)) / 10;
    textAlign(CENTER);
    textSize(width/10);
    fill(255, 0, 0);
    text("GAME OVER", width/2, height/5);
    fill(255);
    textSize(width/30);
    text("Score: " + score + " XP | Waves Survived: " + (waves - 1), width/2, 5 * width/16);
    if (minutes >= 1) {
      text("Time elapsed: " + minutes + "m " + seconds + "s", width/2, 7 * width/16);
    } else {
      text("Time elapsed: " + seconds + "s", width/2, 7 * width/16);
    }
    text("Zombies Slain: " + deaths, width/2, 9 * width/16);
    text("Bullets Shot: " + shots + " | Weapon Accuracy: " + Math.round(((double)deaths / (double)shots) * 1000.0) / 10.0 + "%", width/2, 11 * width/16);
    returnToMenu();
    text("Leaderboard", width/2, 13 * width/16);
    rectMode(CENTER);
    rect(width/2, 1277 * width/1600, width/3, height/15);
    rectMode(CORNER);
  }

  // Instance method which returns to the main menu when needed
  void returnToMenu() {
    textAlign(CENTER);
    textSize(width/30);
    fill(255);
    text("<-- Return to Main Menu", width/2, 15 * width/16);
    noFill();
    stroke(255, 0, 0);
    rectMode(CENTER);
    rect(width/2, 297 * height/320, width/2.2, height/15);
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

  // Instance method that checks if the user has a new high score
  boolean newHighscore() {
    if (score > leaderboard.lowestScore(players)) {
      return true;
    } else {
      return false;
    }
  }
}
