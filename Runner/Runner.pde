/*
    To do list, delete when done :) 

      - GAME MAP:
          - Create a stylised background image and unique path for each organ
          - Implement twist logic for each map
          FINAL BOSS:
             - Design and implement a final boss germ for each map

      - HOW TO PLAY SCREEN:
          - Design and implement instructions screen
          - Should have a button top left on all displays (except win/lose screens),
            which you can press to bring up an instructions screen

      - GERMS:
          - Design and implement at least 3/4 more enemies
          - When a higher level germ is killed, should create a lower level germ in its place 

      - TOWERS: 
          - Design and implement at least 2 more towers
          MUCUS DISPENSER - places mucus on the path which slows down the speed of trapped germs
          ??? - some super strong tower which shoots the diamond projectiles, maybe the creepy spider antibody and it can move around the map?

      - ROUNDS:
          - Although I've implemented 'difficulty' its only currently increases number of rounds, and decresing lives and coins
          - To make it truly more difficult we need to make the rounds have a set type of enemies etc.
          - Currently the next round just builds on the last by making it slightly longer w/more enemies, but we need to make them actually harder


*/


int WIDTH = 1000;
int HEIGHT = (int)(WIDTH * 0.8);

Cell[][] Grid = new Cell[20][14]; 
float cellSize = WIDTH / 20;      // MUST BE global variables

PImage[] TowerSprites;
GermSprite[] GermSprites;    // Do these need to be global variables?

PImage brain;
PImage heart;
PImage kidney;
PImage lung;
PImage backButton;
PFont font;


enum GameState { // Different phases of the game, so program knows what to draw
    TITLE,
    MAP,
    WON,
    LOST, 
    HOWTO, 
    BRAIN,
    LUNG,
    HEART,
    KIDNEY; 
    
    public boolean isGameMap(){ 
      return this == BRAIN || this == LUNG || this == HEART || this == KIDNEY;
    }
}

enum Difficulty { 
        // Defintion of each difficulty and what you start with
        EASY(100, 10, 200),   // ( Start Lives ; Number of Rounds ; Start Coins)
        MEDIUM(70, 20, 150),
        HARD(40, 30, 75);

        private int numberOfRounds;
        private int numberOfLives;
        private int numberOfCoins;

        Difficulty(int numberOfLives, int numberOfRounds, int numberOfCoins) {
           this.numberOfLives = numberOfLives;
           this.numberOfRounds = numberOfRounds;
           this.numberOfCoins = numberOfCoins;
        }

        public int getNumberOfLives() {
           return numberOfLives;
        }

        public int getNumberOfRounds() {
           return numberOfRounds;
        }

        public int getNumberOfCoins() {
           return numberOfCoins;
        }
    }

// Different display screens
TitleScreen titleScreen;
HowToPlayScreen howToPlayScreen;
MapSelection mapSelection;
DifficultySelection difficultySelection;
WinScreen winScreen;
LoseScreen loseScreen;

Brain brainMap;
Lung lungMap;
Heart heartMap;
Kidney kidneyMap;

GameMap currentGameMap;

// Not sure if there's a better way of doing this, but I create one instance per map so it knows which map to navigate to post difficulty selection
DifficultySelection brainDifficulty;
DifficultySelection lungDifficulty;
DifficultySelection heartDifficulty;
DifficultySelection kidneyDifficulty;

GameState currentGameState; // Tracks which display to present
RunningGame currentGame; // Holds all game stats of current Game
Round currentRound; // Holds all stats of current round
boolean difficultySelected; // Defines whether to draw difficult selection screen or game map, necessary as otherwise it doesn't know which map to navigate to
PressableButton gameWindow; // Stops the gameWindow from having cell outlines in mouseCheck()

// Define variables for the germ cursor character
PImage germ;
float germX;
float germY; // Need to be global as appear on multiple displays

// Global variable, as many classes need easy acess
Path mapPath; // Pathway followed by germs

// Array lists for towers and enemies
ArrayList<DefenceTower> AllTowers  = new ArrayList<DefenceTower>();
ArrayList<Germ> AllGerms = new ArrayList<Germ>();
ArrayList<Projectile> AllProjectiles = new ArrayList<Projectile>();

// Stores all buttons which change the display, e.g., Play again = WinScreen -> MapSelection
ArrayList<StateChangingButton> stateChangingButtons = new ArrayList<StateChangingButton>();
ArrayList<TowerButton> allTowerButtons = new ArrayList<>();

void settings(){
  size(WIDTH, HEIGHT);
}

void setup(){ // Creates & setups all objects needed for the game, calls their relevant setup functions
  font = createFont("DejaVu Serif Condensed", 30);
  currentGameState = GameState.TITLE;

  titleScreen = new TitleScreen();
  mapSelection = new MapSelection();
  winScreen = new WinScreen();
  loseScreen = new LoseScreen();
  howToPlayScreen = new HowToPlayScreen();
  
  titleScreen.setup();
  mapSelection.setup();

  TowerSprites = new PImage[]{ 
    loadImage("tower/antibody.png"),
    loadImage("tower/towerB.png")
  };
  
  GermSprites = new GermSprite[]{
    new GermSprite("germ1"),
    new GermSprite("germ2"),
    new GermSprite("germ3"),
    new GermSprite("germ4"),
    new GermSprite("germ5"),
    new GermSprite("germ6"),
    new GermSprite("germ7"),
    new GermSprite("germ8")
  };

  // Create maps
  brainMap = new Brain(brain);
  brainMap.setup();
  brainDifficulty = new DifficultySelection(GameState.BRAIN);

  lungMap = new Lung(lung);
  lungMap.setup();
  lungDifficulty = new DifficultySelection(GameState.LUNG);

  heartMap = new Heart(heart);
  heartMap.setup();
  heartDifficulty = new DifficultySelection(GameState.HEART);

  kidneyMap = new Kidney(kidney);
  kidneyMap.setup();
  kidneyDifficulty = new DifficultySelection(GameState.KIDNEY);
  
  gameWindow = new PressableButton(0, 650, WIDTH, 350); // Psuedo button over gameWindow in map so that the cells don't get outlined
}

void draw(){
  // Draws the output based on the current gameState variable
  
  if (currentGameState == GameState.TITLE){
    titleScreen.draw();
  }

  if (currentGameState == GameState.HOWTO){
    howToPlayScreen.draw();
  }
  
  if (currentGameState == GameState.MAP){
    mapSelection.draw();
  }
  
  if (currentGameState.isGameMap()){  
      if (currentGameState == GameState.BRAIN) {
        if (difficultySelected){ 
          brainMap.setup();
          brainMap.draw();
          mouseCheck();
        } else {
          brainDifficulty.draw();
        }
      }
  
      if (currentGameState == GameState.LUNG) {
         if (difficultySelected){ 
           lungMap.setup();
           lungMap.draw();
           mouseCheck();
          } else {
           lungDifficulty.draw();
          }
       }
  
      if (currentGameState == GameState.HEART){
        if (difficultySelected){ 
          heartMap.setup();
          heartMap.draw();
          mouseCheck();
        } else {
          heartDifficulty.draw();
        }
      }
    
      if (currentGameState == GameState.KIDNEY){
        if (difficultySelected){ 
          kidneyMap.setup();
          kidneyMap.draw();
          mouseCheck();
        } else {
          kidneyDifficulty.draw();
        }
      }
   }
   
    if (currentGameState == GameState.WON){
      winScreen.draw();
    } 
    
    if (currentGameState == GameState.LOST){
      loseScreen.draw();
    } 
}

void mouseMoved() {
  if (currentGameState == GameState.TITLE || currentGameState == GameState.MAP){
    germX = mouseX;
    germY = mouseY;
  } 
}

void mousePressed(){
  // Iterates through the array of buttons which change the displays and changes states if they are currently displayed & pressed
  for (StateChangingButton x : stateChangingButtons){ 
    x.changeStates();
  }
  
  for (TowerButton b : allTowerButtons){
    b.selectTower();
  }

  if (currentGameState.isGameMap()){
    clickTower();
  }
}

void mouseCheck(){ // Highlights cell outlines green or red depending on if they're buildable
  int x = (int)(mouseX/cellSize);
  int y = (int)(mouseY/cellSize);
  
  if((x < Grid.length && y < Grid[0].length) && !gameWindow.onButton()){
    Grid[x][y].outline();
  }
}

void clickTower(){
    for (DefenceTower t : AllTowers){
        PressableButton placedTower = new PressableButton((int)(t.positionX*cellSize), (int)(t.positionY*cellSize), (int)cellSize, (int)cellSize);
        if (placedTower.onButton()){
          currentGameMap.setLastClickedTower(t);
        }
    }
}
