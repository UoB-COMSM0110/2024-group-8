public class Germ {
  int posX, posY;
  int onLane = 0;
  Direction dir;
  protected int health;

  int speed;
  int normalSpeed;
  int mucusSpeed;
  int timeOfLastMucusHarm = 0;
  public boolean isDead = false;
  
  int spriteIndex;
  int anim = 0;
  int animTimer = 0;
  int animDelay = 5;

  protected int requiredProjectile;
  
  int getRequiredProjectile(){
    return this.requiredProjectile;
  }
  
  void decreaseHealth(int amount){
    this.health = this.health - amount;
    
    if (this.health <= 0){ // If the germ's health is fully depleted
        isDead = true;
        deathsound.play();
    }
  }
  
  int getHealth(){
    return this.health; 
  }
  
  void move(){
    checkForMucus();
    
    PathStatus status = mapPath.checkPos(new Vector(posX, posY), onLane);
    if (status == PathStatus.finished){
      return; // Skip over germs which have finished moving
    } else if (status == PathStatus.next){
      onLane++;
      dir = mapPath.getDire(onLane);
    }
    
    if (dir==Direction.up){ posY-=speed; }
    else if (dir == Direction.down){ posY+= speed; }
    else if (dir == Direction.left){ posX -=speed; }
    else { posX += speed; }
    
    if (this instanceof FinalBoss){
      imageMode(CENTER);
      image(GermSprites[spriteIndex].getImage(dir, anim), posX + 25, posY + 25, cellSize*3, cellSize*3);
      imageMode(CORNER);
    
    } else {
      image(GermSprites[spriteIndex].getImage(dir, anim),posX, posY, cellSize, cellSize);
    }
    
    animTimer++;
    
    if (animTimer > animDelay){
      animTimer = 0;
      if (anim == 0) anim =1;
      else anim = 0;
    }
  }
  
  void checkForMucus(){
    int gridX = (int)(posX/cellSize);
    int gridY = (int)(posY/cellSize);
    if (Grid[gridX][gridY].containsMucus){ // If the current cell the germ is in contains mucus, slow down its speed
      this.speed = this.mucusSpeed;
      if ((Grid[gridX][gridY].containsToxicMucus) && (millis() - timeOfLastMucusHarm) >= 1000){ // If the mucus is toxic deal damage to the germ
        decreaseHealth(3);
        timeOfLastMucusHarm = millis(); 
      }
    } else {
      this.speed = this.normalSpeed;
    }    
  }
  
  boolean isLeaked(){
    PathStatus status = mapPath.checkPos(new Vector(posX, posY), onLane);
    return (status == PathStatus.finished);
  }
  
  int getGermX(){
    return this.posX;
  }
  
  int getGermY(){
    return this.posY;
  }
  
  int getLaneIndex(){
    return this.onLane;
  }
  
  void setDirection(int newLaneIndex){
    this.onLane = newLaneIndex;
    this.dir = mapPath.getDire(onLane);
  }
    
  void setGermPosition(int x, int y){
    this.posX = x;
    this.posY = y;
  }

  Germ(int sprite){
    spriteIndex = sprite;
    Vector p = mapPath.getSpawn();
    posX = p.x;
    posY = p.y;
    dir = mapPath.getDire(0);
  }
}

class Germ1 extends Germ {
  Germ1(){
    super(0);
    this.requiredProjectile = 0;
    this.health = 3;
    this.normalSpeed = 3;
    this.mucusSpeed = 1;
  }
}

class Germ2 extends Germ {
  Germ2(){
    super(1);
    this.requiredProjectile = 0;
    this.health = 5;
    this.normalSpeed = 5;
    this.mucusSpeed = 2;
  }
}

class Germ3 extends Germ {
  Germ3(){
    super(2);
    this.requiredProjectile = 1;
    this.health = 10;
    this.normalSpeed = 7;
    this.mucusSpeed = 3;
  }
}

class Germ4 extends Germ {
  Germ4(){
    super(3);
    this.requiredProjectile = 1;
    this.health = 12;
    this.normalSpeed = 10;
    this.mucusSpeed = 5;
  }
}

class Germ5 extends Germ {
  Germ5(){
    super(4);
    this.requiredProjectile = 1;
    this.health = 15;
    this.normalSpeed = 12;
    this.mucusSpeed = 6;
  }
}

class Germ6 extends Germ {
  Germ6(){
    super(5);
    this.requiredProjectile = 2;
    this.health = 20;
    this.normalSpeed = 6;
    this.mucusSpeed = 3;
  }
}

class Germ7 extends Germ {
  Germ7(){
    super(6);
    this.requiredProjectile = 2;
    this.health = 30;
    this.normalSpeed = 3;
    this.mucusSpeed = 1;
  }
}

class Germ8 extends Germ {
  Germ8(){
    super(7);
    this.requiredProjectile = 3;
    this.health = 25;
    this.normalSpeed = 9;
    this.mucusSpeed = 4;
  }
}
