public class Projectile {
//   DefenceTower parent;
//   float parentX, parentY;
//   Germ target;
//   float targetX, targetY;

//   float posX, posY;
//   boolean beingFired;
//   int speed = 10;
//   Path projectilePath;

//   public Projectile(DefenceTower parentTower, Germ targetGerm, int projectileSprite){
//     sprite = projectileSprite;

//     parent = parentTower;
//     parentX = parent.getTowerX();
//     parentY = parent.getTowerY();

//     posX = parentX;
//     posY = parentY;

//     target = targetGerm;
//   }

//   public void draw(){
//     if (beingFired){

//     }
//   }

    Runner runner;
    int posX, posY;
    int onLane = 0;
    Direction dir;

    int speed = 3;

    int spriteIndex;
    int anim = 0;
    int animTimer = 0;
    int animDelay = 5;

    void move() {
        PathStatus status = runner.mapPath.checkPos(new Vector(posX, posY), onLane);
        if (status == PathStatus.finished) {
            runner.disappear(this);
            return;
        } else if (status == PathStatus.next) {
            onLane++;
            dir = runner.mapPath.getDire(onLane);
        }

        if (dir == Direction.up) posY -= speed;
        else if (dir == Direction.down) posY += speed;
        else if (dir == Direction.left) posX -= speed;
        else posX += speed;
        runner.image(runner.GermSprites[spriteIndex].getImage(dir, anim), posX, posY, runner.cellSize, runner.cellSize);

        animTimer++;

        if (animTimer > animDelay) {
            animTimer = 0;
            if (anim == 0) anim = 1;
            else anim = 0;
        }

    }

    Projectile(int sprite, Runner runner) {
        this.runner = runner;
        spriteIndex = sprite;
        Vector p = runner.mapPath.getSpawn();
        posX = p.x;

        posY = p.y;
        dir = runner.mapPath.getDire(0);

    }
}
