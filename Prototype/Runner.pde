int WIDTH = 1000;
int HEIGHT = (int)(WIDTH * 0.8);

Cell[][] Grid = new Cell[20][13]; 
float cellSize = WIDTH / 20;      // Global variables

PImage[] TowerSprites;
GermSprite[] GermSprites;    // Do these need to be global variables?

PImage brain;
PImage heart;
PImage kidney;
PImage lung;
PFont font;

enum GameState { // Different phases of the game, so program knows what to draw
    TITLE,
    MAP,
    WON,
    // RULES, // Will be the "How to play" screen, can be navigated to at anytime before gameMap selected?
    DIFFICULTY, 
    BRAIN,
    LUNG,
    HEART,
    KIDNEY; 
    
    public boolean isGameMap(){ // Creates a distinct gamestate class for button animations
      return this == BRAIN || this == LUNG || this == HEART || this == KIDNEY;
    }
}

enum Difficulty { 
        // Defintion of each difficulty and what you start with
        EASY(100, 5, 200),   // ( Start Lives ; Number of Rounds ; Start Coins)
        MEDIUM(70, 10, 150),
        HARD(40, 20, 100);

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
MapSelection mapSelection;
DifficultySelection difficultySelection;
WinScreen winScreen;

Brain brainMap;
Lung lungMap;
Heart heartMap;
Kidney kidneyMap;

DifficultySelection brainDifficulty;
DifficultySelection lungDifficulty;
DifficultySelection heartDifficulty;
DifficultySelection kidneyDifficulty;

GameState currentGameState; // Tracks which display to present
RunningGame currentGame;
Round currentRound;
boolean difficultySelected;

// Define variables for the germ cursor character
PImage germ;
float germX;
float germY; // Need to be global as appear on multiple displays

// Global variable, as many classes need easy acess
Path mapPath; // Pathway followed by germs

// Array lists for towers and enemies
ArrayList<DefenceTower> AllTowers  = new ArrayList<DefenceTower>();
ArrayList<Germ> AllGerms = new ArrayList<Germ>();

// Array list for all on screen shots
ArrayList<Projectile> AllProjectiles = new ArrayList<Projectile>();

// Stores all buttons which change the display, e.g., Play again = WinScreen -> MapSelection
ArrayList<StateChangingButton> stateChangingButtons = new ArrayList<StateChangingButton>();

void settings(){
  size(WIDTH, HEIGHT);
}

void setup(){
  font = createFont("Papyrus", 30);
  currentGameState = GameState.TITLE;

  titleScreen = new TitleScreen();
  mapSelection = new MapSelection();
  winScreen = new WinScreen();
  
  titleScreen.setup();
  mapSelection.setup();

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
  
  TowerSprites = new PImage[]{  // Corrected the array declaration
    loadImage("tower/antibody.png"),
  };
  
  GermSprites = new GermSprite[]{
    new GermSprite("germ")
  };
}

void draw(){
  /* 
     Draws the output based on the current gameState variable
     gameState variable eventually will be moved to a different class, which will also store:
      - Current difficulty
      - Current lives
      - Current money
     Also need to create an optional screen for How to play/a tutorial?
  */
  
  if (currentGameState == GameState.TITLE){
    titleScreen.draw();
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
}

void mouseMoved() {
  if (currentGameState == GameState.TITLE || currentGameState == GameState.MAP){
    germX = mouseX;
    germY = mouseY;
  } 
}

void mousePressed(){
  for (StateChangingButton x : stateChangingButtons){
    x.changeStates();
  }
}

void mouseCheck(){ // Highlights cell outlines green or red depending on if they're buildable
  int x = (int)(mouseX/cellSize);
  int y = (int)(mouseY/cellSize);
  
  if(x < Grid.length && y < Grid[0].length){
    Grid[x][y].outline();
  }
}


void disappear(Projectile p){
  AllProjectiles.remove(p);
}
