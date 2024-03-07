int WIDTH = 1000;
int HEIGHT = (int)(WIDTH * 0.8);
float cellSize = WIDTH / 20;

Cell[][] Grid = new Cell[20][13];        //depends on the map

PImage[] TowerSprites;
GermSprite[] GermSprites;

PImage path;
PImage pathMask;
PImage startPageBackground;
PImage germ;
PImage brain;
PImage heart;
PImage kidney;
PImage lung;
int imageSize = 200;

PFont font;

Brain brainMap;
Lung lungMap;
Heart heartMap;
Kidney kidneyMap;

enum GameState { // Different phases of the game, so program knows what to draw
    TITLE,
    MAP,
    WON,
    // RULES, // Will be the "How to play" screen, can be navigated to at anytime before gameMap selected?
    // DIFFICULTY, // Will be difficulty selction page when implemented
    BRAIN,
    LUNG,
    HEART,
    KIDNEY; 
    
    public boolean isGameMap(){ // Creates a distinct gamestate class for button animations
      return this == BRAIN || this == LUNG || this == HEART || this == KIDNEY;
    }
}

GameState gameState;

// Define variables for the germ cursor character
float germX;
float germY;

Cell hoverCell = null; // Refers to whatever cell the mouse is hovering over

// Path variable
Path mapPath; // Pathway followed by germs
Round currentRound; // Stores current round object


// Buttons on the gameMap, need to be moved into gameMap class
PressableButton towerAButton; 
PressableButton startRoundButton;
// Variables for animation of selecting towers in game, also need to be moved into gameMap class
boolean towerSelected = false;
PImage selectedTower;
float selectedTowerX;
float selectedTowerY;

ArrayList<DefenceTower> AllTowers  = new ArrayList<DefenceTower>();
ArrayList<Germ> AllGerms = new ArrayList<Germ>();
ArrayList<Projectile> AllProjectiles = new ArrayList<Projectile>();
ArrayList<PressableButton> AllButtons = new ArrayList<PressableButton>();

color[] confettiColours = {
  #ff6961,
  #ffb480,
  #f8f38d,
  #42d6a4,
  #08cad1,
  #59adf6,
  #9d94ff,
  #c780e8
};

void settings() {
  size(WIDTH, HEIGHT);
}

void setup() { // Loads the different images needs for titleScreen & mapSelection
  // Also sets up the germ cursor for the entry screens
  fill(0);
  textSize(40);
  
  font = createFont("Papyrus", 30);
  
  gameState = GameState.TITLE;
  
  startPageBackground = loadImage("startpage.png");
  startPageBackground.resize(WIDTH, HEIGHT); // Resize the image to match window dimensions
  
  // Load germ image
  germ = loadImage("germ.png");
  germ.resize(20, 20);
  // Set initial position for the germ character
  germX = width / 2;
  germY = height / 2;
  
  // Load map images and resize them to the same size
  brain = loadImage("brain.png");
  brain.resize(imageSize, imageSize);
  
  lung = loadImage("lung.png");
  lung.resize(imageSize, imageSize);
  
  heart = loadImage("heart.png");
  heart.resize(imageSize, imageSize);
  
  kidney = loadImage("kidney.png");
  kidney.resize(imageSize, imageSize);
  
  // Create maps
  brainMap = new Brain(brain);
  lungMap = new Lung(lung);
  heartMap = new Heart(heart);
  kidneyMap = new Kidney(kidney);
  
  TowerSprites = new PImage[]{  // Corrected the array declaration
    loadImage("tower/antibody.png"),
  };
  
  GermSprites = new GermSprite[]{
    new GermSprite("germ")
  };
}

int roundCounter = 0; // Determines if you've completed the map on your set difficulty, needs to be moved into gameState class eventually
int lastColourChangeTime = 0;

void draw(){
  
  // Draw the germ character
  image(germ, germX, germY);
  
  //for (PressableButton button : AllButtons){
  //  button.drawButton();
  //}
  
  /* 
     Draws the output based on the current gameState variable
     gameState variable eventually will be moved to a different class, which will also store:
      - Current difficulty
      - Current lives
      - Current money
     Then we need to create another screen between mapSelection and GameMap, where you can select difficulty
     Also need to create an optional screen for How to play/a tutorial?
  */
  
  if (gameState == GameState.TITLE) {
    titleScreen();
  }
  
  if (gameState == GameState.MAP){
    background(startPageBackground);
    mapSelection();
  }
  
  if (gameState.isGameMap()) {
      background(153, 204, 255);
    
      if (gameState == GameState.BRAIN) {
        brainMap.setup();
        brainMap.draw();
        mouseCheck();
      }
  
      if (gameState == GameState.LUNG) {
        lungMap.setup();
        lungMap.draw();
        mouseCheck();
      }
  
      if (gameState == GameState.HEART) {
        heartMap.setup();
        heartMap.draw();
        mouseCheck();
      }
    
      if (gameState == GameState.KIDNEY) {
        kidneyMap.setup();
        kidneyMap.draw();
        mouseCheck();
      }
      
      if (roundCounter == 5){ // roundCounter == 3 && !(currentRound.inProgress())){
        gameState = GameState.WON;
      }
      
      // If you press start round, and no round is in progress it will start the round 
      if (mousePressed && startRoundButton.onButton() && roundCounter < 5){ // Change the roundCounter condition for Difficulty.getNumberOfRounds() later on
        selectRound();
        currentRound.setInProgress(true);
        roundCounter++; 
      }
      
      // On every call to draw, the currentRound is run
      if (currentRound != null && currentRound.inProgress()){
        currentRound.run(); 
      }
   }
   
   if (gameState == GameState.WON){
     winScreen();
   } 
}

color[] currentColours; 

void winScreen(){
  background(153, 204, 255);
  
  int currentTime = millis();
  
  if (currentColours == null){ 
     currentColours = new color[Grid.length * Grid[0].length]; 
     changeColour();
  }
  
  if (currentTime - lastColourChangeTime >= 1500 ){ // Change colours
    changeColour();
    lastColourChangeTime = millis();
  }
  
  fillCellsColour();
  
  fill(255);
  textSize(200);
  text("YOU", 250, 300);
  text("WIN!", 300, 500);
  
  strokeWeight(8);
  strokeJoin(ROUND);
  noFill();
  stroke(currentColours[0]);
  rect(25, HEIGHT*0.85 - 10, 825, 125);
  
  fill(255);
  textSize(35);
  text("[INSERT GAME STATS HERE]", 50, HEIGHT*0.9);
  
  // Play again button
  
  noFill();
  rect(852, HEIGHT*0.85 - 10, 125, 125);
    
  text("Play", 875, HEIGHT*0.9);
  text("again?", 865, HEIGHT*0.95);
  
  PressableButton playAgainButton = new PressableButton(852, (int)(HEIGHT*0.85 - 10), 125, 125);
  if (mousePressed && playAgainButton.onButton()){
    gameState = GameState.MAP;
    draw();
  } 
}

void fillCellsColour(){
  int colourIndex = 0;
  
   for (int x = 0; x < Grid.length; x++){
      for (int y = 0; y < Grid[0].length; y++){
          int nextIndex = colourIndex + 1;
          if (nextIndex == 260){ nextIndex = 0; }
          Grid[x][y].confetti(currentColours[colourIndex], currentColours[nextIndex]); // Implement halt, so its less seziurey LOL
          colourIndex++;
      }
   }
}

void changeColour(){
  for (int i = 0; i < currentColours.length; i++) {
     int colourIndex = (int)random(0, confettiColours.length);
     currentColours[i] = confettiColours[colourIndex];
  }
  
}

GameState getCurrentGameState(){ // Function will be moved to GameState class eventually
  return gameState;
}

// Below 2 functions will be moved into Round class eventually
String getCurrentRoundCounterAsString(){
  return String.valueOf(roundCounter);
}

void selectRound(){ 
  /* 
     Function to select the round
     Either set as initial round, or increases difficultly from previous round
     Need to move into round class & potentially adapt formula for increasing difficulty
     Once we've implemented different kinds of germs needs to be adapted 
     Different quantities of different enemies, etc.
  */
  
  if (currentRound == null || roundCounter == 0){
     currentRound = new Round(30, 10, millis()); // The intial round just set as randomish values for now
  } else if (!(currentRound.inProgress())) {
     currentRound = new Round((currentRound.getDurationInSecs() * 1.2), (currentRound.getNumberOfEnemies() * 1.5), millis()); // Next round slightly harder than last
  }
}

void titleScreen(){ // Format for title screen
  try {
    background(startPageBackground);
    image(germ, germX, germY);
    textFont(font);
    textSize(80);
    fill(255);
    text("Immune System Defence", WIDTH/8 - 50, HEIGHT/4);
    
    //Draw start button
    strokeWeight(8);
    strokeJoin(ROUND);
    fill(153, 204, 255);
    stroke(153, 204, 255);
    rect(WIDTH/2 - 100, HEIGHT/2, 200, 60);
    PressableButton startButton = new PressableButton(WIDTH/2 - 100, HEIGHT/2, 200, 60);
    AllButtons.add(startButton);
    
    fill(255);
    //textSize(30);
    //text("Click to Start!", WIDTH/2 - 92 , HEIGHT/2 + 40);
    
    textSize(40);
    text("START", WIDTH/2 - 62 , HEIGHT/2 + 42);
    
    if (mousePressed && startButton.onButton()){
      gameState = GameState.MAP;
      mapSelection();
    }
  } catch (Exception e) {
      println("Error: " + e.getMessage());
  }
}

void mapSelection(){ // Map selection page 
  image(germ, germX, germY);
  textSize(40);
  fill(255);
  text("Choose which organ to defend:", WIDTH/5, HEIGHT/4 - 25);
  
  int imageSize = 200;
  int outlineSize = imageSize +20;

  strokeWeight(8);
  strokeJoin(ROUND);
  stroke(255);
  noFill();
  
  // Display map images and make them pressable buttons
  image(brain, WIDTH/6, HEIGHT/5 + 50, imageSize, imageSize);
  rect(WIDTH/6 - 10, HEIGHT/5 + 40, outlineSize, outlineSize);
  PressableButton brainButton = new PressableButton(WIDTH/6, HEIGHT/5 + 50, imageSize, imageSize);
  AllButtons.add(brainButton);
  
  image(lung, WIDTH/3+250, HEIGHT/5 + 50, imageSize, imageSize);
  rect(WIDTH/3+240, HEIGHT/5 + 40, outlineSize, outlineSize);
  PressableButton lungButton = new PressableButton(WIDTH/3+250, HEIGHT /5 +50, imageSize, imageSize);
  AllButtons.add(lungButton);
  
  image(heart, WIDTH/6, HEIGHT/5 + 350, imageSize, imageSize);
  rect(WIDTH/6 - 10, HEIGHT/5 + 340, outlineSize, outlineSize);
  PressableButton heartButton = new PressableButton(WIDTH/6, HEIGHT/5 + 350, imageSize, imageSize);
  AllButtons.add(heartButton);
  
  image(kidney, WIDTH/3 +250, HEIGHT/5 + 350, imageSize, imageSize);
  rect(WIDTH/3 +240, HEIGHT/5 + 340, outlineSize, outlineSize);
  PressableButton kidneyButton = new PressableButton(WIDTH/3 +250, HEIGHT/5 + 350, imageSize, imageSize);
  AllButtons.add(kidneyButton);
  
  if (mousePressed && brainButton.onButton()){
      gameState = GameState.BRAIN;
      draw();
  }
    
    if (mousePressed && lungButton.onButton()){
      gameState = GameState.LUNG;
      draw();
    }
    
    if (mousePressed && heartButton.onButton()){
      gameState = GameState.HEART;
      draw();
    }
    
    if (mousePressed && kidneyButton.onButton()){
      gameState = GameState.KIDNEY;
      draw();
    }
} 

void mouseMoved() {
  if (gameState == GameState.TITLE || gameState == GameState.MAP){
    germX = mouseX;
    germY = mouseY;
  } 
}

void mouseCheck(){ // Highlights cell outlines green or red depending on if they're buildable
  int x = (int)(mouseX/cellSize);
  int y = (int)(mouseY/cellSize);
  
  if(x < Grid.length && y < Grid[0].length){
    hoverCell = Grid[x][y];
    hoverCell.outline();
  }
}

void leak(Germ g){
  AllGerms.remove(g);
  println("A germ has leaked");
  // --lives method call required for gameState controlling class
}

void disappear(Projectile p){
  AllProjectiles.remove(p);
}
