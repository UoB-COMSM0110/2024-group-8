class Germ {
  int posX, posY;
  int onLane = 0;
  Direction dir;
  
  int speed = 1;
  
  int spriteIndex;
  int anim = 0;
  int animTimer = 0;
  int animDelay = 5;
  
  void move(){
    PathStatus status = Level.checkPos(new Vector(posX, posY), onLane);
    if (status == PathStatus.finished){
      leak(this);
      return;
    } else if (status == PathStatus.next){
      onLane++;
      dir = Level.getDire(onLane);
    }
    
    if (dir==Direction.up)posY-=speed;
    else if (dir == Direction.down) posY+= speed;
    else if (dir == Direction.left) posX -=speed;
    else posX += speed;
    image(GermSprites[spriteIndex].getImage(dir, anim),posX, posY, cellSize, cellSize);
    
    animTimer++;
    
    if (animTimer > animDelay){
      animTimer = 0;
      if (anim == 0) anim =1;
      else anim = 0;
    }
  
  }
  
  Germ(int sprite){
    spriteIndex = sprite;
    Vector p = Level.getSpawn();
    posX = p.x;;
    posY = p.y;
    dir = Level.getDire(0);
    
  }
}
