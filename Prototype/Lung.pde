class Lung extends GameMap {
  PImage germ;
  PImage lung2;
  PImage deadLung;
  float germSize;
  float lung2Size;
  
    Lung(PImage lung) {
        this.background = lung;
        this.germSize = 100;
        this.lung2Size = 100;       
    }

    @Override
    void setup() {
        super.setup(); 
        initalisePath();
        
        try {
            path = loadImage("routeLung.png"); 
            path.resize(WIDTH, HEIGHT); 
        } catch (Exception e) {
            println("Error loading image: " + e.getMessage());
        }
        
        germ = loadImage("germ/germ1R.png");
        lung2 = loadImage("lung.png");
        deadLung = loadImage("deadLung.png");
    }
    

    void twist() {
      //tint(0xffffff);
    }
    
  boolean displayDeadLung = false;
  int deadLungDisplayTime = 1000; 
  int deadLungDisplayStartTime = 0;

  @Override
  void draw(){
    super.draw();
    
    try {
      int previousLives = currentGame.getCurrentLives();
      super.draw();
      image(lung2, 640, 5, lung2Size, lung2Size);
        if (currentGame.getCurrentLives() < previousLives) { 
           lung2Size += 20; 
           displayDeadLung = true; // Set the flag to display deadBrain
           deadLungDisplayStartTime = millis(); 
        }

        if (currentGame.getCurrentLives() < 100) {
          twist();
        }
    
        // Check if it's time to display the deadBrain image
        if (displayDeadLung && millis() - deadLungDisplayStartTime < deadLungDisplayTime) { 
           image(deadLung, 640, 25, lung2Size, lung2Size);////
        }
  
        if (currentRound != null && currentRound.inProgress() && currentRound.getTimeRemainingInSecs()>0){
           germSize += 5; 
           image(germ, -40 , 210 , germSize, germSize);
    
           if (frameCount % 2 == 0) {
               germSize = 100;
           }
        } else {
           image(germ, -40 , 210 , 100, 100);
        }
    
        if (currentGame.getCurrentLives() < previousLives) {
           lung2Size -= 20; 
        }
    
        if (displayDeadLung && millis() - deadLungDisplayStartTime >= deadLungDisplayTime) { 
            displayDeadLung = false;
        }
    } catch (Exception e) {
      System.out.println("Game already won/lost");
    }
  }

    
    
    
    @Override                                      //load new vector for new path
    void initalisePath() {
      Vector[] path = new Vector[]{
        new Vector(0,  5),
        new Vector(3,  5),
        new Vector(3,  8),
        new Vector(1,  8),
        new Vector(1,  11),
        new Vector(9,  11),
        new Vector(9,  8),
        new Vector(6,  8),
        new Vector(6,  3),
        new Vector(10,  3),
        new Vector(10,  5),
        new Vector(11,  5),
        new Vector(11,  10),
        new Vector(14,  10),
        new Vector(14,  8),
        new Vector(17,  8),
        new Vector(17,  5),
        new Vector(13,  5),
        new Vector(13,  0),  
  
      
    };
    mapPath = new Path(path);
  }
}
