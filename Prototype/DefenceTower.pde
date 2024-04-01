public abstract class DefenceTower {
  public int spriteIndex; // Which image
  public int projectileType; // What level if projectile it fires
  public int damageCapability; // How much damage it deals
  public int cost; // Initial cost
  public int range; // Cell distance it can fire to over array
  public int currentUpgradeLevel; 
  public int positionX; // Position on the grid
  public int positionY;
  public int[][] properties; // Stores the tower stats at different upgrade levels
  
  //public boolean lastClicked; // This boolean will be used to display tower stats in the game window when it is the las clicked
  public String name;
  
  public DefenceTower(int x, int y, String towerName){
    this.positionX = x; // Position on the grid is stored to allow us to calculate which is within range
    this.positionY = y;
    this.name = towerName;
  }
  
  public void drawTower(){
    image(TowerSprites[spriteIndex], positionX * cellSize, positionY * cellSize, cellSize, cellSize);
  } 
  
  public void upgradeTower(){
    if (this.currentUpgradeLevel < 3){ // If there are more possible upgrades
      if (currentGame.getCoins() >= properties[0][this.currentUpgradeLevel+1]){ // If player can afford the upgrade
          this.currentUpgradeLevel++;
          currentGame.spendCoins(properties[0][this.currentUpgradeLevel]);
          this.projectileType = properties[1][this.currentUpgradeLevel];
          this.damageCapability = properties[2][this.currentUpgradeLevel];
          this.range = properties[3][this.currentUpgradeLevel];
      }
    }
  }
  
  public int getCost(){
    return properties[0][this.currentUpgradeLevel];
  }

  int getTowerX(){
    return this.positionX;
  }

  int getTowerY(){
    return this.positionY;
  }
  
  String getProjectileTypeAsString(){
    switch (this.projectileType) {
      case 0:
           return "BASIC";
      case 1:
           return "STEEL";
      case 2:
           return "FLAME";
      case 3:
           return "DIAMOND";
      default: 
           return "";
    }    
  }
  
  String getNextUpgradeAsString(){
    return String.valueOf(currentUpgradeLevel+1);
  }
  
  int getUpgradeCost(){
    if (this.currentUpgradeLevel < 3){
      return properties[0][this.currentUpgradeLevel+1];
    } else {
      return -1;
    }
  }


  void setTowerX(int x){
    this.positionX = x;
  }

  void setTowerY(int y){
    this.positionY = y;
  }
  
  int getSaleCost(){
    int saleCost = 0;
    for (int i = 0; i <= currentUpgradeLevel; i++){
      saleCost = saleCost + properties[0][i]; // Add up all the coins that have been spent on the tower so far
    }
    saleCost = (int)(saleCost*0.75); // Remove 25% devaluation
    return saleCost;
    
  }
  
  public abstract void shoot();
}
