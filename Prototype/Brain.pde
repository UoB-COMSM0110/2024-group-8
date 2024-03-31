class Brain extends GameMap {
  PImage germ;
  PImage brain2;
  float germSize = 100;
  float brain2Size = 90;
  
  Brain(PImage brain) {
    this.background = brain;
  }

  @Override
  void setup() {
    super.setup(); 

    try {
      path = loadImage("route3.png");
      path.resize(WIDTH, HEIGHT);
    } catch (Exception e) {
      println("Error loading image: " + e.getMessage());
    }
    
    germ = loadImage("germ/germ1R.png");
    brain2 = loadImage("brain2.png");
  }
  
  @Override
  void draw(){
    super.draw();
  
  
    if (currentRound != null && currentRound.inProgress() && currentRound.getTimeRemainingInSecs()>0){
      germSize += 5; 
      image(germ, -40 , 120 , germSize, germSize);
    
      if (frameCount % 2 == 0) {
        germSize = 100;
      }
    } else {
      image(germ, -40 , 120 , 100, 100);
    }
    
    
    
    image(brain2, 590, 560, brain2Size, brain2Size);
    
    //still working on it //
    int i = currentGame.getCurrentLives();
    if (currentRound != null && currentRound.inProgress()){
      
      if (currentGame.getCurrentLives() != i){
        brain2Size += 5;
        image(brain2, 590, 560, brain2Size, brain2Size);
        if (frameCount % 2 == 0){
        germSize = 100;
        }
       else {
      image(brain2, 590, 560, brain2Size-5, brain2Size-5);
      }
      i = currentGame.getCurrentLives();
      }
    }
    
    
   
  }

  
  @Override
  void initalisePath() {
    Vector[] path = new Vector[]{
      new Vector(0, 3),
      new Vector(8,  3),
      new Vector(8,  1),
      new Vector(12,  1),
      new Vector(12,  3),
      new Vector(13,  3),
      new Vector(13,  6),
      new Vector(10,  6),
      new Vector(10,  4),
      new Vector(9,  4),
      new Vector(9,  8),
      new Vector(12,  8),
      new Vector(12,  12),
    };
    mapPath = new Path(path);
  }
}
