class HeartIntroduction extends Display {
    PImage background;

    int entryTime = 0;


    HeartIntroduction() {
        this.background = loadImage("heartintro.png");
        this.background.resize(width, height);  
    }

    void draw() {
        if (currentGameState == GameState.HEART_INTRO) {
            background(background);
            fill(255);

            if (entryTime == 0 || (millis() - entryTime) > 100000) {
                entryTime = millis();
            }

            int timeOnScreen = millis() - entryTime;

            // Change the state on key press after 1 second on screen
            if (timeOnScreen > 1000) {
                if (keyPressed && (key == 's' || key == 'S')) {  
                    currentGameState = GameState.HEART; 
                }
            }
        }
    }
}
