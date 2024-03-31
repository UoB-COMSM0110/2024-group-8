public class ShootingTower extends DefenceTower {

    public ShootingTower(int x, int y, int sprite, String name){
        super(x, y, name);
        this.spriteIndex = sprite; // For image rendering
    }

    public void shoot(){
        Germ target = findTarget();

        // If there is a germ in range and the tower has the right projectile type to deal damage to it
        if (target != null && this.projectileType >= target.getRequiredProjectile()){
            PVector from = new PVector((this.positionX+0.5)*cellSize, (this.positionY+0.5)*cellSize);
            PVector to = new PVector(target.posX+0.5*cellSize, target.posY+0.5*cellSize);
            drawShooting(from, to, 4);
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

    void drawShooting(PVector start, PVector end, int depth) {
      strokeWeight(2);
      stroke(253, 208, 35); // Purple color for lightning
      line(start.x, start.y, end.x, end.y);
  
      if (depth > 0) {
        PVector mid = PVector.lerp(start, end, 0.5); // Find midpoint
        mid.add(random(-depth, depth), random(-depth, depth)); // Perturb midpoint
        drawShooting(start, mid, depth - 1); // Recursively draw left segment
        drawShooting(mid, end, depth - 1); // Recursively draw right segment
      }
    }
}
