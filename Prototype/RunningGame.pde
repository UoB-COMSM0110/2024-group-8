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

    void runGame(PressableButton startRoundButton){
        // Initialise and start the next round if start button presses
        if (mousePressed && startRoundButton.onButton() && (roundCounter < totalRounds)){ selectRound(); }
        
        // Run current round
        if (currentRound != null && currentRound.inProgress()){ currentRound.run(); }
        
        // Move all germs and leak any that have completed the path
        moveAndLeakGerms();

        // Assign winnings for round completion:
        if (currentRound != null && !currentRound.inProgress()){ // If the round has finished and the player hasn't received their winnings yet, give winnings
            if (!currentRound.getReceivedEarnings()){
                earnCoins(currentRound.getEarningsForCompletion());
                currentRound.setReceivedEarnings(true);
            }
        }
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

    void moveAndLeakGerms(){
        // Move germs and store those about to be deleted:
        ArrayList<Germ> germsToLeak = new ArrayList<>(); // THIS IS NECESARRY TO AVOID CONCURRENT MODIFICATION EXCEPTION DO NOT DELETE

        for (Germ germ : AllGerms){
            germ.move();
            if (germ.isLeaked()){
               germsToLeak.add(germ);
               subtractLife(germ);
            }
        }
    
        for (Germ germToLeak : germsToLeak){
            AllGerms.remove(germToLeak);
        }
    }

    void subtractLife(Germ leakedGerm){ 
        // Remove the appropriate amount of lives for each germ
        if (leakedGerm instanceof Germ3){ currentLives = currentLives-3;
        } else if (leakedGerm instanceof Germ2){ currentLives = currentLives-2; 
        } else { currentLives--; }
    }


    /* Helper methods to get current game stats */
    
    Difficulty getGameDifficulty(){ return this.gameDifficulty; }
    
    int getTotalRounds(){ return this.totalRounds; }
    
    int getTotalLives(){ return gameDifficulty.getNumberOfLives(); }

    int getCurrentLives(){ return this.currentLives; }

    int getCoins(){ return this.currentCoins; }

    void spendCoins(int cost){ this.currentCoins = this.currentCoins - cost; }

    void earnCoins(int earnings){ this.currentCoins = this.currentCoins + earnings; }

    int getRoundCounter(){ return this.roundCounter; }

    String getCurrentRoundCounterAsString(){ return String.valueOf(this.roundCounter); }

}
