abstract class GameMap{
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
  PImage towerC;
  PImage towerD;
  
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
  int timeOfLastPurchase = 0;

  void setup(){   
    //initalisePath();
    
    try {
      this.background.resize(width, height);
      path = loadImage("whiteBG.png");
      path.resize(width, height);
      towerA = TowerSprites[0];
      towerB = TowerSprites[1];
      towerC = TowerSprites[2];
      towerD = TowerSprites[3];
    } catch (Exception e) {
      println("Error loading image: " + e.getMessage());
    }
  }

  void draw(){   
    background(153, 204, 255);
    image(background, 0, 0, width, playWindowHeight);
    image(path, 0, 0, width, playWindowHeight);
    
    drawGameWindow();
    currentGame.runGame(startRoundButton);
      
    // Draw all towers:
    for (DefenceTower tower : AllTowers){
      tower.drawTower();
    }
   
    // Handle towerPresses for Towerinfo/sale
    if (placingTower){ placeTower(); }

    if (currentGame != null){
      checkGameWonOrLost();
    }
    
    if (currentGameState != GameState.LUNG){
      noTint();
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
       allTowerButtons.add(new TowerButton(10, (int)menuPosY, 70, 70, new TowerA(0,0,0)));

       rect(10, (menuPosY+68), 70, 70);
       image(towerB, 20, (menuPosY+78), 50, 50); 
       allTowerButtons.add(new TowerButton(20, (int)(menuPosY+78), 70, 70, new TowerB(0,0,1)));

       rect(80, menuPosY, 70, 70);
       image(towerC, 90, (menuPosY+10), 50, 50);
       allTowerButtons.add(new TowerButton(80, (int)(menuPosY), 70, 70, new TowerC(0,0,2)));
    
       // Tower D button
       rect(80, (menuPosY+68), 70, 70);
       image(towerD, 90, (menuPosY+78), 50, 50);
       allTowerButtons.add(new TowerButton(80, (int)(menuPosY+78), 70, 70, new TowerD(0,0,3)));
    
    // Tower upgrade instruction message
    fill(0, 128, 255);
    stroke(0, 128, 255);
    rect(0,0,370,40);
        
    fill(255);
    textSize(25);
    text("Click placed towers to upgrade!", 5, 30);
    
    // GameStats:
    textSize(30);
    String livesCounter = "LIVES: " + String.valueOf(currentGame.getCurrentLives());
    text(livesCounter, 815, 50);
    
    String coinsCounter = "COINS: " + String.valueOf(currentGame.getCoins());
    text(coinsCounter, 805, 80);
    
    if (towerSelected){
      selectedTowerImage = TowerSprites[selectedTower.spriteIndex];
      selectedTowerImage.resize(75,75);
      image(selectedTowerImage, 170, (menuPosY+50)); 
      textSize(30);
      text(selectedTower.name, 160, (menuPosY+30));
      displayTowerStats(selectedTower);
      
      if (!placingTower){
        // Buy button
        fill(0, 128, 255);
        stroke(0, 128, 255);
        rect(615, (menuPosY+30), 180, 75);
        PressableButton buyButton = new PressableButton(620, (int)(menuPosY+30), 170, 75);
        fill(255);
        textSize(30);
        text("BUY", 680, (menuPosY+60));
        if (selectedTower.getCost() <= currentGame.getCoins()){ fill(#00FF00); } else { fill(#FF0000); }
        text("Cost: " + selectedTower.getCost(), 630, (menuPosY+90));  
        if (mousePressed && buyButton.onButton() && (selectedTower.getCost() <= currentGame.getCoins())){ 
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
      text("<--- Select a tower to buy", 170, (menuPosY+50));
      text("Click to start the next round --->", 300, (menuPosY+100));
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
       
       displayTowerStats(lastClickedTower);
       
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
  
  void displayTowerStats(DefenceTower t){     
      textSize(20);
      if (t instanceof TowerA){
        text("Shoots " + t.getProjectileTypeAsString() + " proteins at a rate of " +t.shotsPerSec +"/s", 250, (menuPosY+55));
        text("Upgrades:", 250 , (menuPosY+80));
        textSize(20);
        text("> Wider Range  > More Damage ", 250, (menuPosY+105));
        text("> Flame Protein", 250, (menuPosY+125));
      } else if (t instanceof TowerB){
        text("Shoots " + t.getProjectileTypeAsString() + " proteins at a rate of " +t.shotsPerSec +"/s", 250, (menuPosY+55));
        text("Upgrades:", 250 , (menuPosY+80));
        textSize(20);
        text("> Wider Range  > More Shots ", 250, (menuPosY+105));
        text("> More Damage", 250, (menuPosY+125));
      } else if (t instanceof TowerC){
        text("Dispenses mucus to slow down germs", 250, (menuPosY+55));
        text("Upgrades:", 250 , (menuPosY+80));
        textSize(20);
        text("> Wider Range  > More Mucus ", 250, (menuPosY+105));
        text("> Toxic Mucus", 250, (menuPosY+125));
      } else {
        text("Shoots " + t.getProjectileTypeAsString() + " proteins at a rate of " +t.shotsPerSec +"/s", 250, (menuPosY+55));
        text("Upgrades:", 250 , (menuPosY+80));
        textSize(20);
        text("> Wider Range  > More Damage ", 250, (menuPosY+105));
        text("> Infinite Range", 250, (menuPosY+125));
      } 
  }

  void initalisePath(){}

  void placeTower(){   
    // Animation of moving tower when choosing location
    float towerRange = ((selectedTower.range * cellSize) * 2) + cellSize; // twice the cell range + cellSize to account for the cell the tower lives in and then everything its range away
    imageMode(CENTER);
    image(selectedTowerImage, mouseX, mouseY);
    imageMode(CORNER); // Set back to corner because all other images are rendered in line w/CORNER mode
    noFill();
    strokeWeight(4);
    stroke(255);
    circle(mouseX, mouseY, towerRange); // Draw a circle to respresent the range of the tower before placing
       
    int currentGridX = (int)(mouseX/cellSize);
    int currentGridY = (int)(mouseY/cellSize);
       
    try {
      if (mousePressed && Grid[currentGridX][currentGridY].buildable()){
        selectedTower.setTowerX(currentGridX);
        selectedTower.setTowerY(currentGridY);
        if (Grid[currentGridX][currentGridY].buildOn(selectedTower)){ // Only spend coins if tower is successfully built
          currentGame.spendCoins(selectedTower.getCost());
        }
        towerSelected = false;
        placingTower = false;
      }
    } catch (ArrayIndexOutOfBoundsException e) {} // Necessary to handle pressing off grid when tower selected
  }
  
  void checkGameWonOrLost(){
    // Navigate to LOSE screen if necessary
    if (currentGame.getCurrentLives() <= 0){
        loseScreen.setup();
        currentGameState = GameState.LOST;
    }

    // Navigate to WIN screen if necessary
    if (currentGame != null && currentGame.getRoundCounter() == currentGame.getTotalRounds() && !(currentRound.inProgress()) && AllGerms.size() <= 0){ // If the final round is fully completed
        winScreen.setup();
        currentGameState = GameState.WON;
    }
  }

  void setSelectedTower(DefenceTower t, boolean selection){
    selectedTower = t;
    towerSelected = selection;
  }

  void setLastClickedTower(DefenceTower t){
    lastClickedTower = t;
  }
}
