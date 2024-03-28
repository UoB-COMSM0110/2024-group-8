import processing.core.*;

public class DifficultySelection extends Display {
    PImage background;
    PImage easyEmblem;
    PImage mediumEmblem;
    PImage hardEmblem;


    int entryTime = 0; // Implements a halt on button presses to stop auto clicking a difficulty based on where you just pressed a map button

    GameState currentMap;

    DifficultySelection(GameState gameMapOrgan, Runner runner) {
        super(runner);
        this.background = runner.loadImage("data/startpage.png");
        this.background.resize(runner.WIDTH, runner.HEIGHT);
        this.currentMap = gameMapOrgan;
    }

    public void draw() {
        // sets the entry time for the first entrance to difficulty selection screen
        if ((this.entryTime == 0) || (runner.millis() - entryTime) > 1000000) {  // If first entry, or entry to difficulty selection after a different game
            entryTime = runner.millis();
        }

        runner.background(background);

        this.easyEmblem = runner.loadImage("data/easyEmblem.png");
        this.mediumEmblem = runner.loadImage("data/mediumEmblem.png");
        this.hardEmblem = runner.loadImage("data/hardEmblem.png");

        int imageSize = 250;
        int outlineSize = imageSize + 20;

        runner.strokeWeight(8);
        runner.strokeJoin(runner.ROUND);
        runner.stroke(255);
        runner.fill(153, 204, 255);
        runner.rect(80, 80, 840, 640);

        runner.fill(255);
        runner.textSize(40);
        runner.text("Choose a difficulty:", 110, 140);

        runner.textSize(70);
        runner.fill(0x306E80);
        runner.text("MINOR", 260, 230);
        runner.text("INFECTION", 200, 290);

        runner.fill(0x356920);
        runner.text("PATHOGEN", 400, 420);
        runner.text("ASSAULT", 430, 480);

        runner.fill(0x94221F);
        runner.text("BIOHAZARD", 180, 610);
        runner.text("RAMPAGE", 200, 660);

        //runner.stroke(255);
        //runner.noFill();
        //runner.rect(160, 160, 680, 150);
        //runner.rect(160, 350, 680, 150);
        //runner.rect(160, 535, 680, 150); // uncomment if you want to visualise the buttons as

        // Draw and animate the buttons
        handleButton(this.easyEmblem, 630, 120, imageSize, 680, 150);
        handleButton(this.mediumEmblem, 120, 300, imageSize, 680, 150);
        handleButton(this.hardEmblem, 630, 480, imageSize, 680, 150);

        int timeOnScreen = (runner.millis() - this.entryTime);

        if (timeOnScreen > 1000) { // Set the difficulty and start the game
            if (runner.mousePressed) {
                PressableButton easyButton = new PressableButton(160, 160, 680, 150, runner);
                PressableButton mediumButton = new PressableButton(160, 350, 680, 150, runner);
                PressableButton hardButton = new PressableButton(160, 535, 680, 150, runner);

                // New game object is created based on difficulty
                if (easyButton.onButton()) {
                    runner.currentGame = new RunningGame(Difficulty.EASY, runner);
                }
                if (mediumButton.onButton()) {
                    runner.currentGame = new RunningGame(Difficulty.MEDIUM, runner);
                }
                if (hardButton.onButton()) {
                    runner.currentGame = new RunningGame(Difficulty.HARD, runner);
                }

                runner.difficultySelected = true;
                // towerManager = new TowerManager();
                runner.currentGameState = this.currentMap; // Navigates to previously selected map
            }
        }

        //BackButton(backButton, runner.WIDTH/50, runner.HEIGHT/50, 100, GameState.MAP);
    }

    // Function to handle button animation
    void handleButton(PImage emblem, int x, int y, int imageSize, int buttonWidth, int buttonHeight) {
        boolean isButtonHovered = false; // Track if the button is being hovered over

        // Check if mouse is over the button
        if (runner.mouseX >= x && runner.mouseX <= x + buttonWidth &&
                runner.mouseY >= y && runner.mouseY <= y + buttonHeight) {
            isButtonHovered = true;
        }

        // Draw button with animation
        if (isButtonHovered) {
            runner.image(emblem, x - 5, y - 5, imageSize + 10, imageSize + 10); // Scale up slightly
        } else {
            runner.image(emblem, x, y, imageSize, imageSize); // Normal size if not hovered
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
