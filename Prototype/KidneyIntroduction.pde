class KidneyIntroduction extends Display {
    PImage background;
   // PImage brainintro;

    int entryTime = 0;
    boolean buttonPressed = false; // Track whether the button has been pressed

    KidneyIntroduction() {
        this.background = loadImage("kidneyintro.png");
        this.background.resize(width, height);  // Ensure 'width' and 'height' are defined or accessible
       // this.brainintro = loadImage("brainintroo.png");
       // this.brainintro.resize(700, 700);
    }

    void draw() {
        // Check for game state in the main game loop, not here, unless this is a method call
        if (currentGameState == GameState.KIDNEY_INTRO) {
            background(background);
           // image(brainintro, 120, 40);
            fill(255);

            // Manage the introduction timing
            if (entryTime == 0 || (millis() - entryTime) > 100000) {
                entryTime = millis();
            }

            int timeOnScreen = millis() - entryTime;

            // Change the state on key press after 1 second on screen
            if (timeOnScreen > 1000) {
                if (keyPressed && (key == 's' || key == 'S')) {  // Parentheses added for clarity
                    currentGameState = GameState.KIDNEY;  // Ensure this state change is handled appropriately in your game loop
                }
            }
        }
    }
}
