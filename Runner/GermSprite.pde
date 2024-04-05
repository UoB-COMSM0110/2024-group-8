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
    String path = "germ/" + name;
    up[0] = loadImage(path + "L.png");
    up[1] = loadImage(path + "R.png");
    down[0] = loadImage(path + "L.png");
    down[1] = loadImage(path + "R.png");
    left[0] = loadImage(path + "L.png");
    left[1] = loadImage(path + "R.png");
    right[0] = loadImage(path + "L.png");
    right[1] = loadImage(path + "R.png");
    
  }
}
