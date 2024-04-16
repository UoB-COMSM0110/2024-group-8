class FinalBoss extends Germ {
  PImage bossImage;
  Difficulty gameDifficulty;
  
  FinalBoss(int sprite, Difficulty difficulty){
    super(sprite);
    gameDifficulty = difficulty;
    this.requiredProjectile = 3;
    this.health = 100;
    this.normalSpeed = 2;
    this.mucusSpeed = 1;
  }  
}
