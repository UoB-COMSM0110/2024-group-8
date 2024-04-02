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
      int germIndex = AllGerms.indexOf(target);
      int germLane = target.getLaneIndex();
      if (target instanceof Germ3){ // If its a Germ3 replace it with a Germ2
        Germ newGerm = new Germ2();
        newGerm.setGermPosition(target.getGermX(), target.getGermY());
        newGerm.setDirection(germLane);
        AllGerms.set(germIndex, newGerm);
      } else if (target instanceof Germ2){ // If its a Germ2 replace it with a Germ1
        Germ newGerm = new Germ1();
        newGerm.setGermPosition(target.getGermX(), target.getGermY());
        newGerm.setDirection(germLane);
        AllGerms.set(germIndex, newGerm);
      } else {
        AllGerms.remove(target); // If its a Germ1, it is killed
        targetAlive = false;
      }
    }
    
    boolean shouldDisplay(){
      return (onScreen && targetAlive);
    }

}
