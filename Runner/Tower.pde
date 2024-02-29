public class Tower {
  int cellX, cellY, spriteIndex, tint;
  
  void drawme(){
    image(TowerSprites[spriteIndex], cellX * cellSize, cellY * cellSize, cellSize, cellSize);
  } 
  
  //default constructor
  Tower(){
    cellX = 0;
    cellY = 0;
    spriteIndex = 0;
  }
  
  Tower(int x, int y, int sprite){
    cellX = x;
    cellY = y;
    spriteIndex = sprite;
  }
  
  public int currentUpgradeLevel = 0;
  public int projectileType;
  public int damageCapability;
  public int cost;
  public int shotsPerSec;
  public int range;
  
  public void shoot(){
    
  };
} 
