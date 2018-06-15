/* 
 ICS4U
 2018/06/15 v1
 Game Summative
 Leaderboard class
 Made by Eren Sulutas and Nabeel Warsalee
 */

class Leaderboard {
  private String[] lineTotal = new String[14]; // String that stores the information on every line in the file
  private ArrayList<Integer> data = new ArrayList<Integer>(); // Arraylist that stores the point data
  private int y = 7 * width/32;

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
      println("Error: File not found. Make sure you downloaded leaderboard.txt from the GitHub and ensure the file is with the other game files and not the Data folder.");
    } 
    catch (NullPointerException e) {
      println("Error: File not found. Make sure you downloaded leaderboard.txt from the GitHub and ensure the file is with the other game files and not the Data folder.");
    }
  }

  // Instance method that displays the text onto the screen
  void display() {
    textSize(width/22);
    textAlign(CORNER);
    fill(255);
    for (int i = 0; i < lineTotal.length; i ++) {
      text(lineTotal[i], 5 * width/32, y + width/20 * i);
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
  // This method is a step to the insertion-hybrid sort that is used in the write method
  int replaceScore(int userScore, int mode) {
    boolean isLargerThan = true;
    int i;
    int low;

    if (mode == 1) { // Solos
      i = 4;
      low = 0;
    } else { // Duos
      i = 9;
      low = 5;
    }

    // Sorts through the scores to determine where the users score stands 
    do {
      if (i >= low) {
        if (userScore > data.get(i)) {
          isLargerThan = true;
          i--;
        } else {
          isLargerThan = false;
          i ++;
        }
      } else {
        isLargerThan = false;
        i ++;
      }
    } while (isLargerThan);

    i -= low; // Adjusts the line depending on the individual leaderboard

    // Returns the line the new score is supposed to be in
    return i;
  }

  // Instance method that writes in the file the updated high score list and uses an insertion-hybrid sort to sort the file
  void write(int newLine, int newScore, int newWave, String name, int mode) {
    int prev;
    String scoreString = Integer.toString(newScore);
    String waveString = Integer.toString(newWave); // Converts the score and waves to strings for later adjustment 
    final int RADIX = 10;
    // Adjusts the line to match with the file 
    int multiplier = 0;
    if (mode == 1) { // Solos
      multiplier = 2;
    } else { // Duos
      multiplier = 9;
    }

    // Adjusts the score digits to fit on the leaderboard
    if (newScore < 100) { // Adds two zeros before the score
      scoreString = "00" + scoreString;
    } else if (newScore < 1000 && newScore >= 100) { // Adds one zero before the score 
      scoreString = "0" + scoreString;
    } 

    // Adjusts the wave digits to fit on the leaderboard
    if (newWave < 10) {
      waveString = "0" + waveString;
    }


    // Loops over the lines of the leaderboard including/below the line of the new high score
    for (int i = 4 + multiplier; i >= newLine + multiplier; i --) {
      // Stores the information into the lineTotal array which holds the data for the file 
      if (i == (newLine + multiplier)) { // New score is added here
        int place = i - 1;
        if (mode == 2) {// Duos
          place -= 7;
        }
        lineTotal[i] = "" + place + "............" + scoreString + "......." + waveString + "........." + name;
      } else { // Current score takes info from the next highest score
        prev = i - 1;
        if (mode == 2) { // Duos
          prev -= 7;
        }
        // Shifts the larger items down by one using an insertion sort technique 
        lineTotal[i] = lineTotal[i-1];
        // Edits the first part showing the place on the leaderboard 
        lineTotal[i] = replaceChar(lineTotal[i], Character.forDigit(prev, RADIX));
      }
    }

    try {
      pw = createWriter("leaderboard.txt");

      for (int i = 0; i < lineTotal.length; i ++) {
        // Loops through the data stored in each line of the file and prints it to the file
        pw.println(lineTotal[i]);
      }

      pw.flush(); // Flushes the stream of text
    }  
    catch (NullPointerException e) {
      println("Error: File not found.");
    }
    
  }

  // Replaces place on scoreboard
  String replaceChar(String s, char c) {
    StringBuilder sb = new StringBuilder(s);
    sb.setCharAt(0, c);
    return sb.toString();
  }
}
