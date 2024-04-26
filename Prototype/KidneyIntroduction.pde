class KidneyIntroduction extends Display {
    PImage background;

    int entryTime = 0;

    KidneyIntroduction() {
        this.background = loadImage("kidneyintrod.png");
        this.background.resize(width, height);  
    }

    void draw() {
        if (currentGameState == GameState.KIDNEY_INTRO) {
            background(background);
            fill(255);

            // Manage the introduction timing
            if (entryTime == 0 || (millis() - entryTime) > 100000) {
                entryTime = millis();
            }

            int timeOnScreen = millis() - entryTime;
            
            fill(#ffcccc);
            stroke(#bf5654);
            rect(200, 615, 600, 100);
            PressableButton button = new PressableButton(200, 615, 600, 100);
            
            if (button.onButton()){
              rect(190, 605, 620, 120);
              if (timeOnScreen > 1000 && mousePressed) {
                currentGameState = GameState.KIDNEY; 
                gamestarts.play();
              }
            }
            
            textSize(60);
            fill(255);
            text("PRESS TO START", 250, 685);



        }
    }
}
