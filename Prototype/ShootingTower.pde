public class ShootingTower extends DefenceTower {
  int lastShotTime;

    public ShootingTower(int x, int y, int sprite, String name){
        super(x, y, name);
        this.spriteIndex = sprite; // For image rendering
        this.lastShotTime = 0;
    }

    public void shoot(){
        float shotInterval = 1000.0f / this.shotsPerSec; // Find the interval at which the tower shoots
        
        Germ target = findTarget();
        if (target != null && ((millis() - this.lastShotTime) >= shotInterval)){ // If there is a valid target and its time to shoot
          // If the tower has the right projectile type to deal damage to it
          if (this.projectileType >= target.getRequiredProjectile()){
            PVector from = new PVector((this.positionX+0.5)*cellSize, (this.positionY+0.5)*cellSize);
            PVector to = new PVector(target.posX+0.5*cellSize, target.posY+0.5*cellSize);
            drawShooting(from, to, 4);
            target.decreaseHealth(this.damageCapability); 
            this.lastShotTime = millis();
        
            if (target.getHealth() <= 0){ // If the germ's health is fully depleted
               killGerm(target);
            }
          }
        }
    }  

    void killGerm(Germ target){
      int germIndex = AllGerms.indexOf(target);
      if (target instanceof Germ3){ // If its a Germ3 replace it with a Germ2
        Germ newGerm = new Germ2();
        newGerm.setGermPosition(target.getGermX(), target.getGermY());
        AllGerms.set(germIndex, newGerm);
      } else if (target instanceof Germ2){ // If its a Germ2 replace it with a Germ1
        Germ newGerm = new Germ1();
        newGerm.setGermPosition(target.getGermX(), target.getGermY());
        AllGerms.set(germIndex, newGerm);
      } else {
        AllGerms.remove(target); // If its a Germ1, it is killed
      }
    }
  
    Germ findTarget(){
       // Target germ = the germ furthest along the path, which is in range   .
       Germ target = null;
    
       for (int x = 0; x < AllGerms.size(); x++){ // Search through each germ, starting with the furthest along the path
           Germ current = AllGerms.get(x);
           
           // Adapt the germ positions to match cell of the array
           int germX = (int)(current.getGermX() / cellSize); 
           int germY = (int)(current.getGermY() / cellSize);
        
           // Calculate the distance between germ and tower
           double ac = Math.abs(germY - this.positionY);
           double cb = Math.abs(germX - this.positionX);
           double distance = Math.sqrt((ac*ac) + (cb*cb)); // Find the distance between the Tower and current germ
        
           if (distance <= this.range){ // If the current germ is within range,
               return current; // It is the tower's target
           }  
      }
      return target;
    }

    void drawShooting(PVector start, PVector end, int depth) {
      // Change the colour and stroke weight depending on the protein type
      if (this.projectileType == 0){ // Light green for basic protein
        strokeWeight(2);
        stroke(#99FF99);
      } else if (this.projectileType == 1){ // Grey for steel protein
        strokeWeight(2);
        stroke(#A0A0A0);
      } else if (this.projectileType == 2){ // Red for flame protein
        strokeWeight(2);
        stroke(#FF0000);
      } else if (this.projectileType == 3){  // Thick blue for diamond protein
        strokeWeight(5);
        stroke(#66FFFF);
      } else {
        strokeWeight(2);
        stroke(253, 208, 35); // Purple color for lightning
      }
      
      line(start.x, start.y, end.x, end.y);
  
      if (depth > 0) {
        PVector mid = PVector.lerp(start, end, 0.5); // Find midpoint
        mid.add(random(-depth, depth), random(-depth, depth)); // Perturb midpoint
        drawShooting(start, mid, depth - 1); // Recursively draw left segment
        drawShooting(mid, end, depth - 1); // Recursively draw right segment
      }
    }
}
