/* 
 ICS4U
 2018/05/31 v1 [TEST BUILD]
 Game Summative
 Leaderboard class
 Made by Eren Sulutas and Nabeel Warsalee
 */

class Leaderboard {
  PrintWriter pw;
  BufferedReader br;
  String[] lineTotal = new String[14]; // String that stores the information on every line in the file
  ArrayList<Integer> data = new ArrayList<Integer>(); // Arraylist that stores the point data
  int y = 350;
  boolean loop = false;

  // Instance method that reads the file 
  Leaderboard() {
    br = createReader("leaderboard.txt");
    int lineNum = 0;

    try {
      String line;
      // Reads the first line
      line = br.readLine();

      while (line != null) {
        if (lineNum != 0 && lineNum != 1 && lineNum != 7 && lineNum != 8) { 
          String[] integers = split(line, "."); // Gets only the integer portion of each line 
          data.add(Integer.parseInt(integers[12])); // Adds the points to the data ArrayList
        }
        lineTotal[lineNum] = line; // Stores the entire line information in the lineTotal array
        line = br.readLine(); // Prepares to read the next line 
        lineNum ++;
      }
      br.close();
    } 
    catch (IOException e) {
      println("Error: File not found.");
    }
    catch (NullPointerException e) {
      println("No file called leaderboard.txt found...");
    }
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

  // Instance method that returns the lowest score on the leaderboard
  // Used to check if the user has a new high score
  int lowestScore(int mode) {
    if (mode == 1) { // Solo
      // Returns the lowest point value 
      return data.get(4);
    } else { // Duos
      // Returns the lowest point value 
      return data.get(9);
    }
  }

  // Instance method that returns in which line of the leaderboard the new score is to be added in
  int replaceScore(int userScore, int mode) {
    boolean isLargerThan = false;
    int i;

    if (mode == 1) { // Solos
      i = 4;
    } else { // Duos
      i = 9;
    }

    // Sorts through the scores to determine where the users score stands 
    do {
      if (userScore > data.get(i)) {
        isLargerThan = true;
        i --;
      } else {
        isLargerThan = false;
      }
    } while (isLargerThan);

    // Returns the line the new score is supposed to be in
    return i;
  }

  // Instance method that writes in the file the updated high score list
  void write(int newLine, int newScore, int newWave, String name, int mode) {
    // Adjusts the line to match with the file 
    int multiplier = 0;
    if (mode == 1) { // Solos
      multiplier = 2;
    } else { // Duos
      newLine -= 5;
      multiplier = 9;
    }

    // Loops over the lines of the leaderboard including/below the line of the new high score
    for (int i = 4 + multiplier; i > newLine + multiplier; i --) {
      // Stores the information into the lineTotal array which holds the data for the file 
      if (i == (newLine + multiplier + 1)) { // New score is added here
        lineTotal[i] = "" + (i - 1) + "............" + newScore + "......." + newWave + "........." + name;
      } else { // Current score takes info from the next highest score
        lineTotal[i] = lineTotal[i-1];
        // Edits the first part showing the place on the leaderboard 
        if (i == (4 + multiplier)) { // Last place 
          lineTotal[i] = lineTotal[i].replace(lineTotal[i].charAt(0), '5');
        } else {
          lineTotal[i] = lineTotal[i].replace(lineTotal[i].charAt(0), lineTotal[i+1].charAt(0));
        }
      }
    }

    pw = createWriter("leaderboard.txt");
    for (int i = 0; i < lineTotal.length; i ++) {
      // Loops through the data stored in each line of the file and prints it to the file
      println(lineTotal[i]);
      pw.println(lineTotal[i]);
    }
    pw.flush(); // Flushes the stream of text
  }
}
