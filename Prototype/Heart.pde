class Heart extends GameMap {
  PImage germ;
  PImage heart2;
  PImage deadHeart;
  float germSize = 100;
  float heart2Size = 90;
  
    Heart(PImage heart) {
        this.background = heart;
        
    }

    @Override
    void setup() {
        super.setup(); 
        
        try {
            path = loadImage("routeHeart.png");  // Load new path mask image
            path.resize(WIDTH, HEIGHT); 
        } catch (Exception e) {
            println("Error loading image: " + e.getMessage());
        }
        
        germ = loadImage("germ/germ1R.png");
        heart2 = loadImage("heart.png");
        deadHeart = loadImage("deadHeart.png");
    }
    
    
 
  boolean displayDeadHeart = false;
  int deadHeartDisplayTime = 1000; // 1000 milliseconds = 1 second
  int deadHeartDisplayStartTime = 0;

  @Override
  void draw(){
    super.draw();
    
    try {
      int previousLives = currentGame.getCurrentLives();
      super.draw();
      image(heart2, 915, 280, heart2Size, heart2Size);
        if (currentGame.getCurrentLives() < previousLives) { 
           heart2Size += 20; 
           displayDeadHeart = true; // Set the flag to display deadBrain
           deadHeartDisplayStartTime = millis(); 
        }
    
        // Check if it's time to display the deadBrain image
        if (displayDeadHeart && millis() - deadHeartDisplayStartTime < deadHeartDisplayTime) { 
           image(deadHeart, 900, 300, heart2Size, heart2Size);
        }
  
        if (currentRound != null && currentRound.inProgress() && currentRound.getTimeRemainingInSecs()>0){
           germSize += 5; 
           image(germ, -40 , 120 , germSize, germSize);
    
           if (frameCount % 2 == 0) {
               germSize = 100;
           }
        } else {
           image(germ, -40 , 120 , 100, 100);
        }
    
        if (currentGame.getCurrentLives() < previousLives) {
           heart2Size -= 20; 
        }
    
        if (displayDeadHeart && millis() - deadHeartDisplayStartTime >= deadHeartDisplayTime) { 
            displayDeadHeart = false;
        }
    } catch (Exception e) {
      System.out.println("Game already won/lost");
    }
  }

      
    @Override                                      //load new vector for new path
    void initalisePath() {
      Vector[] path = new Vector[]{
        new Vector(0, 3),
        new Vector(17,  3),
        new Vector(17,  10),
        new Vector(2,  10),
        new Vector(2,  6),
        new Vector(19,  6),
  
      
    };
    mapPath = new Path(path);
  }
}
