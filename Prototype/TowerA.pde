protected class TowerA extends DefenceTower {  
  //public double cb;
  //public double ac;
  
  protected TowerA(int x, int y, int sprite){
     // Array to hold the properties of an instance of TowerA, throught it's upgrade stages:
     this.properties = new int[][] {{ 50, 50, 50, 50 }, // Cost from intial to Upgrade 3
                      { 0, 0, 0, 3 }, // Projectile type
                      { 1, 1, 3, 3 }, // Damage Capability
                      { 1, 1, 1, 3 }, // Shots fired per second
                      { 3, 5, 5, 5 }}; // Range
                      
    this.spriteIndex = sprite; // For image rendering
    this.projectileType = 0; // The type of projectile the tower shoots, e.g., 0 = basic shot 
    this.damageCapability = 1; // How much damage one shot deals
    this.cost = 50;
    this.shotsPerSec = 1; 
    this.range = 3; // The distance across the Grid the tower can shoot to
    this.currentUpgradeLevel = 0; // Determines which column of the upgrades array to access
    this.positionX = x; // Position on the grid is stored to allow us to calculate which is within range
    this.positionY = y;
  } 
  
  public void shoot(){
      Germ target = findTarget();

      // If there is a germ in range and the tower has the right projectile type to deal damage to it
      if (target != null && this.projectileType >= target.getRequiredProjectile()){
        
        // When we introduce projectile visuals this will need to be changed
        // So that a shot is fired at the rate of shotsPerSec/1
        target.decreaseHealth(this.damageCapability * this.shotsPerSec); 
        
        if (target.getHealth() <= 0){ // If the germ's health is fully deleted
          AllGerms.remove(target); // It is killed
        }
      }
  }  
  
  Germ findTarget(){
    // Target germ = the germ furthest along the path, which is in range   .
    
    Germ target = null;
    for (int x = 0; x < AllGerms.size(); x++){ // Search through each germ, starting with the furthest along the path
        Germ current = AllGerms.get(x);
        
        double ac = Math.abs(current.getGermY() - this.positionY);
        double cb = Math.abs(current.getGermX() - this.positionX);
        double distance = Math.sqrt((ac*ac) + (cb*cb)); // Find the distance between the Tower and current germ
        
        if (distance <= this.range){ // If the current germ is within range,
          return current; // It is the tower's target
        }  
      }
      return target;
    }
}
    
