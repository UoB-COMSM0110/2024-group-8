class TowerD extends ShootingTower {
  
  TowerD(int x, int y, int sprite){
    super(x, y, sprite, "Super Antibody", 3);
    
    // Array to hold the properties of an instance of TowerB, throught it's upgrade stages:
        this.properties = new int[][] {
                    { 1000, 500, 750, 1000 }, // Cost from intial to Upgrade 3
                    { 3, 3, 3, 3 }, // Projectile type
                    { 7, 7, 10, 10 }, // Damage Capability
                    { 5, 5, 5, 5 }, // Shots fired per second
                    { 5, 5, 5, 100 }  // Range
                }; 
        assignIntialProperties();
    }
    
    @Override
    String getNextUpgradeAsString(){
      switch (currentUpgradeLevel) {
        case 0: 
             return " WIDER RANGE";
        case 1: 
             return " MORE DAMAGE";
        case 2: 
             return "INFINITE RANGE";
        case 3: 
             return "NO MORE UPGRADES";
        default: 
             return "NO MORE UPGRADES";  
      }
    }

}
   
  
  
  
  
