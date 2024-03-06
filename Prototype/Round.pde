class Round {
  float durationInSecs;
  float numberOfEnemies;
  float dispatchInterval; // Number of time between enemies to make sure they are dispatched at equal intervals
  boolean roundInProgress; 
  
  int startTime;
  int lastShotTime;
  int lastEnemyDispatch;
  
  Round(float duration, float enemyCount, int roundStartTime){
    this.durationInSecs = duration;
    this.numberOfEnemies = enemyCount;
    this.dispatchInterval = (duration * 1000) / enemyCount; // Calculate dispatch interval
    
    this.startTime = roundStartTime;
    this.lastShotTime = 0;
    this.lastEnemyDispatch = 0;
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
  
  void run(){
     int elapsedTime =  millis() - this.startTime; // Initialize elapsed time
     
     if (elapsedTime < (this.durationInSecs * 1000)){ // While the round duration has not passed 
        fireShots();
     
        if ((millis() - this.lastEnemyDispatch) >= this.dispatchInterval){ // If the time to dispatch is met, dispatch an enemy
          dispatchEnemies();
          this.lastEnemyDispatch = millis();
        }
     } else {
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
