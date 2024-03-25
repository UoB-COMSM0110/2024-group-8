class GameMap{
  /*
     Starting point for the GameMap class
     Still need to:
       - Make unique paths for each map that follow the background image nicely
       - Implement final boss for each map
       - Implement twist for each map
  */
  
  // Resizes the screen so that there is a play window and a menu bar below
  float playWindowHeight = WIDTH * 0.65;
  float cellSize = WIDTH / 20;
  float menuPosY = playWindowHeight + 1;
  float menuHeight = HEIGHT - menuPosY;

  PImage background;
  PImage path;
  PImage pathMask;
  PImage towerA;
  
  PressableButton towerAButton; // Will need to alter tower buying buttons to be more abstract when more towers implemented
  PressableButton startRoundButton;
  
  // Variables for tower buying animation
  boolean towerSelected = false;
  PImage selectedTower;
  int selectedTowerCost = 0;
  
  void setup(){
    // Initialize grid
    for (int x = 0; x < Grid.length; x++){
       for (int y = 0; y < Grid[0].length; y++){
          Grid[x][y] = new Cell(x, y);
       }
    }
    
    initalisePath();
    
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

  void draw(){   
    background(153, 204, 255);
    image(background, 0, 0, width, playWindowHeight);
    image(path, 0, 0, width, playWindowHeight);
    
    
    strokeWeight(8);
    strokeJoin(ROUND);
    noFill();
    stroke(255);
    
    // Tower Buttons:
    rect(40, HEIGHT*0.85 - 10, 70, 70);
    image(towerA, 50, height*0.85, 50, 50);
    towerAButton = new PressableButton(50, (int)(height*0.85), 50, 50); 
    
    String livesCounter = "LIVES: " + String.valueOf(currentGame.getCurrentLives());
    fill(255);
    textSize(30);
    text(livesCounter, 815, 50);
    
    String coinsCounter = "COINS: " + String.valueOf(currentGame.getCoins());
    text(coinsCounter, 805, 80);
  
    if (currentRound == null || !currentRound.inProgress()){
        strokeWeight(8);
        strokeJoin(ROUND);
        stroke(255);
        noFill();
        rect(800, (int)(height*0.85), 165, 100);
        startRoundButton = new PressableButton(800, (int)(height*0.85), 165, 100);
        fill(255);
        textSize(40);
        text("START", 815, (int)(height*0.9));
        text("ROUND", 805, (int)(height*0.95));
    } else {
        fill(255);
        textSize(40);
        text("ROUND", 800, (int)(height*0.85));
        String currentRoundIndex = currentGame.getCurrentRoundCounterAsString() + " / " + String.valueOf(currentGame.getTotalRounds());
        text(currentRoundIndex, 840, (int)(height*0.9));
      
        int timeLeft = currentRound.getTimeRemainingInSecs();
        if (timeLeft > 0){
            textSize(20);
            text("Time Remaining:", 800, (int)(height*0.93));
            String timeRemaining = String.valueOf(timeLeft);
            text(timeRemaining, 815, (int)(height*0.96));
            text(" Seconds!", 840, (int)(height*0.96));
        } else if (timeLeft <= 0 && (AllGerms.size() > 0)){ // If no more enemies to dispense, but still enemies on the grid
            textSize(20);
            text("No more germs ...", 800, (int)(height*0.93));
            text("... FOR NOW!", 825, (int)(height*0.96));
        } 
    }
    
    if (currentRound != null && !currentRound.inProgress()){ // If the round has finished and the player hasn't received their winnings yet, give winnings
       System.out.println("Player should earn: " + currentRound.getEarningsForCompletion());
       System.out.println("PLayer has received earnings = " +currentRound.getReceivedEarnings());
       
        if (!currentRound.getReceivedEarnings()){
            currentGame.earnCoins(currentRound.getEarningsForCompletion());
            currentRound.setReceivedEarnings(true);
         }
    }
      
    for (DefenceTower tower : AllTowers){
      tower.drawTower();
    }

    ArrayList<Germ> germsToLeak = new ArrayList<>();

    for (Germ germ : AllGerms){
      germ.move();
      if (germ.isLeaked()){
        germsToLeak.add(germ);
        currentGame.subtractLife();
      }
    }
    
    for (Germ germToLeak : germsToLeak){
      AllGerms.remove(germToLeak);
    }
   
    buildTowers();

    if (currentRound != null && currentRound.inProgress()){ 
      currentRound.run(); 
    }

    if (currentGame.getRoundCounter() == currentGame.getTotalRounds() && !(currentRound.inProgress()) && AllGerms.size() <= 0){ // If the final round is fully completed
      winScreen.setup();
      currentGameState = GameState.WON;
    }
      
    // If you press start round, and no round is in progress it will start the round 
    if (mousePressed && startRoundButton.onButton() && currentGame.getRoundCounter() < currentGame.getTotalRounds()){ // Change the roundCounter condition for RunningGame.getNumberOfRounds() later on
      currentGame.selectRound();
    }
  }

  
  void initalisePath(){   
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
  
  void buildTowers(){ 
  /* 
     Functions to select and build towers
     If pressed selects tower for placing
  */
  
    if (towerSelected){
      placeTower();
    }
    
    TowerA selectedTower = new TowerA(0,0,0); // Just for now this all needs to be rewritten when we add more towers
    
    if (towerAButton.onButton()){  
       this.selectedTowerCost = selectedTower.getCost(); 
       if (this.selectedTowerCost <= currentGame.getCoins()){ fill(#00FF00); } else { fill(#FF0000); }
       textSize(20);
       text("Cost: " + String.valueOf(this.selectedTowerCost), 100, 710);
       if (mousePressed && this.selectedTowerCost <= currentGame.getCoins()){
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
       
    try {
      if (mousePressed && Grid[currentGridX][currentGridY].buildable()){
        Grid[currentGridX][currentGridY].buildOn(new TowerA(currentGridX, currentGridY, 0)); 
        currentGame.spendCoins(this.selectedTowerCost);
        this.selectedTowerCost = 0;
        towerSelected = false;
      }
    } catch (ArrayIndexOutOfBoundsException e) {
       System.out.println("Can't build there!");
    } 
  }
}
