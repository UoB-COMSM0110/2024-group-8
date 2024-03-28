public class WinScreen extends Display {
    public WinScreen(Runner runner) {
        super(runner);
    }

    int[] confettiColours = {
            0xff6961,
            0xffb480,
            0xf8f38d,
            0x42d6a4,
            0x08cad1,
            0x59adf6,
            0x9d94ff,
            0xc780e8
    };

    int[] currentColours;
    Difficulty completedGameDifficulty;
    int lastColourChangeTime = 0;
    int completedGameRounds;
    int completedGameTotalLives;
    int completedGameLives;

    public void setup() {
        completedGameDifficulty = runner.currentGame.getGameDifficulty();
        completedGameRounds = runner.currentGame.getTotalRounds(); // Store this values for the game stats window on win screen
        completedGameTotalLives = runner.currentGame.getTotalLives();
        completedGameLives = runner.currentGame.getCurrentLives(); // So that you can safely void the runner.currentGame

        // Reset all the global variables so that its possible to play again:
        runner.currentGame = null;
        runner.currentRound = null;
        //  towerManager = null;
        runner.difficultySelected = false;

        // Remove all the towers on the grid:
        while (!runner.AllTowers.isEmpty()) {
            runner.AllTowers.remove(0); // Remove the tower at index 0
        }
    }

    public void draw() {
        runner.background(153, 204, 255);

        int currentTime = runner.millis();

        if (currentColours == null) {
            currentColours = new int[runner.Grid.length * runner.Grid[0].length];
            changeColour();
        }

        if (currentTime - lastColourChangeTime >= 1500) { // Change colours
            changeColour();
            lastColourChangeTime = runner.millis();
        }

        fillCellsColour();

        runner.fill(255);
        runner.textSize(200);
        runner.text("YOU", 250, 300);
        runner.text("WIN!", 300, 500);

        // Game stats window:
        runner.strokeWeight(8);
        runner.strokeJoin(runner.ROUND);
        runner.noFill();
        runner.stroke(currentColours[0]);
        runner.rect(25F, (float) (runner.HEIGHT * 0.85 - 15), 825, 125);
        runner.textSize(30);

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
        String roundAndMode = "WOW! You protected the body from " + difficultyString;
        runner.text(roundAndMode, 50F, (float) (runner.HEIGHT * 0.9 - 5));

        String livesString;
        int livesLost = this.completedGameTotalLives - this.completedGameLives;
        if (livesLost == 0) {
            livesString = "You didn't lose any lives! You absolute Germ Vanquisher!";
        } else if (((double) livesLost / this.completedGameTotalLives) <= 0.25) {
            livesString = "You only lost " + livesLost + " lives! You're an Immune System Hero!";
        } else if ((double) livesLost / this.completedGameTotalLives >= 0.75) {
            livesString = "You lost " + livesLost + " lives! Phew! That was close!";
        } else {
            livesString = "You lost " + livesLost + " lives! You're one reliable defender!";
        }
        runner.text(livesString, 50F, (float) (runner.HEIGHT * 0.95 - 5));

        // Play again button:
        runner.noFill();
        runner.rect(852F, (float) (runner.HEIGHT * 0.85 - 15), 125, 125);
        runner.text("Play", 875F, (float) (runner.HEIGHT * 0.9 - 5));
        runner.text("again?", 880F, (float) (runner.HEIGHT * 0.95 - 5));
        StateChangingButton playAgainButton = new StateChangingButton(852, (int) (runner.HEIGHT * 0.85 - 15), 125, 125, GameState.MAP, runner);
        runner.stateChangingButtons.add(playAgainButton);
    }

    void fillCellsColour() {
        int colourIndex = 0;

        for (int x = 0; x < runner.Grid.length; x++) {
            for (int y = 0; y < (runner.Grid[0].length - 1); y++) {
                int nextIndex = colourIndex + 1; // Makes the outline of cell a different colour
                if (nextIndex == 280) {
                    nextIndex = 0;
                }

                runner.Grid[x][y].confetti(currentColours[colourIndex], currentColours[nextIndex]);
                colourIndex++;
            }
        }
    }

    void changeColour() {
        for (int i = 0; i < currentColours.length; i++) {
            int colourIndex = (int) runner.random(0, confettiColours.length);
            currentColours[i] = confettiColours[colourIndex];
        }
    }
}
