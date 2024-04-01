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
  float menuHeight = (HEIGHT - menuPosY) - 10;

  PImage background;
  PImage path;
  PImage pathMask;

  PImage towerA;
  PImage towerB;
  
  PImage lastClickedTowerImage; // Stores whichever tower was last pressed
  DefenceTower lastClickedTower; // So you can see its stats/delete it in gameWindow
  int timeOfLastUpgrade = 0;
  
  PressableButton towerAButton;
  PressableButton towerBButton;
  PressableButton startRoundButton;
  
  // Variables for tower buying animation
  DefenceTower selectedTower;
  boolean towerSelected = false;
  boolean placingTower = false;
  PImage selectedTowerImage;
  int selectedTowerCost = 0;
  int timeOfLastPurchase = 0;
  
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
      //pathMask = loadImage("route.png");
      //pathMask.resize(WIDTH, HEIGHT);
      //path.mask(pathMask);
      
      towerA = TowerSprites[0];
      towerB = TowerSprites[1];
    } catch (Exception e) {
      println("Error loading image: " + e.getMessage());
    }
  }

  void draw(){   
    background(153, 204, 255);
    image(background, 0, 0, width, playWindowHeight);
    image(path, 0, 0, width, playWindowHeight);
    
    drawGameWindow();

    // Assign winnings:
    if (currentRound != null && !currentRound.inProgress()){ // If the round has finished and the player hasn't received their winnings yet, give winnings
        if (!currentRound.getReceivedEarnings()){
            currentGame.earnCoins(currentRound.getEarningsForCompletion());
            currentRound.setReceivedEarnings(true);
        }
    }
      
    // Draw all towers:
    for (DefenceTower tower : AllTowers){
      tower.drawTower();
    }

    // Move germs and store those about to be deleted:
    ArrayList<Germ> germsToLeak = new ArrayList<>(); // THIS IS NECESARRY TO AVOID CONCURRENT MODIFICATION EXCEPTION DO NOT DELETE

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
   
    if (checkForSelectedTower()){ towerSelected = true; }
    if (placingTower){ placeTower(); }
    
    
    // Handle towerPresses for Towerinfo/sale
    checkForPlacedTowerPresses();

    // Run current round
    if (currentRound != null && currentRound.inProgress()){ 
      currentRound.run(); 
    }

    // Navigate to win screen if necessary
    if (currentGame.getRoundCounter() == currentGame.getTotalRounds() && !(currentRound.inProgress()) && AllGerms.size() <= 0){ // If the final round is fully completed
      winScreen.setup();
      currentGameState = GameState.WON;
    }
      
    // If you press start round, and no round is in progress it will start the round 
    if (mousePressed && startRoundButton.onButton() && currentGame.getRoundCounter() < currentGame.getTotalRounds()){ // Change the roundCounter condition for RunningGame.getNumberOfRounds() later on
      currentGame.selectRound();
    }
    
    if (currentGame != null && currentGame.getCurrentLives() <= 0){
      loseScreen.setup();
      currentGameState = GameState.LOST;
    }
  }
  
  void drawGameWindow(){
    // Game Window:
    strokeWeight(8);
    strokeJoin(ROUND);
    stroke(255);
    noFill();
    rect(10, menuPosY, (width - 20), menuHeight);
    
       // Tower Buttons:
       rect(10, menuPosY, 70, 70);
       image(towerA, 20, (menuPosY+10), 50, 50);
       towerAButton = new PressableButton(10, (int)menuPosY, 70, 70); 
    
       rect(10, (menuPosY+68), 70, 70);
       image(towerB, 20, (menuPosY+78), 50, 50);
       towerBButton = new PressableButton(20, (int)(menuPosY+78), 70, 70); 

       rect(80, menuPosY, 70, 70);
       // Tower C button
    
       rect(80, (menuPosY+68), 70, 70);
       // Tower D button
    
    // GameStats:
    String livesCounter = "LIVES: " + String.valueOf(currentGame.getCurrentLives());
    fill(255);
    textSize(30);
    text(livesCounter, 815, 50);
    
    String coinsCounter = "COINS: " + String.valueOf(currentGame.getCoins());
    text(coinsCounter, 805, 80);
    
    if (towerSelected){
      selectedTowerImage = TowerSprites[selectedTower.spriteIndex];
      selectedTowerImage.resize(75,75);
      image(selectedTowerImage, 170, (menuPosY+50)); 
      textSize(30);
      text(selectedTower.name, 160, (menuPosY+30));
      
      noFill();
      stroke(255);
      rect(300, (menuPosY+20), 250, 100);
      //// Tower Stats
      textSize(20);
      text("Range           ->    " + selectedTower.range, 310, (menuPosY+45));
      text("Damage       ->    " + selectedTower.damageCapability, 310, (menuPosY+65));
      text("Shots/sec   ->    " + selectedTower.shotsPerSec, 310, (menuPosY+85));
      text("Protein         ->    " + selectedTower.getProjectileTypeAsString(), 310, (menuPosY+105));
      
      if (!placingTower){
        // Buy button
        fill(0, 128, 255);
        stroke(0, 128, 255);
        rect(620, (menuPosY+30), 170, 75);
        PressableButton buyButton = new PressableButton(620, (int)(menuPosY+30), 170, 75);
        fill(255);
        textSize(30);
        text("BUY", 670, (menuPosY+60));
        if (selectedTower.getCost() <= currentGame.getCoins()){ fill(#00FF00); } else { fill(#FF0000); }
        text("Cost: " + selectedTower.getCost(), 650, (menuPosY+90));  
        if (mousePressed && buyButton.onButton()){ 
          placingTower = true; 
          timeOfLastPurchase = millis();
        }
      } else {
        // Cancel buy button
        fill(0);
        stroke(0);
        rect(620, (menuPosY+30), 170, 75);
        PressableButton cancelBuyButton = new PressableButton(620, (int)(menuPosY+30), 170, 75);
        fill(255);
        textSize(20);
        text("PLACE HERE", 640, (menuPosY+50));
        text("TO CANCEL", 645, (menuPosY+75));  
        text("PURCHASE", 650, (menuPosY+100));
        if (mousePressed && cancelBuyButton.onButton() && ((millis()-timeOfLastPurchase) > 1000)){ // Added a halt to stop autoclicking to cancelling purchase
            placingTower = false; 
            towerSelected = false;
        } 
      }
    
    // Current tower window:
    } else if (lastClickedTower == null){
      textSize(30);
      text("Press a placed tower to see it's stats", 170, (menuPosY+40));
    } else {
       int towerX = (int)(lastClickedTower.getTowerX() * cellSize);
       int towerY = (int)(lastClickedTower.getTowerY() * cellSize);
       float towerRange = ((lastClickedTower.range * cellSize) * 2) + cellSize; // twice the cell range + cellSize to account for the cell the tower lives in and then everything its range away
       noFill();
       stroke(255);
       circle(towerX+(cellSize/2), towerY+(cellSize/2), towerRange); // Draw a circle to respresent the range of the tower before placing
       
       lastClickedTowerImage = TowerSprites[lastClickedTower.spriteIndex];
       lastClickedTowerImage.resize(75,75);
       image(lastClickedTowerImage, 170, (menuPosY+50)); 
       textSize(30);
       text(lastClickedTower.name, 160, (menuPosY+30));
       
       rect(300, (menuPosY+20), 250, 100);
       textSize(20);
       text("Range           ->    " + lastClickedTower.range, 310, (menuPosY+45));
       text("Damage       ->    " + lastClickedTower.damageCapability, 310, (menuPosY+65));
       text("Shots/sec  ->    " + lastClickedTower.shotsPerSec, 310, (menuPosY+85));
       text("Protein         ->    " + lastClickedTower.getProjectileTypeAsString(), 310, (menuPosY+105));
       
       if (lastClickedTower.currentUpgradeLevel < 3){
          // Upgrade info & button
          fill(0, 128, 255);
          stroke(0, 128, 255);
          rect(620, (menuPosY+15), 170, 75);
          PressableButton upgradeButton = new PressableButton(620, (int)(menuPosY+5), 170, 75);
          if (mousePressed && upgradeButton.onButton() && ((millis() - timeOfLastUpgrade) > 2000)){
             lastClickedTower.upgradeTower();
             timeOfLastUpgrade = millis();
          }
       
          fill(255);
          text("UPGRADE", 655, (menuPosY+40));
          text(lastClickedTower.getNextUpgradeAsString(), 630, (menuPosY+60));
          int upgradeCost = lastClickedTower.getUpgradeCost();
          if (upgradeCost <= currentGame.getCoins()){ fill(#00FF00); } else { fill(#FF0000); }
          text("Cost: " + upgradeCost, 665, (menuPosY+80));
       }
       
       // Sell button
       fill(#FF0000);
       stroke(#FF0000);
       strokeWeight(4);
       rect(630, (menuPosY+100), 150, 30);
       PressableButton sellButton = new PressableButton(630, (int)(menuPosY+100), 150, 30);
       fill(255);
       int saleCost = lastClickedTower.getSaleCost();
       text("SELL  ->  $" +saleCost, 645, (menuPosY + 122));
       
       if (mousePressed && sellButton.onButton()){
         AllTowers.remove(lastClickedTower);
         currentGame.earnCoins(saleCost);
         lastClickedTower = null;
       } 
    }
      
    // Start Round/Round stats:
    if (currentRound == null || !currentRound.inProgress()){
        strokeWeight(8);
        strokeJoin(ROUND);
        stroke(255);
        noFill();
        line(810, menuPosY+5, 810, menuPosY+135);
        rect(815, menuPosY+5, 170, 130);
        startRoundButton = new PressableButton(800, (int)menuPosY, 190, 340);
        fill(255);
        textSize(40);
        text("START", 835, (int)(menuPosY + 60));
        text("ROUND", 825, (int)(menuPosY + 110));
    } else {
        fill(255);
        stroke(255);
        line(815, menuPosY+5, 815, menuPosY+135);
        textSize(40);
        text("ROUND", 825, (int)(menuPosY + 40));
        textSize(30);
        String currentRoundIndex = currentGame.getCurrentRoundCounterAsString() + " / " + String.valueOf(currentGame.getTotalRounds());
        text(currentRoundIndex, 865, (int)(menuPosY + 70));
      
        int timeLeft = currentRound.getTimeRemainingInSecs();
        if (timeLeft > 0){
            textSize(20);
            text("Time Remaining:", 830, (int)(menuPosY + 100));
            String timeRemaining = String.valueOf(timeLeft);
            text(timeRemaining, 840, (int)(menuPosY + 125));
            text(" Seconds!", 870, (int)(menuPosY + 125));
        } else if (timeLeft <= 0 && (AllGerms.size() > 0)){ // If no more enemies to dispense, but still enemies on the grid
            textSize(20);
            text("No more germs ...", 825, (int)(menuPosY + 100));
            text("... FOR NOW!", 850, (int)(menuPosY + 125));
        } 
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

  public boolean checkForSelectedTower(){
    if (mousePressed && towerAButton.onButton()){  
        selectedTower = new TowerA(0,0,0);
        return true;
    }

    if (mousePressed && towerBButton.onButton()){  
        selectedTower = new TowerB(0,0,1);
        return true;
    }
    return false;
  }
  
  void placeTower(){   
    // Animation of moving tower when choosing location
    float towerRange = ((selectedTower.range * cellSize) * 2) + cellSize; // twice the cell range + cellSize to account for the cell the tower lives in and then everything its range away
    imageMode(CENTER);
    image(selectedTowerImage, mouseX, mouseY);
    imageMode(CORNER); // Set back to corner because all other images are rendered in line w/CORNER mode
    noFill();
    stroke(255);
    circle(mouseX, mouseY, towerRange); // Draw a circle to respresent the range of the tower before placing
       
    int currentGridX = (int)(mouseX/cellSize);
    int currentGridY = (int)(mouseY/cellSize);
       
    try {
      if (mousePressed && Grid[currentGridX][currentGridY].buildable()){
        selectedTower.setTowerX(currentGridX);
        selectedTower.setTowerY(currentGridY);
        Grid[currentGridX][currentGridY].buildOn(selectedTower); 
        currentGame.spendCoins(selectedTower.getCost());
        this.selectedTowerCost = 0;
        towerSelected = false;
        placingTower = false;
      }
    } catch (ArrayIndexOutOfBoundsException e) { // Necessary to handle pressing off grid when tower selected
       System.out.println("Can't build there!");
    } 
  }
  
  public void checkForPlacedTowerPresses(){
    if (mousePressed){
      int x = (int)(mouseX/cellSize);
      int y = (int)(mouseY/cellSize);
      if (x < Grid.length && y < Grid[0].length){
         for (DefenceTower t : AllTowers){
             if (t.positionX == x && t.positionY == y){
               lastClickedTower = t;
               towerSelected = false;
             } 
         }
      }
    }  
  } 
}
