class Kidney extends GameMap {
  PImage germ;
  PImage kidney2;
  PImage deadKidney;
  float germSize = 100;
  float kidney2Size = 90;
  int temperature = 36;
  boolean calledStage1 = false;
  boolean calledStage2= false;
  boolean calledStage3= false;
  boolean calledStage4= false;
  boolean calledStage5= false;
  
  
    Kidney(PImage kidney) {
        this.background = kidney;
    }

    @Override
    void setup() {
        super.setup(); 
        initalisePath();
        
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
    
    //twist
    increaseNumOfGerm();
    textFont(font);
    textSize(30);
    fill(255);
    text("Temperature: " + temperature + "°C" ,710, 110);
    
    
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
  
  void increaseNumOfGerm(){
    if ( currentRound != null && calledStage1 == false){
      if (currentGame.getCurrentLives() == 99){
        currentRound = new Round(10, 0, 0, 1);
        temperature = 37;
        calledStage1 = true;
        
      }
    }
    if (currentRound != null && calledStage2 == false){
     if (currentGame.getCurrentLives() == 80){
       currentRound = new Round(25, 0, 0, currentRound.roundIndex);
       temperature = 38;
       calledStage2 = true;
     }
    }
    if (currentRound != null && calledStage3 == false){
     if (currentGame.getCurrentLives() == 80){
       currentRound = new Round(25, 0, 0, currentRound.roundIndex);
       temperature = 39;
       calledStage3 = true;
     }
    }
    if (currentRound != null && calledStage4 == false){
     if (currentGame.getCurrentLives() == 80){
       currentRound = new Round(25, 0, 0, currentRound.roundIndex);
       temperature = 40;
       calledStage4 = true;
     }
    }
    if (currentRound != null && calledStage5 == false){
     if (currentGame.getCurrentLives() == 80){
       currentRound = new Round(25, 0, 0, currentRound.roundIndex);
       temperature = 41;
       calledStage2 = true;
     }
    }    
    
    if ( currentRound != null && currentRound.inProgress() && calledStage1 == true ){
      text("TEMPEATURE INCREASED!!!", 710, 500);
      text("EXTRA GERMS ADDED!!!", 720, 550);
    }

    
    if (currentRound != null && !currentRound.inProgress()){
      calledStage1 = false;
      calledStage2 = false;
      calledStage3 = false;
      calledStage4 = false;
      calledStage5 = false;
      
    }
  }
   
}
