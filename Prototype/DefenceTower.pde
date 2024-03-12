public abstract class DefenceTower {
  public int spriteIndex;
  public int projectileType;
  public int damageCapability;
  public int cost;
  public int shotsPerSec;
  public int range;
  public int currentUpgradeLevel;
  public int positionX;
  public int positionY;
  public int[][] properties;
  
  public boolean lastClicked;
  
  public DefenceTower() {}
  
  public void drawTower(){
    image(TowerSprites[spriteIndex], positionX * cellSize, positionY * cellSize, cellSize, cellSize);
  } 
  
  public void upgradeTower(){
    if (currentGame.getCoins() >= properties[0][this.currentUpgradeLevel]){ // If player can afford the upgrade
       this.currentUpgradeLevel++;
       currentGame.spendCoins(properties[0][this.currentUpgradeLevel]); // Will be added once we implement a gameState class
       this.projectileType = properties[1][this.currentUpgradeLevel];
       this.damageCapability = properties[2][this.currentUpgradeLevel];
       this.shotsPerSec = properties[3][this.currentUpgradeLevel];
       this.range = properties[4][this.currentUpgradeLevel];
    }
  }
  
  public int getCost(){
    return properties[0][this.currentUpgradeLevel];
  }
  
  public abstract void shoot();
}
