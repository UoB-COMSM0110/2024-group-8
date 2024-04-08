class Heart extends GameMap {
  PImage germ;
  PImage heart2;
  PImage deadHeart;
  float germSize = 100;
  float heart2Size = 90;
  int bloodViscosity = 5;
  boolean functionCalled95 = false;
  boolean functionCalled70 = false;
  boolean functionCalled50 = false;
  boolean functionCalled20 = false;

  
    Heart(PImage heart) {
        this.background = heart;
        
    }

    @Override
    void setup() {
        super.setup(); 
        
        try {
            path = loadImage("routeHeart.png"); 
            path.resize(WIDTH, HEIGHT); 
        } catch (Exception e) {
            println("Error loading image: " + e.getMessage());
        }
        
        germ = loadImage("germ/germ1R.png");
        heart2 = loadImage("heart.png");
        deadHeart = loadImage("deadHeart.png");
    }
    
    
 
  boolean displayDeadHeart = false;
  int deadHeartDisplayTime = 1000; 
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
    
    
    //twist - if lives decease, germ speed increaseb
    decreaseBloodViscosity();
    textFont(font);
    textSize(30);
    fill(255);
    text("Blood Viscosity: " + bloodViscosity + "cp" ,675, 110);
    
  }

      
    @Override                            
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
  

  void decreaseBloodViscosity(){

    int currentLives = currentGame.getCurrentLives();
    if (currentRound != null && currentRound.inProgress()){
      

    if (currentLives <= 95) {
      if (!functionCalled95) {
          bloodViscosity--;
          increaseGermSpeed();
          functionCalled95 = true;
      }
    } else if (currentLives <= 70) {
      if (!functionCalled70) {
          bloodViscosity--;
          increaseGermSpeed();
          functionCalled70 = true;
      }
  } else if (currentLives <= 50) {
      if (!functionCalled50) {
          bloodViscosity--;
          increaseGermSpeed();
          functionCalled50 = true;
      }
  } else if (currentLives <= 20) {
      if (!functionCalled20) {
          bloodViscosity--;
          increaseGermSpeed();
          functionCalled20 = true;
      }
  }
  }
  
  if (currentRound == null){
    functionCalled95 = false;
    functionCalled70 = false;
    functionCalled50 = false;
    functionCalled20 = false;
  }
    
   
    
  }
  
  void increaseGermSpeed() {
    for (Germ germ : AllGerms) {
        if (germ instanceof Germ1) {
            Germ1 germ1 = (Germ1) germ;
            germ1.speed *= 2; 
        } else if (germ instanceof Germ2) {
            Germ2 germ2 = (Germ2) germ;
            germ2.speed *= 2; 
        } else if (germ instanceof Germ3) {
            Germ3 germ3 = (Germ3) germ;
            germ3.speed *= 2;
        } else if (germ instanceof Germ4) {
            Germ4 germ4 = (Germ4) germ;
            germ4.speed *= 2; 
        } else if (germ instanceof Germ5) {
            Germ5 germ5 = (Germ5) germ;
            germ5.speed *= 2;
        } else if (germ instanceof Germ6) {
            Germ6 germ6 = (Germ6) germ;
            germ6.speed *= 2;
        } else if (germ instanceof Germ7) {
            Germ7 germ7 = (Germ7) germ;
            germ7.speed *= 2;
        } else if (germ instanceof Germ8) {
            Germ8 germ8 = (Germ8) germ;
            germ8.speed *= 2; 
        }
    }
  }



}
