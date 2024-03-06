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
  
  public DefenceTower() {}
  
   public void drawme(){
    image(TowerSprites[spriteIndex], positionX * cellSize, positionY * cellSize, cellSize, cellSize);
   } 
  
  public void upgradeTower(){
    this.currentUpgradeLevel++;
    // GameState.decreaseCoins(properties[0][this.currentUpgradeLevel]); // Will be added once we implement a gameState class
    this.projectileType = properties[1][this.currentUpgradeLevel];
    this.damageCapability = properties[2][this.currentUpgradeLevel];
    this.shotsPerSec = properties[3][this.currentUpgradeLevel];
    this.range = properties[4][this.currentUpgradeLevel];
  }
  
  public abstract void shoot();
}
