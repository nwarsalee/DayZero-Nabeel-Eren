class CycleBot {
  int x, y;
  char moving;

  // Constructor method which initializes a light cycle 
  CycleBot(int x, int y, char moving) {
    this.x = x;
    this.y = y;
    this.moving = moving;
  }

  // Method which controls the moves of a bot
  void playBot(int order) {
    if (get(x, y) == color(0, 0, 0)) { // Checks if the light cycle has intersected with another trail
      if (order == 0) {
        fill(255, 196, 44);
      } else if (order == 1) {
        fill(255, 0, 0);
      } else if (order == 2) {
        fill(0, 255, 0);
      }
      noStroke();
      rect(x, y, 10, 10);

      if (moving == 'u') {
        y -= 10;
        if (get(x, y - 10) != color(0, 0, 0)) { // Moving up, goes to the side if there is an obstruction
          if (get(x - 10, y) != color(0, 0, 0)) {
            moving = 'r';
          } else {
            moving = 'l';
          }
        }
      } else if (moving == 'd') {
        y += 10;
        if (get(x, y + 10) != color(0, 0, 0)) { // Moving down, goes to the side if there is an obstruction
          if (get(x - 10, y) != color(0, 0, 0)) {
            moving = 'r';
          } else {
            moving = 'l';
          }
        }
      } else if (moving == 'r') {
        x += 10;
        if (get(x + 10, y) != color(0, 0, 0)) { // Moving right, goes up/down if there is an obstruction
          if (get(x, y - 10) != color(0, 0, 0)) {
            moving = 'd';
          } else {
            moving = 'u';
          }
        }
      } else if (moving == 'l') {
        x -= 10;
        if (get(x - 10, y) != color(0, 0, 0)) { // Moving left, goes up/down if there is an obstruction
          if (get(x, y - 10) != color(0, 0, 0)) {
            moving = 'd';
          } else {
            moving = 'u';
          }
        }
      }
    } else {
      if (turnsDeadBot[order] == 0) {
        gameScoreBot ++;
        turnsDeadBot[order] ++;
      }
    }
  }
  boolean isAlive() {
    if (get(x, y) != color(0, 0, 0)) {
      return false;
    } else {
      return true;
    }
  }
}