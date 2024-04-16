class Projectile {
    float posX;
    float posY;
    int speed;
    PImage image;
    int damageCapability;
    Germ target;
    boolean onScreen = true;
    boolean targetAlive = true;

    float targetRadius = 25; // Half of the width/height of the target germ (50/2)

    Projectile(PImage projectileImage, int damage, Germ germ, float startX, float startY, int type){
        this.posX = startX;
        this.posY = startY;
        this.image = projectileImage;
        this.damageCapability = damage;
        this.target = germ;
        switch (type) {
          case 0:
              speed = 15;
          case 1:
              speed = 10;
          case 2:
              speed = 20;
          case 3: 
              speed = 30;
          default:
              speed = 20;
        }             
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
        image(image, 0, 0, 25, 25);
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
       try { 
           target.decreaseHealth(this.damageCapability);
       } catch (Exception e){
           targetAlive = false;
       }
    }
    
    boolean shouldDisplay(){
      return (onScreen && targetAlive);
    }

}
