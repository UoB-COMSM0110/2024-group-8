class RunningGame{
    Difficulty gameDifficulty;
    int currentCoins;
    int currentLives;
    int totalRounds;
    int roundCounter;

    RunningGame(Difficulty difficulty){ // Stores the game stats of current game
        gameDifficulty = difficulty;
        this.totalRounds = gameDifficulty.getNumberOfRounds();
        this.currentLives = gameDifficulty.getNumberOfLives();
        this.currentCoins = gameDifficulty.getNumberOfCoins();
        this.roundCounter = 0;
    }
    
    Difficulty getGameDifficulty(){
      return this.gameDifficulty;
    }
    
    int getTotalRounds(){
        return this.totalRounds;
    }
    
    int getTotalLives(){
      return gameDifficulty.getNumberOfLives();
    }

    int getCurrentLives(){
        return this.currentLives;
    }

    void subtractLife(){
        this.currentLives--;
    }

    int getCoins(){
        return this.currentCoins;
    }

    void spendCoins(int cost){
        this.currentCoins = this.currentCoins - cost;
    }

    void earnCoins(int earnings){
        this.currentCoins = this.currentCoins + earnings;
    }

    void selectRound(){  
        if (currentRound == null || this.roundCounter == 0){
           currentRound = new Round(10, 10, millis(), 100, (roundCounter+1)); // The intial round just set as randomish values for now
           currentRound.setInProgress(true);
           this.roundCounter++;
        } else if (!(currentRound.inProgress())) {
           currentRound = new Round((currentRound.getDurationInSecs()+10), (currentRound.getNumberOfEnemies()*1.5), millis(), (currentRound.getEarningsForCompletion()+(roundCounter*30)), (roundCounter+1)); // Next round slightly harder than last
           currentRound.setInProgress(true);
           this.roundCounter++;
        }
    }

    int getRoundCounter(){
        return this.roundCounter;
    }

    String getCurrentRoundCounterAsString(){
        return String.valueOf(this.roundCounter);
    }

}
