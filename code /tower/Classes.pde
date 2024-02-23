class Cell{
  int x;
  int y;
  
  boolean isPath = false;
  
  
  Tower occupant = null;
  
  void buildOn(Tower t){
    if (buildable()){
      occupant = t;
      AllTowers.add(occupant); 
    }
  }
  
  
  boolean buildable(){
    if (occupant == null && !isPath){
      return true;
    } else {
      return false;
    }
  }
  
  void outline(){
    noFill();
    if(buildable())stroke(#00FF00);
    else stroke(#FF0000);
    rect(x * cellSize, y * cellSize, cellSize, cellSize);  
  }
    
  
 Cell(int x, int y){
    this.x = x;
    this.y = y;
  }

}

class Tower {
  int cellX, cellY, spriteIndex, tint;
  
  void drawme(){
    image(TowerSprites[spriteIndex], cellX * cellSize, cellY * cellSize, cellSize, cellSize);
  } 
  
  Tower(int x, int y, int sprite){
    cellX = x;
    cellY = y;
    spriteIndex = sprite;
  }
}  

class Vector{
  int x, y;
  
  Vector(int x, int y){
    this.x = x;
    this.y = y;
  }
  
}

  
class GermSprite{
  PImage[] up = new PImage[2];
  PImage[] down = new PImage[2];
  PImage[] left = new PImage[2];
  PImage[] right = new PImage[2];
  
  PImage getImage (Direction dir, int anim){
    if (dir == Direction.up) return up[anim];
     else if (dir == Direction.down) return down[anim];
     else if (dir == Direction.left) return left[anim];
     else  return right[anim];
    
  }
  
  GermSprite(String name){
    String path = "germ/" ;
    up[0] = loadImage(path + "germ1.png");
    up[1] = loadImage(path + "germ1.png");
    down[0] = loadImage(path + "germ1.png");
    down[1] = loadImage(path + "germ1.png");
    left[0] = loadImage(path + "germ1.png");
    left[1] = loadImage(path + "germ1.png");
    right[0] = loadImage(path + "germ1.png");
    right[1] = loadImage(path + "germ1.png");
    
  }
}

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

class Path{
  Vector[] Pathway;
  Lane[] allLanes;
  Vector spawnPos;
  
  Vector getSpawn(){
    return spawnPos;
  }
  
  Direction getDire(int i){
    if (i < allLanes.length) return allLanes[i].dir;
    else {
     return allLanes[allLanes.length-1].dir;
    }
  }
  
  PathStatus checkPos(Vector v, int lane){
    if (lane >= allLanes.length-1) {
      return PathStatus.finished;
    }
    
    boolean check = allLanes[lane].checkPos(v);
    if (check) return PathStatus.next;
    else return PathStatus.stay;
}

  
  class Lane{
    int endPos;
    Direction dir;
    
    boolean checkPos(Vector v){
      if (dir == Direction.up){
        if (endPos > v.y) return true;
        else return false;
      } else if (dir == Direction.down){
        if (endPos < v.y)return true;
        else return false;
      } else if (dir == Direction.left){
        if (endPos > v.x)return true;
        else return false;
      } else {
        if (endPos < v.x) return true;
        else return false;
      }
    }
    
    Lane(Direction _dir, Vector cell){
      dir = _dir;
      if (_dir == Direction.up || _dir == Direction.down) endPos = round(cellSize * cell.y);
      else endPos = round(cellSize * cell.x);
    }
  }
  
  Path(Vector[] v) {
  Pathway = v;
  Direction[] directions = new Direction[v.length -1];
  spawnPos = new Vector((int)(v[0].x * cellSize), (int)(v[0].y * cellSize));

  for (int i = 0; i < v.length - 1; i++) {
    Grid[v[i].x][v[i].y].isPath = true;

    int difference = v[i].x - v[i + 1].x;
    if (difference  != 0) {//using x
      for (int z = 0; z < abs(difference); z++) {
        if (difference < 0) {
          Grid[v[i].x + z][v[i].y].isPath = true;//path goes right
          directions[i]  = Direction.right;
        } else {
          Grid[v[i].x - z][v[i].y].isPath = true;//path goes left
          directions[i]  = Direction.left;
        }
      }
    }
    else { //using y
      difference = v[i].y - v[i + 1].y;

      for (int z = 0; z < abs(difference); z++) {
        if (difference < 0){
          Grid[v[i].x][v[i].y + z].isPath = true; //path goes down
          directions[i]  = Direction.down;
        } else {
          Grid[v[i].x][v[i].y - z].isPath = true;// path goes up
          directions[i]  = Direction.up;
        }
      }
    }
  }

  if (v.length > 0)Grid[v[v.length - 1].x][v[v.length - 1].y].isPath = true;
  
  allLanes = new Lane[directions.length];
  for(int i = 0; i< allLanes.length; i++) {
    allLanes[i] = new Lane(directions[i], v[i+1]);
  }
}
  
}
