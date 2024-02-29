public class TowerL1 extends Tower {
  public TowerL1(){
    this.currentUpgradeLevel = 1;
    this.projectileType = currentUpgradeLevel + 1;
    this.damageCapability = currentUpgradeLevel + 1;
    this.cost = currentUpgradeLevel * 50;
    this.shotsPerSec = currentUpgradeLevel + 1;
    this.range = currentUpgradeLevel + 1;
  } 
}
