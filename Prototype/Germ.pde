class Germ {
  int posX, posY;
  int onLane = 0;
  Direction dir;
  protected int health;

  int speed = 1;
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
      leak(this);
      return;
    } else if (status == PathStatus.next){
      onLane++;
      dir = mapPath.getDire(onLane);
    }
    
    if (dir==Direction.up)posY-=speed;
    else if (dir == Direction.down) posY+= speed;
    else if (dir == Direction.left) posX -=speed;
    else posX += speed;
    image(GermSprites[0].getImage(dir, anim),posX, posY, cellSize, cellSize);
    
    animTimer++;
    
    if (animTimer > animDelay){
      animTimer = 0;
      if (anim == 0) anim =1;
      else anim = 0;
    }
  }

  void leak(Germ g){
    AllGerms.remove(g);
    // println("A germ has leaked");
    currentGame.subtractLife();
  }
  
  int getGermX(){
    return (int)(this.posX / cellSize);
  }
  
  int getGermY(){
    return (int)(this.posY / cellSize);
  }

  Germ(int sprite){
    spriteIndex = sprite;
    Vector p = mapPath.getSpawn();
    posX = p.x;
    posY = p.y;
    dir = mapPath.getDire(0);
    health = 1;
  }
}


// Needs to be moved into seperate class and have the correct image
// Need to make more variations, i.e different speeds, health, necessary projectile type to kill etc.
class GermWbc extends Germ{
  
  GermWbc(int sprite){
    super(0);
    this.spriteIndex = sprite;
    Vector p = mapPath.getSpawn();
    this.posX = p.x;
    this.posY = p.y;
    dir = mapPath.getDire(0);
    this.requiredProjectile = 0;
    this.health = 3;
  }
}
