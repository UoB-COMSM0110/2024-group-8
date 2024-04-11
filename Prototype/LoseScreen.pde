class LoseScreen extends Display {  
  PImage[] germs;
  PImage[] currentGerms; 
  Difficulty completedGameDifficulty;
  int lastGermChangeTime = 0;
  int completedGameRounds;
  int completedGameTotalLives;
  
  void setup(){
     germs = new PImage []{
           loadImage("germ/germ1L.png"),
           loadImage("germ/germ1R.png"),
           loadImage("germ/germ2L.png"),
           loadImage("germ/germ2R.png"),
           loadImage("germ/germ3L.png"),
           loadImage("germ/germ3R.png"),
           loadImage("germ/germ4L.png"),
           loadImage("germ/germ4R.png"),
           loadImage("germ/germ5L.png"),
           loadImage("germ/germ5R.png"),
           loadImage("germ/germ6L.png"),
           loadImage("germ/germ6R.png"),
           loadImage("germ/germ7L.png"),
           loadImage("germ/germ7R.png"),
           loadImage("germ/germ8L.png"),
           loadImage("germ/germ8R.png")
     };
    
     completedGameDifficulty = currentGame.getGameDifficulty();
     completedGameRounds = currentGame.getTotalRounds(); // Store this values for the game stats window on win screen
     completedGameTotalLives = currentGame.getTotalLives();
     
     // Reset all the global variables so that its possible to play again:
     currentGame = null;
     currentRound = null;
     difficultySelected = false; 
     
     // Remove all the towers on the grid:
     while (!AllTowers.isEmpty()) {
        AllTowers.remove(0); // Remove the tower at index 0 repeatedly
     }
     
     // Remove all the germs on the grid:
     while (!AllGerms.isEmpty()) {
        AllGerms.remove(0); // Remove the germ at index 0
     }
     
     // Re-initialise a new grid
     for (int x = 0; x < Grid.length; x++){
       for (int y = 0; y < Grid[0].length; y++){
          Grid[x][y] = new Cell(x, y);
       }
     }
  }

  void draw(){   
    background(153, 204, 255);
  
    int currentTime = millis();
  
    if (currentGerms == null){ 
       currentGerms = new PImage[Grid.length * (Grid[0].length - 1)]; 
       changeGerm();
    }
  
    if (currentTime - lastGermChangeTime >= 1500 ){ // Change colours
      changeGerm();
      lastGermChangeTime = millis();
    }
  
    fillCellsGerm();
  
    fill(#006633);
    textSize(200);
    text("YOU", 250, 300);
    text("LOSE", 230, 500);
  
    // Game stats window:
    strokeWeight(8);
    strokeJoin(ROUND);
    noFill();
    stroke(#006633);
    rect(25, HEIGHT*0.85 - 15, 825, 125);
    textSize(30);
    fill(0, 204, 102);
    String difficultyString;
    if (completedGameDifficulty == Difficulty.EASY){ difficultyString = "Minor Infection"; 
    } else if (completedGameDifficulty == Difficulty.MEDIUM){ difficultyString = "Pathogen Assault";
    } else if (completedGameDifficulty == Difficulty.HARD){ difficultyString = "Biohazard Rampage"; } else { difficultyString = " "; } // Will never reach this else, but to silence compiler
    String roundAndMode = "You couldn't protect the body from " +difficultyString;
    text(roundAndMode , 50, HEIGHT*0.9 - 5);
    text("The germs have taken over!", 50, HEIGHT*0.95 - 5);
   
    // Try again button:
    noFill();
    rect(852, HEIGHT*0.85 - 15, 125, 125);
    text("Try", 875, HEIGHT*0.9 - 5);
    text("again?", 880, HEIGHT*0.95 -5);
    StateChangingButton tryAgainButton = new StateChangingButton(852, (int)(HEIGHT*0.85 - 15), 125, 125, GameState.MAP);
    stateChangingButtons.add(tryAgainButton);
  }

  void fillCellsGerm(){
    int germIndex = 0;
  
    for (int x = 0; x < Grid.length; x++){
        for (int y = 0; y < (Grid[0].length - 1); y++){
            Grid[x][y].outlineSpecificColour(0, 204, 102);
            image(currentGerms[germIndex], x * cellSize, y * cellSize, cellSize, cellSize);
            germIndex++;
        }
     }
  }

  void changeGerm(){
    for (int i = 0; i < currentGerms.length; i++) {
       int germIndex = (int)random(0, (germs.length - 1));
       currentGerms[i] = germs[germIndex];
    }  
  }
}
