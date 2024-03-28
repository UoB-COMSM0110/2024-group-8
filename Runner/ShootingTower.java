public class ShootingTower extends DefenceTower {

    public ShootingTower(int x, int y, int sprite, String name, Runner runner){
        super(x, y, name, runner);
        this.spriteIndex = sprite; // For image rendering
    }

    public void shoot(){
        Germ target = findTarget();

        // If there is a germ in range and the tower has the right projectile type to deal damage to it
        if (target != null && this.projectileType >= target.getRequiredProjectile()){
        
            // When we introduce projectile visuals this will need to be changed
            // So that a shot is fired at the rate of shotsPerSec/1
            target.decreaseHealth(this.damageCapability * this.shotsPerSec); 
        
            if (target.getHealth() <= 0){ // If the germ's health is fully deleted
               runner.AllGerms.remove(target); // It is killed
            }
        }
    }  
  
    Germ findTarget(){
       // Target germ = the germ furthest along the path, which is in range   .
       Germ target = null;
    
       for (int x = 0; x < runner.AllGerms.size(); x++){ // Search through each germ, starting with the furthest along the path
           Germ current = runner.AllGerms.get(x);
        
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
