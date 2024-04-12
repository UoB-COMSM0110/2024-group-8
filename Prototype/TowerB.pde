protected class TowerB extends ShootingTower { 

    protected TowerB(int x, int y, int sprite){
        super(x, y, sprite, "Steel Defender", 1);

        // Array to hold the properties of an instance of TowerB, throught it's upgrade stages:
        this.properties = new int[][] {
                    { 200, 150, 300, 450 }, // Cost from intial to Upgrade 3
                    { 1, 1, 1, 1 }, // Projectile type
                    { 2, 2, 2, 5 }, // Damage Capability
                    { 3, 3, 5, 5 }, // Shots fired per second
                    { 3, 5, 5, 5 }  // Range
                }; 
        assignIntialProperties();
    }

    @Override
    String getNextUpgradeAsString(){
      switch (currentUpgradeLevel) {
        case 0: 
             return " WIDER RANGE";
        case 1: 
             return " MORE SHOTS";
        case 2: 
             return "MORE DAMAGE";
        case 3: 
             return "NO MORE UPGRADES";
        default: 
             return "NO MORE UPGRADES";  
      }
    }

}
