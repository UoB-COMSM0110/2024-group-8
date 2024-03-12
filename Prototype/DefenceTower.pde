public abstract class DefenceTower {
  public int spriteIndex; // Which image
  public int projectileType; // What level if projectile it fires
  public int damageCapability; // How much damage it deals
  public int cost; // Initial cost
  public int shotsPerSec; 
  public int range; // Cell distance it can fire to over array
  public int currentUpgradeLevel; 
  public int positionX; // Position on the grid
  public int positionY;
  public int[][] properties; // Stores the tower stats at different upgrade levels
  
  public boolean lastClicked; // This boolean will be used to display tower stats in the game window when it is the las clicked
  
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
