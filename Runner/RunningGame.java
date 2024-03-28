public class RunningGame {
    Runner runner;
    Difficulty gameDifficulty;
    int currentCoins;
    int currentLives;
    int totalRounds;
    int roundCounter;

    RunningGame(Difficulty difficulty, Runner runner) { // Stores the game stats of current game
        this.runner = runner;
        gameDifficulty = difficulty;

        this.totalRounds = gameDifficulty.getNumberOfRounds();
        this.currentLives = gameDifficulty.getNumberOfLives();
        this.currentCoins = gameDifficulty.getNumberOfCoins();
        this.roundCounter = 0;
    }

    Difficulty getGameDifficulty() {
        return this.gameDifficulty;
    }

    int getTotalRounds() {
        return this.totalRounds;
    }

    int getTotalLives() {
        return gameDifficulty.getNumberOfLives();
    }

    int getCurrentLives() {
        return this.currentLives;
    }

    void subtractLife() {
        this.currentLives--;
    }

    int getCoins() {
        return this.currentCoins;
    }

    void spendCoins(int cost) {
        this.currentCoins = this.currentCoins - cost;
    }

    void earnCoins(int earnings) {
        this.currentCoins = this.currentCoins + earnings;
    }

    void selectRound() {
        /* 
           Method to select the round
           Either set as initial round, or increases difficultly from previous round
           Need to adapt formula for increasing difficulty
           Once we've implemented different kinds of germs needs to be adapted 
           Different quantities of different enemies, etc.
        */

        if (runner.currentRound == null || this.roundCounter == 0) {
            runner.currentRound = new Round(10, 10, runner.millis(), 100, runner); // The initial round just set as random-ish values for now
            runner.currentRound.setInProgress(true);
            this.roundCounter++;
        } else if (!(runner.currentRound.inProgress())) {
            runner.currentRound = new Round(runner.currentRound.getDurationInSecs(), (float) (runner.currentRound.getNumberOfEnemies() * 1.5), runner.millis(), (float) (runner.currentRound.getEarningsForCompletion() * 1.25), runner); // Next round slightly harder than last
            runner.currentRound.setInProgress(true);
            this.roundCounter++;
        }
    }

    int getRoundCounter() {
        return this.roundCounter;
    }

    String getCurrentRoundCounterAsString() {
        return String.valueOf(this.roundCounter);
    }

}
