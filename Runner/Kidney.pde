class Kidney extends GameMap {
  PImage germ;
  PImage kidney2;
  PImage deadKidney;
  float germSize = 100;
  float kidney2Size = 90;
    Kidney(PImage kidney) {
        this.background = kidney;
        
    }

    @Override
    void setup() {
        super.setup(); 
        
        try {
            path = loadImage("routeKidney.png");  // Load new path mask image
            path.resize(WIDTH, HEIGHT); 
        } catch (Exception e) {
            println("Error loading image: " + e.getMessage());
        }
        
        germ = loadImage("germ/germ1R.png");
        kidney2 = loadImage("kidney.png");
        deadKidney = loadImage("deadKidney.png");
    }
    
    //@Override
    //void draw(){
    //  super.draw();
    //  try { // Please add implementation of map animation within this to avoid null pointer exception after game is won/lost:)
       
    //  } catch (Exception e) { System.out.println("Game is already won/lost"); }    
    //}
    
    
    boolean displayDeadKidney = false;
    int deadKidneyDisplayTime = 1000;
    int deadKidneyDisplayStartTime = 0;
    
    
    
    @Override
  void draw(){
    super.draw();
    
    try {
      int previousLives = currentGame.getCurrentLives();
      super.draw();
      image(kidney2, 910, 330, kidney2Size, kidney2Size);
        if (currentGame.getCurrentLives() < previousLives) { 
           kidney2Size += 20; 
           displayDeadKidney = true; // Set the flag to display deadBrain
           deadKidneyDisplayStartTime = millis(); 
        }
    
        // Check if it's time to display the deadBrain image
        if (displayDeadKidney && millis() - deadKidneyDisplayStartTime < deadKidneyDisplayTime) { 
           image(deadKidney, 860, 300, kidney2Size+70, kidney2Size+70);
        }
  
        if (currentRound != null && currentRound.inProgress() && currentRound.getTimeRemainingInSecs()>0){
           germSize += 5; 
           image(germ, -40 , 520 , germSize, germSize);
    
           if (frameCount % 2 == 0) {
               germSize = 100;
           }
        } else {
           image(germ, -40 , 520 , 100, 100);
        }
    
        if (currentGame.getCurrentLives() < previousLives) {
           kidney2Size -= 20; 
        }
    
        if (displayDeadKidney && millis() - deadKidneyDisplayStartTime >= deadKidneyDisplayTime) { 
            displayDeadKidney = false;
        }
    } catch (Exception e) {
      System.out.println("Game already won/lost");
    }
  }
    
    
    @Override                                      //load new vector for new path
    void initalisePath() {
      Vector[] path = new Vector[]{
        new Vector(0,  11),
        new Vector(14,  11),
        new Vector(14,  5),
        new Vector(10,  5),
        new Vector(10,  8),
        new Vector(5,  8),
        new Vector(5,  2),
        new Vector(15,  2),
        new Vector(15,  7),
        new Vector(19,  7),
 
  
      
    };
    mapPath = new Path(path);
  }
}
