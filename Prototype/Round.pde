class Round {
  float durationInSecs;
  float numberOfEnemies;
  float dispatchInterval; // Number of time between enemies to make sure they are dispatched at equal intervals
  boolean roundInProgress; 
  
  int startTime;
  int lastShotTime;
  int lastEnemyDispatch;
  int elapsedTime;
  
  Round(float duration, float enemyCount, int roundStartTime){
    this.durationInSecs = duration;
    this.numberOfEnemies = enemyCount;
    this.dispatchInterval = (duration * 1000) / enemyCount; // Calculate dispatch interval
    
    this.startTime = roundStartTime;
    this.lastShotTime = 0;
    this.lastEnemyDispatch = 0;
    this.elapsedTime = 0;
    this.roundInProgress = true;
  }
  
  void dispatchEnemies(){
    AllGerms.add(new GermWbc(0));
  }
  
  float getDurationInSecs(){
    return this.durationInSecs;
  }
  
  float getNumberOfEnemies(){
    return this.numberOfEnemies;
  }
  
  boolean inProgress(){
    return this.roundInProgress;
  }
  
  void setInProgress(boolean inProgress){
    this.roundInProgress = inProgress;
  }
  
  int getTimeRemainingInSecs(){
    float remainingTime = this.durationInSecs - (this.elapsedTime/1000);
    return (int)(remainingTime);
  }
  
  void run(){
     this.elapsedTime =  millis() - this.startTime; // Initialize elapsed time
     
     fireShots(); // Shots should be fired even if finished dispatching enemies
     
     if (this.elapsedTime < (this.durationInSecs * 1000)){ // While the round duration has not passed 
     
        if ((millis() - this.lastEnemyDispatch) >= this.dispatchInterval){ // If the time to dispatch is met, dispatch an enemy
          dispatchEnemies();
          this.lastEnemyDispatch = millis();
        }
     } else if (AllGerms.size() <= 0){ // If all enemeies for the round dispatched, but not yet all killed, round should continue
         this.roundInProgress = false;
     }  
  }

  void fireShots(){
   int currentTime = millis(); // Set current time so shoot() is called once every second
   // This will need to be altered when we animate projetiles to something similar to dispatchInterval
   // i.e. for each tower calculate the shotInterval, and fire at that rate
  
   if (currentTime - this.lastShotTime >= 1000){
     for(int i = 0; i < AllTowers.size(); i++){
        AllTowers.get(i).shoot();
      }
      this.lastShotTime = currentTime;
   }
 }   
}
