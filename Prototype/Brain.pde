class Brain extends GameMap {
  PImage germ;
  PImage brain2;
  PImage deadBrain;
  float germSize = 100;
  float brain2Size = 90;
  double currentProbability = 0;
  boolean strokeFlag = false;
  
  Brain(PImage brain) {
    this.background = brain;
  }

  @Override
  void setup() {
    super.setup(); 
    initalisePath();

    try {
      path = loadImage("routeBrain.png");
      path.resize(WIDTH, HEIGHT);
    } catch (Exception e) {
      println("Error loading image: " + e.getMessage());
    }
    
    germ = loadImage("germ/germ1R.png");
    brain2 = loadImage("brain2.png");
    deadBrain = loadImage("deadBrain.png");
  }
  
  
  boolean displayDeadBrain = false;
  int deadBrainDisplayTime = 1000; // 1000 milliseconds = 1 second
  int deadBrainDisplayStartTime = 0;

  @Override
  void draw(){
    super.draw();
    
    try {
      int previousLives = currentGame.getCurrentLives();
      super.draw();
      image(brain2, 590, 560, brain2Size, brain2Size);
        if (currentGame.getCurrentLives() < previousLives) { 
           brain2Size += 20; 
           displayDeadBrain = true; // Set the flag to display deadBrain
           deadBrainDisplayStartTime = millis(); 
        }
    
        // Check if it's time to display the deadBrain image
        if (displayDeadBrain && millis() - deadBrainDisplayStartTime < deadBrainDisplayTime) { 
           image(deadBrain, 590, 560, brain2Size, brain2Size);
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
           brain2Size -= 20; 
        }
    
        if (displayDeadBrain && millis() - deadBrainDisplayStartTime >= deadBrainDisplayTime) { 
            displayDeadBrain = false;
        }

        //twist
        double probabilityThreshold = 0;
        int livesLost = currentGame.getTotalLives() - currentGame.currentLives;
        currentProbability = Math.min(1.0, probabilityThreshold + 0.05 * livesLost);

        textFont(font);
        textSize(30);
        fill(255);
        text("STROKE RISK: " + String.format("%.1f%%", currentProbability * 100), 690, 110);
        
        if (currentRound != null && currentRound.inProgress() && strokeFlag == true) {
          fill(255, 0, 0); 
          rect(800, 650, 200, 140);
          fill(255);
          textSize(20);
          text("BRAINSTROKE!\nROUNDS\nHAVE BEEN\nSKIPPED!", 837, 682);
        }
    } catch (Exception e) {
      System.out.println("Game already won/lost");
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
