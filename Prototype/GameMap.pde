class GameMap{
  /*
     Starting point for the GameMap class
     Still need to:
       - Make unique paths for each map that follow the background image nicely
       - Implement final boss for each map
       - Implement twist for each map
  */
  
  float playWindowHeight = WIDTH * 0.65;
  float cellSize = WIDTH / 20;
  float menuPosY = playWindowHeight + 1;
  float menuHeight = HEIGHT - menuPosY;
  PImage background;
  PImage path;
  PImage pathMask;
  PImage towerA;
  
  void setup(){
    // Initialize grid
    for (int x = 0; x < Grid.length; x++){
       for (int y = 0; y < Grid[0].length; y++){
          Grid[x][y] = new Cell(x, y);
       }
    }
    
    path();
    
    try {
      this.background.resize(WIDTH, HEIGHT);
      path = loadImage("whiteBG.png");
      path.resize(WIDTH, HEIGHT);
      pathMask = loadImage("route.png");
      pathMask.resize(WIDTH, HEIGHT);
      path.mask(pathMask);
      
      towerA = loadImage("tower/antibody.png");
    } catch (Exception e) {
      println("Error loading image: " + e.getMessage());
    }
  }

  void draw() {
    image(background, 0, 0, width, playWindowHeight);
    image(path, 0, 0, width, playWindowHeight);
    
    strokeWeight(8);
    strokeJoin(ROUND);
    noFill();
    stroke(255);
    rect(40, HEIGHT*0.85 - 10, 120, 120);
    
    image(towerA, 50, height*0.85, 100, 100);
    towerAButton = new PressableButton(50, (int)(height*0.85), 100, 100); // PAssing GameState.LUNG regardless of map, not really important as just for button animation
    AllButtons.add(towerAButton);
    
    if (currentRound == null || !currentRound.inProgress()){
      strokeWeight(8);
      strokeJoin(ROUND);
      stroke(255);
      noFill();
      rect(800, (int)(height*0.85), 165, 100);
      startRoundButton = new PressableButton(800, (int)(height*0.85), 165, 100);
      AllButtons.add(startRoundButton);
      fill(255);
      textSize(40);
      text("START", 815, (int)(height*0.90));
      text("ROUND", 805, (int)(height*0.95));
    } else {
      fill(255);
      textSize(40);
      
      String currentRoundIndex = "ROUND  " + String.valueOf(getCurrentRoundCounterAsString());
      text(currentRoundIndex, 780, (int)(height*0.90));
      
      int timeLeft = currentRound.getTimeRemainingInSecs();
      if (timeLeft > 0){
        textSize(20);
        text("Time Remaining:", 800, (int)(height*0.93));
        String timeRemaining = String.valueOf(timeLeft);
        text(timeRemaining, 815, (int)(height*0.96));
        text(" Seconds!", 840, (int)(height*0.96));
      } else {
        textSize(20);
        text("No more germs ...", 800, (int)(height*0.93));
        text("... FOR NOW!", 825, (int)(height*0.96));
      }
    }
      
    for (int i = 0; i < AllTowers.size(); i++){  // Changed length to size()
       AllTowers.get(i).drawme();  // Changed AllToweers to AllTowers
    }
     
    for (int i = 0; i< AllGerms.size(); i++){ 
        AllGerms.get(i).move(); 
    } 
    
    buildTowers();
   
  }
  
  void path(){   
    Vector[] path = new Vector[]{
    new Vector( 0,  5),
    new Vector( 3,  5),
    new Vector( 3,  8),
    new Vector( 1,  8),
    new Vector( 1,  11),
    new Vector( 9,  11),
    new Vector( 9,  8),
    new Vector( 6,  8),
    new Vector( 6,  3),
    new Vector( 10,  3),
    new Vector( 10,  5),
    new Vector( 11,  5),
    new Vector( 11,  10),
    new Vector( 14,  10),
    new Vector( 14,  8),
    new Vector( 17,  8),
    new Vector( 17,  5),
    new Vector( 13,  5),
    new Vector( 13,  0),     
    }; 
    
    mapPath = new Path(path);
    Grid[0][0].setUnbuildable();
    Grid[1][0].setUnbuildable();
    Grid[0][2].setUnbuildable();
    Grid[1][2].setUnbuildable();
    Grid[0][3].setUnbuildable();
  }
  
  void buildTowers(){ 
  /* 
     Functions to select and build towers
     If Hovering over should display tower stats
     If pressed select tower 
  */
    if (towerSelected){
      placeTower();
    }
    
    if (towerAButton.onButton()){
      //fill(255);
      //rect(100, (height*0.85) - 50, 100, 100);
      //noFill();
      //textSize(10);
      //text("[INSERT DESCRIPTION]", 105, height*0.85); // think this should be replaced with if button = last button pressed, it's description is on side bar
      
       if (mousePressed){
          if (currentRound != null){
             if(currentRound.inProgress()){ // Checks whether a round has started or not
                System.out.println("Cannot place towers whilst a round is in progress!");
                return;
             }
          }
          towerSelected = true;
       }
    }
  }
  
  void placeTower(){
    // Animation of moving tower when choosing location
    selectedTower = TowerSprites[0]; // Move to specific tower class eventually when more varieties of tower
    selectedTower.resize(50,50);
    image(selectedTower, mouseX, mouseY);
       
    int currentGridX = (int)(mouseX/cellSize);
    int currentGridY = (int)(mouseY/cellSize);
       
    if (mousePressed && checkBuildable(currentGridX, currentGridY)){
        Grid[currentGridX][currentGridY].buildOn(new TowerA(currentGridX, currentGridY, 0)); 
        towerSelected = false;
    }
  } 
  
  boolean checkBuildable(int x, int y){ // Goes w/build towers function above
    if(x < Grid.length && y < Grid[0].length){
      return Grid[x][y].buildable();
    }
    return false;
  }
}
