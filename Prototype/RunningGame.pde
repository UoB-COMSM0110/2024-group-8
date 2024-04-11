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
           currentRound = new Round(30, millis(), 50, (roundCounter+1)); // The intial round just set as randomish values for now
           currentRound.setInProgress(true);
           this.roundCounter++;
        } else if (!(currentRound.inProgress())) {
           currentRound = new Round(30, millis(), (currentRound.getEarningsForCompletion()+(roundCounter*5)), (roundCounter+1)); // Next round slightly harder than last
           currentRound.setInProgress(true);
           this.roundCounter++;
        }
    }

    void moveAndLeakGerms(){
        // Move germs and store those about to be deleted:
        ArrayList<Germ> germsToLeak = new ArrayList<>(); // THIS IS NECESARRY TO AVOID CONCURRENT MODIFICATION EXCEPTION DO NOT DELETE
        ArrayList<Germ> germsToKill = new ArrayList<>();

        for (Germ germ : AllGerms){
            germ.move();
            if (germ.isLeaked()){
               germsToLeak.add(germ);
               subtractLife(germ);
            } else if (germ.isDead){
              germsToKill.add(germ);
            }
        }
    
        for (Germ germToLeak : germsToLeak){
            AllGerms.remove(germToLeak);
        }
        
        for (Germ germToKill : germsToKill){
            killGerm(germToKill);
        }
    }

    void subtractLife(Germ leakedGerm){ 
        // Remove the appropriate amount of lives for each germ
        if (leakedGerm instanceof Germ8){ currentLives = currentLives-8;
        } else if (leakedGerm instanceof Germ7){ currentLives = currentLives-7; 
        } else if (leakedGerm instanceof Germ6){ currentLives = currentLives-6; 
        } else if (leakedGerm instanceof Germ5){ currentLives = currentLives-5; 
        } else if (leakedGerm instanceof Germ4){ currentLives = currentLives-4; 
        } else if (leakedGerm instanceof Germ3){ currentLives = currentLives-3; 
        } else if (leakedGerm instanceof Germ2){ currentLives = currentLives-2; 
        } else { currentLives--; }
    }
    
    void killGerm(Germ target){
      earnCoins(3);
      if (target instanceof Germ1){
        AllGerms.remove(target); // If its a Germ1, it is killed
      } else {
        int germIndex = AllGerms.indexOf(target);
        int germLane = target.getLaneIndex();
        
        Germ newGerm; // Determine what target should be replaced with
        if (target instanceof Germ7) {
            newGerm = new Germ6();
        } else if (target instanceof Germ6) {
            newGerm = new Germ5();
        } else if (target instanceof Germ5) {
            newGerm = new Germ4();
        } else if (target instanceof Germ4) {
            newGerm = new Germ3();
        } else if (target instanceof Germ3) {
            newGerm = new Germ2();
        } else if (target instanceof Germ2) {
            newGerm = new Germ1();
        } else {
            newGerm = new Germ1();
        }
  
        // Set the replacement germs position to the target germs' old position/lane/direction etc.
        newGerm.setGermPosition(target.getGermX(), target.getGermY());
        newGerm.setDirection(germLane);
        // Replace target with the replacement in the germs array
        AllGerms.set(germIndex, newGerm);
      }
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
