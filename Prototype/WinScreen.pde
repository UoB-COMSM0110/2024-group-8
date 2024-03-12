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
     
     currentGame = null;
     currentRound = null;
     difficultySelected = false; // Reset all the global variables so that its possible to play again 
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
    rect(25, HEIGHT*0.85 - 10, 825, 125);
    textSize(30);
    
    String difficultyString;
    if (completedGameDifficulty == Difficulty.EASY){ difficultyString = "Minor Infection"; 
    } else if (completedGameDifficulty == Difficulty.MEDIUM){ difficultyString = "Pathogen Assault";
    } else if (completedGameDifficulty == Difficulty.HARD){ difficultyString = "Biohazard Rampage"; } else { difficultyString = " "; } // Will never reach this else, but to silence compiler
    String roundAndMode = "WOW! You protected the body from " +difficultyString;
    text(roundAndMode , 50, HEIGHT*0.9);
    
    String livesString1;
    int livesLost = this.completedGameTotalLives - this.completedGameLives;
    if ((livesLost/this.completedGameTotalLives) <= 0.25){ livesString1 = "You only lost " +String.valueOf(livesLost) + " lives! You absolute Germ Vanquisher!"; 
    } else if (livesLost/this.completedGameTotalLives >= 0.75){ livesString1 = "You lost " +String.valueOf(livesLost) + " lives! Phew! That was close!";
    } else { livesString1 = "You lost " +String.valueOf(livesLost) + " lives! You're one reliable defender!"; }
    text(livesString1, 50, HEIGHT*0.95);
   
    // Play again button:
    noFill();
    rect(852, HEIGHT*0.85 - 10, 125, 125);
    text("Play", 875, HEIGHT*0.9);
    text("again?", 865, HEIGHT*0.95);
    StateChangingButton playAgainButton = new StateChangingButton(852, (int)(HEIGHT*0.85 - 10), 125, 125, GameState.MAP);
    stateChangingButtons.add(playAgainButton);
  }

  void fillCellsColour(){
    int colourIndex = 0;
  
    for (int x = 0; x < Grid.length; x++){
        for (int y = 0; y < Grid[0].length; y++){
            int nextIndex = colourIndex + 1; // Makes the outline of cell a different colour
            if (nextIndex == 260){ nextIndex = 0; } 

            Grid[x][y].confetti(currentColours[colourIndex], currentColours[nextIndex]); // Implement halt, so its less seziurey LOL
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
