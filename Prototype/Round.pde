class Round {
  float durationInSecs;
  float numberOfEnemies;
  float dispatchInterval; // Number of time between enemies to make sure they are dispatched at equal intervals
  boolean roundInProgress; 
  
  int startTime;
  int lastShotTime;
  int lastEnemyDispatch;
  int elapsedTime;

  boolean receivedEarnings = false;
  float earningsForCompletion;

  int roundIndex;
  int enemyIndex = 0;
  ArrayList<Germ> enemiesToDispatch;
  boolean moreEnemiesToDispatch = true;
  
  Round(float duration, float enemyCount, int roundStartTime, float earnings, int index){
    this.durationInSecs = duration;
    this.numberOfEnemies = enemyCount;
    this.dispatchInterval = (duration * 1000) / enemyCount; // Calculate dispatch interval
    this.startTime = roundStartTime;
    this.lastShotTime = 0;
    this.lastEnemyDispatch = 0;
    this.elapsedTime = 0;
    this.roundInProgress = true;
    this.earningsForCompletion = earnings;
    this.roundIndex = index;
    enemiesToDispatch = new ArrayList<>();
    determineEnemiesArray();
  }

  void determineEnemiesArray(){    
    if (roundIndex == 1){ // For the first round add all basic germs
        addGerm1((int)this.numberOfEnemies);
    } else if ((roundIndex/currentGame.getTotalRounds()) < 0.25){ // For the first quarter of rounds add some higher level germs
        addGerm1((int)(this.numberOfEnemies*0.7));
        addGerm2((int)(this.numberOfEnemies*0.3));
    } else if (((roundIndex/currentGame.getTotalRounds()) >= 0.25) && ((roundIndex/currentGame.getTotalRounds()) < 0.5)){ // For the second quarter of rounds add some higher level germs
        addGerm1((int)(this.numberOfEnemies*0.5));
        addGerm2((int)(this.numberOfEnemies*0.4));
        addGerm3((int)(this.numberOfEnemies*0.1));
    } else if (((roundIndex/currentGame.getTotalRounds()) >= 0.5) && ((roundIndex/currentGame.getTotalRounds()) < 0.75)){ // For the third quarter of rounds
        addGerm1((int)(this.numberOfEnemies*0.5));
        addGerm2((int)(this.numberOfEnemies*0.25));
        addGerm3((int)(this.numberOfEnemies*0.25));
    } else { // For the final quarter of rounds (NEED TO ADD if != final round WHEN WE IMPLEMENT FINAL BOSS)
        addGerm1((int)(this.numberOfEnemies*0.5));
        addGerm2((int)(this.numberOfEnemies*0.25));
        addGerm3((int)(this.numberOfEnemies*0.25));
    }
    // else if == final round { add final boss }
  }

  void addGerm1(int count){
    for (int i = 0; i < count ; i++ ){
      enemiesToDispatch.add(new Germ1());
    }
  }

   void addGerm2(int count){
    for (int i = 0; i < count ; i++ ){
      enemiesToDispatch.add(new Germ2());
    }
  }

   void addGerm3(int count){
    for (int i = 0; i < count ; i++ ){
      enemiesToDispatch.add(new Germ3());
    }
  }
  
  float getDurationInSecs(){
    return this.durationInSecs;
  }
  
  float getNumberOfEnemies(){
    return this.numberOfEnemies;
  }

  int getEarningsForCompletion(){
    return (int)this.earningsForCompletion;
  }
  
  boolean inProgress(){
    return this.roundInProgress;
  }
  
  void setInProgress(boolean inProgress){
    this.roundInProgress = inProgress;
  }
  
  boolean getReceivedEarnings(){
    return this.receivedEarnings;
  }
  
  void setReceivedEarnings(boolean received){
    this.receivedEarnings = received;
  }
  
  int getTimeRemainingInSecs(){
    float remainingTime = this.durationInSecs - (this.elapsedTime/1000);
    return (int)(remainingTime);
  }
  
  void run(){
    this.elapsedTime =  millis() - this.startTime; // Initialize elapsed time
     
    for (DefenceTower t : AllTowers){ t.shoot(); }
     
    if (this.moreEnemiesToDispatch){ // While the round duration has not passed 
        if ((millis() - this.lastEnemyDispatch) >= this.dispatchInterval){ // If the time to dispatch is met, dispatch an enemy
          dispatchEnemies();
          this.lastEnemyDispatch = millis();
        }
    } else if (AllGerms.size() <= 0){ // If all enemeies for the round dispatched, but not yet all killed, round should continue
         this.roundInProgress = false;
    }  
  }

  void dispatchEnemies(){
    try { 
      AllGerms.add(enemiesToDispatch.get(enemyIndex));
      enemyIndex++;
    } catch (Exception e) {
      this.moreEnemiesToDispatch = false;
    }
  }
}
