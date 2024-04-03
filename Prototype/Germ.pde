class Germ {
  int posX, posY;
  int onLane = 0;
  Direction dir;
  protected int health;

  int speed;
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
  }
  
  int getHealth(){
    return this.health; 
  }
  
  void move(){
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
    image(GermSprites[spriteIndex].getImage(dir, anim),posX, posY, cellSize, cellSize);
    
    animTimer++;
    
    if (animTimer > animDelay){
      animTimer = 0;
      if (anim == 0) anim =1;
      else anim = 0;
    }
  }
  
  boolean isLeaked(){
    PathStatus status = mapPath.checkPos(new Vector(posX, posY), onLane);
    return (status == PathStatus.finished);
  }

  // Logic moved to RunningGame class :)
  // void leak(Germ g){
  //   AllGerms.remove(g);
  //   // println("A germ has leaked");
  //   currentGame.subtractLife();
  // }
  
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
    this.speed = 6;
  }
}

class Germ2 extends Germ {
  Germ2(){
    super(1);
    this.requiredProjectile = 0;
    this.health = 5;
    this.speed = 9;
  }
}

class Germ3 extends Germ {
  Germ3(){
    super(2);
    this.requiredProjectile = 1;
    this.health = 10;
    this.speed = 9;
  }
}

class Germ4 extends Germ {
  Germ4(){
    super(3);
    this.requiredProjectile = 1;
    this.health = 12;
    this.speed = 12;
  }
}

class Germ5 extends Germ {
  Germ5(){
    super(4);
    this.requiredProjectile = 1;
    this.health = 15;
    this.speed = 15;
  }
}

class Germ6 extends Germ {
  Germ6(){
    super(5);
    this.requiredProjectile = 2;
    this.health = 20;
    this.speed = 9;
  }
}

class Germ7 extends Germ {
  Germ7(){
    super(6);
    this.requiredProjectile = 2;
    this.health = 30;
    this.speed = 6;
  }
}

class Germ8 extends Germ {
  Germ8(){
    super(7);
    this.requiredProjectile = 3;
    this.health = 25;
    this.speed = 12;
  }
}
