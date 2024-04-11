class Round {
  float durationInSecs;
  int numberOfEnemies;
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
  
  Round(float duration, int roundStartTime, float earnings, int index){
    this.durationInSecs = duration;
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
  
  float getDurationInSecs(){
    return this.durationInSecs;
  }
  
  int getNumberOfEnemies(){
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
     
    for (DefenceTower t : AllTowers){ 
        t.shoot(); 
    }
    
    for (Projectile p : AllProjectiles){ // Draw all onScreen projectiles
      if (p.shouldDisplay()){ p.drawShooting(); } 
    }
    
    for (Mucus m : AllMucus){
      if (m.onScreen){ m.drawMucus(); }
    }
     
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

  void determineEnemiesArray(){    
    switch (roundIndex) {
      case 1:
          addGerm1(10);
          numberOfEnemies = 10;
          break;
      case 2:
          addGerm1(14);
          addGerm2(1);
          numberOfEnemies = 15;
          break;
      case 3:
          addGerm1(15);
          addGerm2(3);
          numberOfEnemies = 18;
          break;
      case 4:
          addGerm1(15);
          addGerm2(6);
          numberOfEnemies = 21;
          break;
      case 5:
          addGerm1(15);
          addGerm2(7);
          addGerm3(1);
          numberOfEnemies = 23;
          break;
      case 6:
          addGerm1(12);
          addGerm2(10);
          addGerm3(3);
          numberOfEnemies = 25;
          break;
      case 7:
          addGerm1(15);
          addGerm2(10);
          addGerm3(5);
          numberOfEnemies = 30;
          break;
      case 8:
          addGerm1(12);
          addGerm2(15);
          addGerm3(6);
          numberOfEnemies = 32;
          break;
      case 9:
          addGerm1(12);
          addGerm2(15);
          addGerm3(7);
          addGerm4(2);
          numberOfEnemies = 36;
          break;
      case 10:
          // if (currentGame.getTotalRounds() == 10){ 
          //    determineFinalBoss();
          //    numberOfEnemies = 1;
          // } else {
          addGerm1(10);
          addGerm2(15);
          addGerm3(10);
          addGerm4(5);
          numberOfEnemies = 40;
          // }
          break;
      case 11:
          addGerm1(10);
          addGerm2(15);
          addGerm3(13);
          addGerm4(5);
          numberOfEnemies = 43;
          break;
      case 12:
          addGerm1(8);
          addGerm2(20);
          addGerm3(10);
          addGerm4(8);
          numberOfEnemies = 46;
          break;
      case 13:
          addGerm1(5);
          addGerm2(15);
          addGerm3(15);
          addGerm4(10);
          addGerm5(3);
          numberOfEnemies = 48;
          break;
      case 14:
          addGerm1(5);
          addGerm2(15);
          addGerm3(15);
          addGerm4(10);
          addGerm5(5);
          numberOfEnemies = 50;
          break;
      case 15:
          addGerm2(20);
          addGerm3(15);
          addGerm4(10);
          addGerm5(8);
          numberOfEnemies = 53;
          break;
      case 16:
          addGerm2(17);
          addGerm3(15);
          addGerm4(15);
          addGerm5(10);
          numberOfEnemies = 55;
          break;
      case 17:
          addGerm2(10);
          addGerm3(15);
          addGerm4(20);
          addGerm5(10);
          numberOfEnemies = 55;
          break;
      case 18:
          addGerm2(10);
          addGerm3(10);
          addGerm4(20);
          addGerm5(18);
          numberOfEnemies = 58;
          break;
      case 19:
          addGerm2(5);
          addGerm3(15);
          addGerm4(20);
          addGerm5(20);
          numberOfEnemies = 60;
          break;
      case 20:
          // if (currentGame.getTotalRounds() == 20){ // if medium mode end here w/final round boss
          //    determineFinalBoss();
          //    numberOfEnemies = 1;
          // } else {
          addGerm3(10);
          addGerm4(30);
          addGerm5(20);
          addGerm6(3);
          numberOfEnemies = 63;
          // }
          break;
      case 21:
          addGerm3(5);
          addGerm4(30);
          addGerm5(25);
          addGerm6(6);
          numberOfEnemies = 66;
          break;
      case 22:
          addGerm3(5);
          addGerm4(30);
          addGerm5(25);
          addGerm6(10);
          numberOfEnemies = 70;
          break;
      case 23:
          addGerm4(30);
          addGerm5(30);
          addGerm6(13);
          numberOfEnemies = 73;
          break;
      case 24:
          addGerm4(30);
          addGerm5(30);
          addGerm6(13);
          addGerm7(3);
          numberOfEnemies = 76;
          break;
      case 25:
          addGerm4(20);
          addGerm5(30);
          addGerm6(20);
          addGerm7(10);
          numberOfEnemies = 80;
          break;
      case 26:
          addGerm4(15);
          addGerm5(30);
          addGerm6(25);
          addGerm7(13);
          numberOfEnemies = 83;
          break;
      case 27:
          addGerm4(10);
          addGerm5(25);
          addGerm6(30);
          addGerm7(15);
          addGerm8(6);
          numberOfEnemies = 86;
          break;
      case 28:
          addGerm5(30);
          addGerm6(30);
          addGerm7(30);
          addGerm8(10);
          numberOfEnemies = 90;
          break;
      case 29:
          addGerm5(30);
          addGerm6(30);
          addGerm7(30);
          addGerm8(20);
          numberOfEnemies = 100;
          break;
      case 30:
          addGerm5(50);
          addGerm6(50);
          addGerm7(50);
          addGerm8(50);
          numberOfEnemies = 200;
          break;
          // Change for final boss when implemented
          // determineFinalBoss();
          // numberOfEnemies = 1;
    }

    this.dispatchInterval = (durationInSecs * 1000) / numberOfEnemies; // Calculate dispatch interval
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

  void addGerm4(int count){
    for (int i = 0; i < count ; i++ ){
      enemiesToDispatch.add(new Germ4());
    }
  }

  void addGerm5(int count){
    for (int i = 0; i < count ; i++ ){
      enemiesToDispatch.add(new Germ5());
    }
  }

  void addGerm6(int count){
    for (int i = 0; i < count ; i++ ){
      enemiesToDispatch.add(new Germ6());
    }
  }

  void addGerm7(int count){
    for (int i = 0; i < count ; i++ ){
      enemiesToDispatch.add(new Germ7());
    }
  }

  void addGerm8(int count){
    for (int i = 0; i < count ; i++ ){
      enemiesToDispatch.add(new Germ8());
    }
  }
}
