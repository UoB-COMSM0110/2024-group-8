class ProjectileSprite{
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
  
  ProjectileSprite(String name){
    String path = "projectile/" ;
    up[0] = loadImage(path + "projectile0.png");
    up[1] = loadImage(path + "projectile0.png");
    down[0] = loadImage(path + "projectile0.png");
    down[1] = loadImage(path + "projectile0.png");
    left[0] = loadImage(path + "projectile0.png");
    left[1] = loadImage(path + "projectile0.png");
    right[0] = loadImage(path + "projectile0.png");
    right[1] = loadImage(path + "projectile0.png");
    
  }
}
