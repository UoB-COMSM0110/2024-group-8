int WIDTH = 1000;
int HEIGHT = (int)(WIDTH * 0.8);
//float playWindowHeight = WIDTH * 0.65;
float cellSize = WIDTH / 20;
//float menuPosY = playWindowHeight + 1;
//float menuHeight = HEIGHT - menuPosY;;

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

Brain brainMap;
Lung lungMap;
Heart heartMap;
Kidney kidneyMap;

enum GameState { // Different phases of the game, so program knows what to draw
    TITLE,
    MAP,
    BRAIN,
    LUNG,
    HEART,
    KIDNEY
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


void settings() {
  size(WIDTH, HEIGHT);
}

void setup() { // Loads the different images needs for titleScreen & mapSelection
  // Also sets up the germ cursor for the entry screens
  fill(0);
  textSize(40);
  
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

void draw() {
  
  // Draw the germ character
  image(germ, germX, germY);
  
  /* 
     Draws the output based on the current gameState variable
     gameState variable eventually will be moved to a different class, which will also store:
      - Current difficulty
      - Current lives
      - Current money
     Then we need to create another screen between mapSelection and GameMap, where you can select difficulty
  */
  
  if (gameState == GameState.TITLE) {
    titleScreen();
  }
  
  if (gameState == GameState.MAP){
    background(startPageBackground);
    mapSelection();
  }
  
  if (gameState == GameState.BRAIN || gameState == GameState.LUNG || 
      gameState == GameState.HEART || gameState == GameState.KIDNEY) {
      background(255);
    
      if (gameState == GameState.BRAIN) {
        brainMap.setup();
        brainMap.draw();
        buildTowers();
        mouseCheck();
      }
  
      if (gameState == GameState.LUNG) {
        lungMap.setup();
        lungMap.draw();
        buildTowers();
        mouseCheck();
      }
  
      if (gameState == GameState.HEART) {
        heartMap.setup();
        heartMap.draw();
        buildTowers();
        mouseCheck();
      }
    
      if (gameState == GameState.KIDNEY) {
        kidneyMap.setup();
        kidneyMap.draw();
        buildTowers();
        mouseCheck();
      }
      
      // If you press start round, and no round is in progress it will start the round 
      if (mousePressed && startRoundButton.onButton() && roundCounter <= 5){ // Change the roundCounter condition for Difficulty.getNumberOfRounds() later on
        selectRound();
        currentRound.setInProgress(true);
        roundCounter++; 
      }
      
      // On every call to draw, the currentRound is run
      if (currentRound != null && currentRound.inProgress()){
        currentRound.run(); 
      }
   }
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
     currentRound = new Round(180, 60, millis()); // The intial round 
     System.out.println("Starting first round!");
  } else if (!(currentRound.inProgress())) {
     currentRound = new Round((currentRound.getDurationInSecs() * 0.2), (currentRound.getNumberOfEnemies() * 0.5), millis()); // Next round slightly harder than last
     System.out.println("Starting round " +(roundCounter+1) + "!");
     // Enable some boolean so that no towers can be created during this time
  }
}

void updateVisuals(){
    for (int i = 0; i < AllTowers.size(); i++){  // Changed length to size()
       AllTowers.get(i).drawme();  // Changed AllToweers to AllTowers
    }
     
    for (int i = 0; i< AllGerms.size(); i++){ 
        AllGerms.get(i).move(); 
    }
}

void titleScreen(){ // Format for title screen
  try {
    background(startPageBackground);
    image(germ, germX, germY);
    textSize(75);
    fill(0);
    text("Immune System Defence", WIDTH/7, HEIGHT/4);
    
    // Draw start button
    fill(255);
    rect(WIDTH/2 - 100, HEIGHT/2 - 50, 200, 100);
    PressableButton startButton = new PressableButton(WIDTH/2 - 100, HEIGHT/2 - 50, 200, 100);
    fill(0);
    textSize(40);
    text("START", WIDTH/2 - 35, HEIGHT/2 + 10);
    
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
  fill(0);
  text("Choose which organ to defend:", WIDTH/5, HEIGHT/4);
  
  int imageSize = 200;
  
  // Display map images and make them pressable buttons
  image(brain, WIDTH/6, HEIGHT/5 + 50);
  PressableButton brainButton = new PressableButton(WIDTH/6, HEIGHT/5 + 50, imageSize, imageSize);
  
  image(lung, WIDTH/3+250, HEIGHT /5 +50);
  PressableButton lungButton = new PressableButton(WIDTH/3+250, HEIGHT /5 +50, imageSize, imageSize);
  
  image(heart, WIDTH/6, HEIGHT/5 + 350);
  PressableButton heartButton = new PressableButton(WIDTH/6, HEIGHT/5 + 350, imageSize, imageSize);
  
  image(kidney, WIDTH/3 +250, HEIGHT/5 + 350);
  PressableButton kidneyButton = new PressableButton(WIDTH/3 +250, HEIGHT/5 + 350, imageSize, imageSize);
  
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

void buildTowers(){ 
  /* 
     Function to select and build towers
     May be better suited in GameMap class?
  */
  
  if (currentRound != null){
    if(currentRound.inProgress()){
      System.out.println("Cannot place towers whilst a round is in progress!");
      return;
    }
  }
      
  if (mousePressed && towerAButton.onButton()){
     System.out.println("Selected a tower");
     towerSelected = true;
  }
    
     // Animation of moving tower when choosing location
  if (towerSelected){
    selectedTower = TowerSprites[0];
    selectedTower.resize(50,50);
    image(selectedTower, mouseX, mouseY);
       
     int currentGridX = (int)(mouseX/cellSize);
     int currentGridY = (int)(mouseY/cellSize);
       
     if (mousePressed && checkBuildable(currentGridX, currentGridY)){
         Grid[currentGridX][currentGridY].buildOn(new TowerA(currentGridX, currentGridY, 0)); 
         towerSelected = false;
     }
  }
}

boolean checkBuildable(int x, int y){ // Goes w/build towers function above
  if(x < Grid.length && y < Grid[0].length){
    return Grid[x][y].buildable();
  }
  return false;
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
