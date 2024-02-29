public class TowerA extends DefenceTower {
  public TowerA(int x, int y, int sprite){
    this. sprite = loadImage("tower/antibody.png");
    this.projectileType = 0;
    this.damageCapability = 1;
    this.cost = 50;
    this.shotsPerSec = 1;
    this.range = 3;
    this.currentUpgradeLevel = 0;
    this.positionX = x;
    this.positionY = y;
    this.spriteIndex = sprite;
  } 
  
  public void shoot(){
    while (germInRange()){
      if (this.projectileType >= Enemy.getRequiredProjectile()){
        Enemy.decreaseHealth(this.damageCapability * this.shotsPerSec);
        Thread.sleep(1000);
      }
    }
  

  public boolean enemyInRange(){
    for (int i = (this.positionX - this.range); i < (this.positionX + this.range); i++){
      for (int j = (this.positionY - this.range); j < (this.positionY + this.range); j++){
        if (GameMap.getCellOwner(i, j) == enemy){
          return true;
        }
      }
    }
    return false;
  }  
}
