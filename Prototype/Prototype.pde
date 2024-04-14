/*
    To do list, delete when done :) 

      - GAME MAP:
          - Implement twist logic & final boss for each map
          - Need to have a welcome screen to each organ which explains the twist of the map i think?

          HEART:     **completed, but some have some bugs**
                Twist = As you lose lives, blood gets thinner = all germs move faster
                Final boss = blood clot
             
          LUNG:        **Completed**
                Twist = as you lose lives, fog/smoke starts clouding the screen and visibility is decreased
                Final Boss = pulmonary embolism
             
          BRAIN:
                Twist = probability of a stroke increases = chance of stroke variable in top right
                = In game logic, each time a new round is selected according to probability might be a stroke which ends the game there
                Final boss = an aneurisym
             
          KIDNEY:
                Twist = germ multiplication & temperature rise, as temperature rises the germs are more likely to multiply (double current round's germs)
                Final boss = Kidney stone

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
    DIFFICULTY,
    BRAIN,
    LUNG,
    HEART,
    KIDNEY; 
    
    public boolean isGameMap(){ 
      return (this == BRAIN || this == LUNG || this == HEART || this == KIDNEY);
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
GameState currentGameState; // Tracks which display to present
RunningGame currentGame; // Holds all game stats of current Game
Round currentRound; // Holds all stats of current round

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
ArrayList<Mucus> AllMucus = new ArrayList<Mucus>();

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
  difficultySelection = new DifficultySelection();
  
  titleScreen.setup();
  mapSelection.setup();

  TowerSprites = new PImage[]{ 
    loadImage("tower/antibody.png"),
    loadImage("tower/towerB.png"),
    loadImage("tower/towerC.png"),
    loadImage("tower/towerD.png")
  };
  
  GermSprites = new GermSprite[]{
    new GermSprite("germ1"),
    new GermSprite("germ2"),
    new GermSprite("germ3"),
    new GermSprite("germ4"),
    new GermSprite("germ5"),
    new GermSprite("germ6"),
    new GermSprite("germ7"),
    new GermSprite("germ8"),
    new GermSprite("kidneyStone")
  };
  
   // Initialize grid
    for (int x = 0; x < Grid.length; x++){
       for (int y = 0; y < Grid[0].length; y++){
          Grid[x][y] = new Cell(x, y);
       }
    }
    
  // Create maps
  brainMap = new Brain(brain);
  lungMap = new Lung(lung);
  heartMap = new Heart(heart);
  kidneyMap = new Kidney(kidney);

  gameWindow = new PressableButton(0, 650, WIDTH, 350); // Psuedo button over gameWindowin map so that the cells don't get outlined
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
  
  if (currentGameState == GameState.DIFFICULTY){
    difficultySelection.draw();
  }
  
  if (currentGameState.isGameMap()){  
      if (currentGameState == GameState.BRAIN) {
          currentGameMap = brainMap;
          brainMap.draw();
          mouseCheck();
      }
  
      if (currentGameState == GameState.LUNG) {
           currentGameMap = lungMap;
           lungMap.draw();
           mouseCheck();
      }
  
      if (currentGameState == GameState.HEART){
          currentGameMap = heartMap;
          heartMap.draw();
          mouseCheck();
      }
    
      if (currentGameState == GameState.KIDNEY){
          currentGameMap = kidneyMap;
          kidneyMap.draw();
          mouseCheck();
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

PressableButton placedTower;

void clickTower(){
  int x = (int)(mouseX/cellSize);
  int y = (int)(mouseY/cellSize);
  
  try {
    if (!gameWindow.onButton()){ 
      currentGameMap.setLastClickedTower(Grid[x][y].occupant);
    }
  } catch (Exception e){}
}
