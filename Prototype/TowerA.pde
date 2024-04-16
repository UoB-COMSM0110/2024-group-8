protected class TowerA extends ShootingTower {  
    
  protected TowerA(int x, int y, int sprite){
    super(x, y, sprite, "Basic Antibody", 0);
    // Array to hold the properties of an instance of TowerA, throught it's upgrade stages:
    this.properties = new int[][] {{ 75, 125, 200, 450 }, // Cost from intial to Upgrade 3
                      { 0, 0, 0, 2 }, // Projectile type
                      { 2, 2, 5, 7 }, // Damage Capability
                      { 1, 1, 1, 3 }, // Shots fired per second
                      { 2, 3, 3, 3 }  // Range
                }; 
      assignIntialProperties();
  } 
  
  @Override
  String getNextUpgradeAsString(){
    switch (currentUpgradeLevel) {
      case 0: 
           return " WIDER RANGE";
      case 1: 
           return "MORE DAMAGE";
      case 2: 
           return "FLAME PROTEIN";
      case 3: 
           return "NO MORE UPGRADES";
      default: 
           return "NO MORE UPGRADES";  
    }
  }
}
    
    
