// Class which handles all the graphic user interface

class Interface {

  // Constructor which displays the game borders
  Interface() {
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
    textAlign(CENTER);
    textSize(width/10);
    fill(255);
    text("ZOMBIE SURVIVAL", width/2, height/4);
    textSize(width/20);
    text("Singleplayer", width/2, height/2);
    text("2 Players", width/2, height/1.5);
    noFill();
    stroke(255, 0, 0);
    rectMode(CENTER);
    rect(width/2, width/2.06, width/3, width/15);
    rect(width/2, width/1.538, width/3, width/15);
    rectMode(CORNER);
  }

  // Instance method that displays the proper interface for gameplay 
  void gamePlay() {
    // Game grid
    stroke(255);
    fill(0);
    for (int i = width/8 + width/160; i < width - width/8; i += width/24) {
      line(i, width/8, i, width - width/8);
    }
    for (int i = height/8 + height/160; i < height - height/8; i += height/24) {
      line(height/8, i, height - height/8, i);
    }
    fill(255, 0, 0);
    noStroke();
    // Game box
    rect(width/8, width/8, width - 2 * width/8, width/160);
    rect(width/8, width - width/8, width - 2 * width/8, width/160);
    rect(width/8, width/8, width/160, width - 2 * width/8);
    rect(width - width/8, width/8, width/160, width - 2 * width/8 + width/160);
  }
  
  // Instance method that displays the game over screen
  void gameOver() {
    textAlign(CENTER);
    textSize(width/10);
    fill(255, 0, 0);
    text("GAME OVER", width/2, height/2);
    fill(255);
    textSize(width/20);
    text("Main Menu", width/2, height/1.5);
    noFill();
    stroke(255, 0, 0);
    rectMode(CENTER);
    rect(width/2, width/1.54, width/3, width/15);
    textSize(30);
  }
  
}