# To-do list for ICS4U Game

* ~Get Tom's Planner done~
* ~Get Mindomo done~
* ~Get files onto Processing~
* ~Finish adding graphical components.~
* ~Start adding audio to the game.~
* Refine the game and test it for bugs
* Write down a *'report'* of how our game meets the ICS4U expecations

## Mechanics To do list
* ~Work on Game class~       
* ~Work on the Person class~
* ~Get the player to move based on grid location and not pixel location!~
* ~Get the grid size readjusted to 50x50 px~
* ~Make sure player can't move outside the gameplay box~
* ~Start working on the fighting mechanics~
* ~Center the grid~
* ~Have bullets be deleted if they are out of bounds~
* ~Get the enemy class to spawn and define its special properties~
* ~Be able to make the enemy class die to bullets~
* ~Have the enemy class move to the player block by block at a fixed speed~
* ~Have the enemy attack when it's close~
* ~Establish a RECURSIVE spawning of the zombies around the screen~
* ~Make sure user's can't move and/or obstruct gameplay when dead~
* ~Have zombie img change directions when moving.~
* ~Add player imgs to the game and on the player~
* ~Do the same for the player img~
* ~Start creating the box/defense crate class.~
* ~Have the crate class working in obstructing zombies and players~
* ~Start changing how the zombies spawn~
* ~Create a recursive method to find get the number of zombies to spawn~
* ~Move the canShoot() method and stamina variables to the player class~
* ~Start adding audio to the game~
* ~Add a reload mechanism to the player class.~
* ~Adjust location of where bullets spawn according to where the player's gun is.~
* ~Add a reload button for both players~
* ~Adjust spawning of zombies so they spaw gradually.~
* ~Set the crates up for the new map~
* Have the zombies move out of the way when they encounter a crate
* Begin testing for bugs...

### Concerns
* Make sure that when a lot of zombies spawn, they don't spawn on top of each other. They spawn in "mini-waves".
* Make sure the zombies don't spawn on invisible crates (Not as bas since they spawn on sides)
* Avoid loading images and audio files multiple times

### Ideas
* Have zombies fade in when spawning
* ~Introduce a reload mechanism to stop player from continuously shooting for a certain period of time~
* ~Use invisible crates to block off buildings in the map~
* ~Have the bullet location match with where the gun is on the player model~
* ~**FOR 2-D ARRAYS, MAKE ONE FOR THE PLAYER IMGS, WHERE ROW 1 IS FOR P1 AND ROW 2 IS FOR P2**~

Note: 
Top left of grid: 200, 200
Bottom right of grid: 1400, 1400
Grid size 24x24

## UI To do list
* Simplify image display
### Leaderboard
* ~Check if user has a high score~
* ~Use private variables~
* ~Make user enter name if they have new high score~
* ~Use a sort to make the algorithm more efficient~
* ~Print data onto the file~
### Main menu
* ~Add instructions~
* ~Add leaderboard~
* ~New controls~
* ~Add credits~
### In-game
* ~Add user interface for lives, waves etc~
* ~Do all visuals~
* ~Make user/zombie images face the way they are going~
### End game
* ~Return to main menu and leaderboard~
* ~Display all the stats~
### Instructions
* ~Add lines to emphasize the controls and rules~

## Final Check
* Make sure method line up with Mindomo   

## ICS4U Game Criteria
* Object-Oriented Programming ✅
* Inheritance ✅
* Encapsulation ✅
* File Writing and Reading ✅
* Recursion and Recursive methods ✅
* Runtime errors & try-catch blocks ✅
* Sorting ✅
* ArrayLists ✅
* 1-D arrays ✅
* 2-D arrays ✅
* Search ✅ (Sort in the leaderboard classes uses a search before sorting)

