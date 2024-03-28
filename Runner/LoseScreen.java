import processing.core.*;

public class LoseScreen extends Display {
    PImage[] germs;
    PImage[] currentGerms;
    Difficulty completedGameDifficulty;
    int lastGermChangeTime = 0;
    int completedGameRounds;
    int completedGameTotalLives;

    public LoseScreen(Runner runner) {
        super(runner);
    }

    public void setup() {
        germs = new PImage[]{
                runner.loadImage("data/germ/germ1L.png"),
                runner.loadImage("data/germ/germ1R.png"),
                runner.loadImage("data/germ/germ2L.png"),
                runner.loadImage("data/germ/germ2R.png"),
                runner.loadImage("data/germ/germ3L.png"),
                runner.loadImage("data/germ/germ3R.png"),
                runner.loadImage("data/germ/germ5.png"),
        };

        System.out.println("Length of germs array = " + germs.length);

        completedGameDifficulty = runner.currentGame.getGameDifficulty();
        completedGameRounds = runner.currentGame.getTotalRounds(); // Store this values for the game stats window on win screen
        completedGameTotalLives = runner.currentGame.getTotalLives();

        // Reset all the global variables so that its possible to play again:
        runner.currentGame = null;
        runner.currentRound = null;
        runner.difficultySelected = false;

        // Remove all the towers on the grid:
        while (!runner.AllTowers.isEmpty()) {
            runner.AllTowers.remove(0); // Remove the tower at index 0 repeatedly
        }

        // Remove all the germs on the grid:
        while (!runner.AllGerms.isEmpty()) {
            runner.AllGerms.remove(0); // Remove the germ at index 0
        }
    }

    public void draw() {
        runner.background(153, 204, 255);

        int currentTime = runner.millis();

        if (currentGerms == null) {
            currentGerms = new PImage[runner.Grid.length * (runner.Grid[0].length - 1)];
            changeGerm();
        }

        if (currentTime - lastGermChangeTime >= 1500) { // Change colours
            changeGerm();
            lastGermChangeTime = runner.millis();
        }

        fillCellsGerm();

        runner.fill(0x006633);
        runner.textSize(200);
        runner.text("YOU", 250, 300);
        runner.text("LOSE", 230, 500);

        // Game stats window:
        runner.strokeWeight(8);
        runner.strokeJoin(runner.ROUND);
        runner.noFill();
        runner.stroke(0x006633);
        runner.rect(25F, (float) (runner.HEIGHT * 0.85 - 15), 825, 125);
        runner.textSize(30);
        runner.fill(0, 204, 102);
        String difficultyString;
        if (completedGameDifficulty == Difficulty.EASY) {
            difficultyString = "Minor Infection";
        } else if (completedGameDifficulty == Difficulty.MEDIUM) {
            difficultyString = "Pathogen Assault";
        } else if (completedGameDifficulty == Difficulty.HARD) {
            difficultyString = "Biohazard Rampage";
        } else {
            difficultyString = " ";
        } // Will never reach this else, but to silence compiler
        String roundAndMode = "You couldn't protect the body from " + difficultyString;
        runner.text(roundAndMode, 50F, (float) (runner.HEIGHT * 0.9 - 5));


        runner.text("The germs have taken over!", 50F, (float) (runner.HEIGHT * 0.95 - 5));

        // Try again button:
        runner.noFill();
        runner.rect(852F, (float) (runner.HEIGHT * 0.85 - 15), 125, 125);
        runner.text("Try", 875F, (float) (runner.HEIGHT * 0.9 - 5));
        runner.text("again?", 880F, (float) (runner.HEIGHT * 0.95 - 5));
        StateChangingButton tryAgainButton = new StateChangingButton(852, (int) (runner.HEIGHT * 0.85 - 15), 125, 125, GameState.MAP, runner);
        runner.stateChangingButtons.add(tryAgainButton);
    }

    public void fillCellsGerm() {
        int germIndex = 0;

        for (int x = 0; x < runner.Grid.length; x++) {
            for (int y = 0; y < (runner.Grid[0].length - 1); y++) {
                runner.Grid[x][y].outlineSpecificColour(0, 204, 102);
                runner.image(currentGerms[germIndex], x * runner.cellSize, y * runner.cellSize, runner.cellSize, runner.cellSize);
                germIndex++;
            }
        }
    }

    public void changeGerm() {
        for (int i = 0; i < currentGerms.length; i++) {
            int germIndex = (int) runner.random(0, (germs.length - 1));
            currentGerms[i] = germs[germIndex];
            //currentGerms[i].resize(50,50);
        }
    }
}
