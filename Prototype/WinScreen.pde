class WinScreen extends Display {

  color[] confettiColours = {
    #ff6961,
    #ffb480,
    #f8f38d,
    #42d6a4,
    #08cad1,
    #59adf6,
    #9d94ff,
    #c780e8
  };

  color[] currentColours; 
  Difficulty completedGameDifficulty;
  int lastColourChangeTime = 0;
  int completedGameRounds;
  int completedGameTotalLives;
  int completedGameLives;
  
  void setup(){
     completedGameDifficulty = currentGame.getGameDifficulty();
     completedGameRounds = currentGame.getTotalRounds(); // Store this values for the game stats window on win screen
     completedGameTotalLives = currentGame.getTotalLives();
     completedGameLives = currentGame.getCurrentLives(); // So that you can safely void the currentGame
     
     // Reset all the global variables so that its possible to play again:
     currentGame = null;
     currentRound = null;
     difficultySelected = false; 
     
     // Remove all the towers on the grid:
     while (!AllTowers.isEmpty()) {
        AllTowers.remove(0); // Remove the tower at index 0
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
  
    if (currentColours == null){ 
       currentColours = new color[Grid.length * Grid[0].length]; 
       changeColour();
    }
  
    if (currentTime - lastColourChangeTime >= 1500 ){ // Change colours
      changeColour();
      lastColourChangeTime = millis();
    }
  
    fillCellsColour();
  
    fill(255);
    textSize(200);
    text("YOU", 250, 300);
    text("WIN!", 300, 500);
  
    // Game stats window:
    strokeWeight(8);
    strokeJoin(ROUND);
    noFill();
    stroke(currentColours[0]);
    rect(25, HEIGHT*0.85 - 15, 825, 125);
    textSize(30);
    
    String difficultyString;
    if (completedGameDifficulty == Difficulty.EASY){ difficultyString = "Minor Infection"; 
    } else if (completedGameDifficulty == Difficulty.MEDIUM){ difficultyString = "Pathogen Assault";
    } else if (completedGameDifficulty == Difficulty.HARD){ difficultyString = "Biohazard Rampage"; } else { difficultyString = " "; } // Will never reach this else, but to silence compiler
    String roundAndMode = "WOW! You protected the body from " +difficultyString;
    text(roundAndMode , 50, HEIGHT*0.9 - 5);
    
    String livesString;
    int livesLost = this.completedGameTotalLives - this.completedGameLives;
    if (livesLost == 0){ livesString = "You didn't lose any lives! You absolute Germ Vanquisher!";
    } else if ((livesLost/this.completedGameTotalLives) <= 0.25){ livesString = "You only lost " +String.valueOf(livesLost) + " lives! You're an Immune System Hero!"; 
    } else if (livesLost/this.completedGameTotalLives >= 0.75){ livesString = "You lost " +String.valueOf(livesLost) + " lives! Phew! That was close!";
    } else { livesString = "You lost " +String.valueOf(livesLost) + " lives! You're one reliable defender!"; }
    text(livesString, 50, HEIGHT*0.95 - 5);
   
    // Play again button:
    noFill();
    rect(852, HEIGHT*0.85 - 15, 125, 125);
    text("Play", 875, HEIGHT*0.9 - 5);
    text("again?", 880, HEIGHT*0.95 -5);
    StateChangingButton playAgainButton = new StateChangingButton(852, (int)(HEIGHT*0.85 - 15), 125, 125, GameState.MAP);
    stateChangingButtons.add(playAgainButton);
  }

  void fillCellsColour(){
    int colourIndex = 0;
  
    for (int x = 0; x < Grid.length; x++){
        for (int y = 0; y < (Grid[0].length -1); y++){
            int nextIndex = colourIndex + 1; // Makes the outline of cell a different colour
            if (nextIndex == 280){ nextIndex = 0; } 

            Grid[x][y].confetti(currentColours[colourIndex], currentColours[nextIndex]); 
            colourIndex++;
        }
    }
  }

  void changeColour(){
    for (int i = 0; i < currentColours.length; i++) {
       int colourIndex = (int)random(0, confettiColours.length);
       currentColours[i] = confettiColours[colourIndex];
    }  
  }
}
