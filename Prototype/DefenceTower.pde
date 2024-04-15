public abstract class DefenceTower {
  public int spriteIndex; // Which image
  public int projectileType; // What level if projectile it fires
  public int damageCapability; // How much damage it deals
  public int cost; // Initial cost
  public int shotsPerSec; 
  int mucusPerSec;
  public int range; // Cell distance it can fire to over array
  public int currentUpgradeLevel; 
  public int positionX; // Position on the grid
  public int positionY;
  public int[][] properties; // Stores the tower stats at different upgrade levels
  PImage projectileImage;
  
  //public boolean lastClicked; // This boolean will be used to display tower stats in the game window when it is the las clicked
  public String name;
  
  public DefenceTower(int x, int y, String towerName, int projectile){
    this.positionX = x; // Position on the grid is stored to allow us to calculate which is within range
    this.positionY = y;
    this.name = towerName;
    this.projectileType = projectile;
  }
  
  public void drawTower(){
    image(TowerSprites[spriteIndex], positionX * cellSize, positionY * cellSize, cellSize, cellSize);
  } 
  
  public void upgradeTower(){}
  //  if (this instanceof ShootingTower){
  //    upgradeShooter();
  //  } else {
  //    upgradeDispenser();
  //  }
  //}
  
  //void upgradeTower(){
  //  if (this.currentUpgradeLevel < 3){ // If there are more possible upgrades
  //    if (currentGame.getCoins() >= properties[0][this.currentUpgradeLevel+1]){ // If player can afford the upgrade
  //        int oldProjectile = properties[1][this.currentUpgradeLevel];
  //        this.currentUpgradeLevel++;
  //        currentGame.spendCoins(properties[0][this.currentUpgradeLevel]);
  //        this.projectileType = properties[1][this.currentUpgradeLevel];
  //        this.damageCapability = properties[2][this.currentUpgradeLevel];
  //        this.shotsPerSec = properties[3][this.currentUpgradeLevel];
  //        this.range = properties[4][this.currentUpgradeLevel];
          
  //        if (oldProjectile != properties[1][this.currentUpgradeLevel]){ 
  //           // If its a tower that shoots load the new image for the new projectile
  //           determineProjectileImage();
  //        }
  //    }
  //  } 
  //}
  
  //void upgradeDispenser(){
  //  if (this.currentUpgradeLevel < 3){ // If there are more possible upgrades
  //    if (currentGame.getCoins() >= properties[0][this.currentUpgradeLevel+1]){ // If player can afford the upgrade
  //        this.currentUpgradeLevel++;
  //        currentGame.spendCoins(properties[0][this.currentUpgradeLevel]);
  //        cost = properties[0][this.currentUpgradeLevel];
  //        damageCapability = properties[1][this.currentUpgradeLevel];
  //        shotsPerSec = properties[2][this.currentUpgradeLevel];
  //        mucusPerSec = properties[2][this.currentUpgradeLevel];
  //        range = properties[3][this.currentUpgradeLevel];
  //    }
  //  }  
  //}
  
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
  
  public void shoot(){}
  
  void determineProjectileImage(){
      // Load the correct image for the towers current projectile type
      if (this.projectileType == 1){ // Steel protein
        projectileImage = loadImage("projectile/steel.png");
        projectileImage.resize(25,25);
      } else if (this.projectileType == 2){ // Flame protein
        projectileImage = loadImage("projectile/flame.png");
        projectileImage.resize(35,35);
      } else if (this.projectileType == 3){  // Diamond protein
        projectileImage = loadImage("projectile/diamond.png");
        projectileImage.resize(30,30);
      } else { // Basic protein
        projectileImage = loadImage("projectile/basic.png");
        projectileImage.resize(15,15);
      }
  }
}
