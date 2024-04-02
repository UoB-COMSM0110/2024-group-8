class Projectile {
    float posX;
    float posY;
    int speed = 30;
    PImage image;
    int damageCapability;
    Germ target;
    boolean onScreen = true;
    boolean targetAlive = true;

    float targetRadius = 25; // Half of the width/height of the target germ (50/2)

    Projectile(PImage projectileImage, int damage, Germ germ, float startX, float startY){
        this.posX = startX;
        this.posY = startY;
        this.image = projectileImage;
        this.damageCapability = damage;
        this.target = germ;
    }

    void drawShooting(){      
        float germX = target.getGermX() + (cellSize / 2);
        float germY = target.getGermY() + (cellSize / 2);
      
        // Calculate angleand distance between start and end points
        float angle = atan2(germY - posY, germX - posX);
        float distance = dist(posX, posY, germX, germY);

        // Rotate the image to the trajectory of the projectile
        pushMatrix();
        translate(posX, posY);
        rotate(angle); // Rotate based on angle
        imageMode(CENTER);
        image(image, 0, 0, 20, 20);
        imageMode(CORNER); // reset to default so other images aren't messed up
        // Reset transformation
        popMatrix();
        
        if (distance <= targetRadius){ // Check for collision with target
            damageGerm();
            this.onScreen = false;
        } else {
            // Increment posX and posY for the next iteration of this method
            posX += speed * cos(angle); // Increment by speed along x-axis
            posY += speed * sin(angle); // Increment by speed along y-axis
        }
    }

    void damageGerm(){
        target.decreaseHealth(this.damageCapability);
        
        if (target.getHealth() <= 0){ // If the germ's health is fully depleted
            try { 
              killGerm(target);
            } catch (Exception e){
              targetAlive = false;
            }
        }
    }

    void killGerm(Germ target){
      if (target instanceof Germ1){
        AllGerms.remove(target); // If its a Germ1, it is killed
        targetAlive = false;
      } else {
        int germIndex = AllGerms.indexOf(target);
        int germLane = target.getLaneIndex();
        
        Germ newGerm; // Determine what target should be replaced with
        if (target instanceof Germ7) {
            newGerm = new Germ6();
        } else if (target instanceof Germ6) {
            newGerm = new Germ5();
        } else if (target instanceof Germ5) {
            newGerm = new Germ4();
        } else if (target instanceof Germ4) {
            newGerm = new Germ3();
        } else if (target instanceof Germ3) {
            newGerm = new Germ2();
        } else if (target instanceof Germ2) {
            newGerm = new Germ1();
        } else {
            newGerm = new Germ1();
        }
  
        // Set the replacement germs position to the target germs' old position/lane/direction etc.
        newGerm.setGermPosition(target.getGermX(), target.getGermY());
        newGerm.setDirection(germLane);
        // Replace target with the replacement in the germs array
        AllGerms.set(germIndex, newGerm);
      }
    }
    
    boolean shouldDisplay(){
      return (onScreen && targetAlive);
    }

}
