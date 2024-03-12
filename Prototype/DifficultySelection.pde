class DifficultySelection extends Display {
    PImage background;
    PImage easyEmblem;
    PImage mediumEmblem;
    PImage hardEmblem;
    
    int entryTime = 0; // Implements a halt on button presses to stop auto clicking a difficulty based on where you just pressed a map button

    GameState currentMap;

    DifficultySelection(GameState gameMapOrgan){
        this.background = loadImage("startpage.png");
        this.background.resize(WIDTH, HEIGHT);
        this.currentMap = gameMapOrgan;
    }

    void draw(){
        // sets the entry time for the first entrance to difficulty selection screen
        if (this.entryTime == 0){ 
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
        text("BIOHAZARD", 180, 610);
        text("RAMPAGE" , 200, 660);
        
        //stroke(255);
        //noFill();
        //rect(160, 160, 680, 150);
        //rect(160, 350, 680, 150);     
        //rect(160, 535, 680, 150); // uncomment if you want to visualise the buttons as 
        
        image(this.easyEmblem, 630, 120, imageSize - 10, imageSize - 10);
        PressableButton easyButton = new PressableButton(160, 160, 680, 150);

        image(this.mediumEmblem, 120, 300, imageSize, imageSize);
        PressableButton mediumButton = new PressableButton(160, 350, 680, 150);

        image(this.hardEmblem, 630, 480, imageSize, imageSize);
        PressableButton hardButton = new PressableButton(160, 535, 680, 150);


        int timeOnScreen = (millis() - this.entryTime);

        if (timeOnScreen > 1000){ // Set the difficulty and start the game
           if (mousePressed){
                // New game object is created based on difficulty
                if (easyButton.onButton()){ currentGame = new RunningGame(Difficulty.EASY); }
                if (mediumButton.onButton()){ currentGame = new RunningGame(Difficulty.MEDIUM); }
                if (hardButton.onButton()){ currentGame = new RunningGame(Difficulty.HARD); }

                difficultySelected = true;
                currentGameState = this.currentMap; // Navigates to previously selected map
           }
        }
    }
}
