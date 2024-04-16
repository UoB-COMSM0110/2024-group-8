class DifficultySelection extends Display {
    PImage background;
    PImage easyEmblem;
    PImage mediumEmblem;
    PImage hardEmblem;
    
    int entryTime = 0; // Implements a halt on button presses to stop auto clicking a difficulty based on where you just pressed a map button

    GameState currentMap;

    DifficultySelection(){
        this.background = loadImage("startpage.png");
        this.background.resize(width, height);
    }
    
    void setup(GameState gameMapOrgan){
      this.currentMap = gameMapOrgan;
    }

    void draw(){
        // sets the entry time for the first entrance to difficulty selection screen
        if ((this.entryTime == 0) || (millis()-entryTime) > 100000){  // If first entry, or entry to difficulty selection after a different game
          entryTime = millis();
        } 
      
        background(background);
        
        this.easyEmblem = loadImage("easyEmblem.png");
        this.mediumEmblem = loadImage("mediumEmblem.png");
        this.hardEmblem = loadImage("hardEmblem.png");

        int imageSize = 250;
        int outlineSize = imageSize + 20;

        strokeWeight(8); 
        strokeJoin(ROUND);
        stroke(255);
        fill(153, 204, 255);
        rect(80, 80, 840, 640);
        
        fill(255);
        textSize(40);
        text("Choose a difficulty:", 110, 140);
        
        textSize(70);
        fill(#306E80);
        text("MINOR", 260, 230);
        text("INFECTION", 200, 290);
        
        fill(#356920);
        text("PATHOGEN", 400, 420);
        text("ASSAULT", 430 , 480);
        
        fill(#94221F);
        text("BIOHAZARD", 180, 600);
        text("RAMPAGE" , 200, 660);
        
        //stroke(255);
        //noFill();
        //rect(160, 160, 680, 150);
        //rect(160, 350, 680, 150);     
        //rect(160, 535, 680, 150); // uncomment if you want to visualise the buttons as 
        
        // Draw and animate the buttons
        
        PressableButton easyButton = new PressableButton(160, 160, 680, 150);
        PressableButton mediumButton = new PressableButton(160, 350, 680, 150);
        PressableButton hardButton = new PressableButton(160, 535, 680, 150);
        handleButton(this.easyEmblem, 630, 120, imageSize, 680, 150);
        handleButton(this.mediumEmblem, 120, 300, imageSize, 680, 150);
        handleButton(this.hardEmblem, 630, 480, imageSize, 680, 150);

        int timeOnScreen = (millis() - this.entryTime);

        if (timeOnScreen > 1000){ // Set the difficulty and start the game
           if (mousePressed){           
                // New game object is created based on difficulty
                if (easyButton.onButton()){ 
                    currentGame = new RunningGame(Difficulty.EASY);
                    currentGameState = this.currentMap; 
                } else if (mediumButton.onButton()){ 
                  currentGame = new RunningGame(Difficulty.MEDIUM); 
                  currentGameState = this.currentMap; 
                } else if (hardButton.onButton()){ 
                  currentGame = new RunningGame(Difficulty.HARD);
                  currentGameState = this.currentMap; 
                }         
           }
        }

        //BackButton(backButton, WIDTH/50, HEIGHT/50, 100, GameState.MAP);
    }

    // Function to handle button animation
    void handleButton(PImage emblem, int x, int y, int imageSize, int buttonWidth, int buttonHeight) {
        boolean isButtonHovered = false; // Track if the button is being hovered over

        // Check if mouse is over the button
        if (mouseX >= x && mouseX <= x + buttonWidth && 
            mouseY >= y && mouseY <= y + buttonHeight) {
            isButtonHovered = true;
        }

        // Draw button with animation
        if (isButtonHovered) {
            image(emblem, x - 5, y - 5, imageSize + 10, imageSize + 10); // Scale up slightly
        } else {
            image(emblem, x, y, imageSize, imageSize); // Normal size if not hovered
        }
    }
    
    /*
    void BackButton(PImage mapImage, int x, int y, int outlineSize, GameState state){
        // Check if mouse is over the map image
        if (mouseX >= x - 10 && mouseX <= x + 70 && 
            mouseY >= y - 10 && mouseY <= y + 70) {
            image(mapImage, x-20 , y-20 , 110, 110); // Scale up slightly
            if (mousePressed) {
                currentGameState = state; // Change game state if the map is clicked
            }
        } else {
            image(mapImage, x, y, 70, 70); // Normal size if not hovered
        }
    }
    */ // Doesn't work at the moment//
    
}
