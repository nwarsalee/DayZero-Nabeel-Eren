/* 
 ICS4U
 2018/05/27 v1
 Game Summative
 Leaderboard class
 Made by Eren Sulutas and Nabeel Warsalee
 */

class Leaderboard {
  PrintWriter output;
  BufferedReader br;
  String[] lineTotal = new String[14];
  int y = 350;

  // Instance method that reads the file 
  void read() {
    br = createReader("leaderboard.txt");
    int i = 0;

    try {
      String line;

      // Reads the first line
      line = br.readLine();
      while (line != null) {
        lineTotal[i] = line;
        line = br.readLine();
        i ++;
      }
      br.close();
    } 
    catch (IOException e) {
      print("Error: File not found.");
    }
    display();
  }

  // Instance method that displays the text onto the screen
  void display() {
    textSize(width/22);
    textAlign(CORNER);
    fill(255);
    for (int i = 0; i < lineTotal.length; i ++) {
      text(lineTotal[i], 250, y + 80 * i);
    }
  }
  
}