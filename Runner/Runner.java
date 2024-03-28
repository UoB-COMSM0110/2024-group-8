/*
    I have finished most of the skeleton of the code, but there's still lots to do:
      - GAME MAP:
          - Create a stylised background image and unique path for each organ
          - Implement twist logic for each map
          - Clean up the Game Map class by moving methods/code to different classes, I'm thinking about having a 
            TowerManager and RoundManager class to handle a lot of logic currently in GameMap
          FINAL BOSS:
             - Design and implement a final boss germ for each map

      - LOSE SCREEN:
          - Design and implement a lose screen
          - Will have very similar implementation to win screen
          - i.e. display game stats, have a play again button, clear all currentGame data
          - I thinking instead of filling the grid with bright colours as on winn screen we can fill with changing germs,
            so it's like they've taken over

      - HOW TO PLAY SCREEN:
          - Design and implement instructions screen
          - Should have a button top left on all displays (except win/lose screens),
            which you can press to bring up an instructions screen

      - GERMS:
          - Design and implement at least 3/4 more enemies
          - When a higher level germ is killed, should create a lower level germ in its place 
            (see existing tower defence game if you're unsure what this means)

      - TOWERS: 
          - Design and implement at least 3/4 more towers
          GAME WINDOW: 
          - Design and implement a game window which will display the stats of the last tower clicked, as well as a sell/delete button,
            and an upgrade button which shows what the next possible upgrade is, i.e. UPGRADE: Faster Shots COST: 50 coins

      - ROUNDS:
          - Although I've implemented 'difficulty' its only currently increases number of rounds, and decresing lives and coins
          - To make it truly more difficult we need to make the rounds have a set type of enemies etc.
          - Currently the next round just builds on the last by making it slightly longer w/more enemies, but we need to make them actually harder

      - PROJECTILES:
          - Design and implement projectiles
          - When doing so will need to alter the tower shots logic slightly so that it shots at correct intervals
          
      - BACK BUTTON:
          - Either an onscreen button or just ESC to go back a screen, i.e. difficulty selection back to map selection
          - Also for when you've clicked a tower but no longer want to place it
*/

import processing.core.*;

import java.util.ArrayList;

public class Runner extends PApplet {

    static int WIDTH = 1000;
    static int HEIGHT = (int) (WIDTH * 0.8);

    static Cell[][] Grid = new Cell[20][14];
    static float cellSize = (float) WIDTH / 20;      // MUST BE global variables

    static PImage[] TowerSprites;
    static GermSprite[] GermSprites;    // Do these need to be global variables?

    static PImage brain;
    static PImage heart;
    static PImage kidney;
    static PImage lung;
    static PImage backButton;
    static PFont font;

    // Different display screens
    static TitleScreen titleScreen;
    static MapSelection mapSelection;
    static DifficultySelection difficultySelection;
    static WinScreen winScreen;
    static LoseScreen loseScreen;

    static Brain brainMap;
    static Lung lungMap;
    static Heart heartMap;
    static Kidney kidneyMap;

    // Not sure if there's a better way of doing this, but I create one instance per map so it knows which map to navigate to post difficulty selection
    static DifficultySelection brainDifficulty;
    static DifficultySelection lungDifficulty;
    static DifficultySelection heartDifficulty;
    static DifficultySelection kidneyDifficulty;

    static GameState currentGameState; // Tracks which display to present
    static RunningGame currentGame; // Holds all game stats of current Game
    static Round currentRound; // Holds all stats of current round
    static boolean difficultySelected; // Defines whether to draw difficult selection screen or game map, necessary as otherwise it doesn't know which map to navigate to
    // TowerManager towerManager;
    static PressableButton gameWindow; // Stops the gameWindow from having cell outlines in mouseCheck()

    // Define variables for the germ cursor character
    static PImage germ;
    static float germX;
    static float germY; // Need to be global as appear on multiple displays

    // Global variable, as many classes need easy acess
    static Path mapPath; // Pathway followed by germs

    // Array lists for towers and enemies
    static ArrayList<DefenceTower> AllTowers = new ArrayList<DefenceTower>();
    static ArrayList<Germ> AllGerms = new ArrayList<Germ>();

    // Array list for all on screen shots
    static ArrayList<Projectile> AllProjectiles = new ArrayList<Projectile>();

    // Stores all buttons which change the display, e.g., Play again = WinScreen -> MapSelection
    static ArrayList<StateChangingButton> stateChangingButtons = new ArrayList<StateChangingButton>();

    public void settings() {
        size(WIDTH, HEIGHT);
    }

    public void setup() { // Creates & setups all objects needed for the game, calls their relevant setup functions
        font = createFont("Papyrus", 30);
        currentGameState = GameState.TITLE;

        TowerSprites = new PImage[]{
                loadImage("data/tower/antibody.png"),
                loadImage("data/tower/towerB.png")
        };

        GermSprites = new GermSprite[]{
                new GermSprite("germ", this)
        };

        titleScreen = new TitleScreen(this);
        mapSelection = new MapSelection(this);
        winScreen = new WinScreen(this);
        loseScreen = new LoseScreen(this);

        titleScreen.setup();
        mapSelection.setup();

        // Create maps
        brainMap = new Brain(brain, this);
        brainMap.setup();
        brainDifficulty = new DifficultySelection(GameState.BRAIN, this);

        lungMap = new Lung(lung, this);
        lungMap.setup();
        lungDifficulty = new DifficultySelection(GameState.LUNG, this);

        heartMap = new Heart(heart, this);
        heartMap.setup();
        heartDifficulty = new DifficultySelection(GameState.HEART, this);

        kidneyMap = new Kidney(kidney, this);
        kidneyMap.setup();
        kidneyDifficulty = new DifficultySelection(GameState.KIDNEY, this);


        //float playWindowHeight = WIDTH * 0.65;
        //float menuPosY = playWindowHeight + 1;
        //float menuHeight = (HEIGHT - menuPosY) - 10;

        gameWindow = new PressableButton(0, 650, WIDTH, 350, this); // Psuedo button over gameWindow in map so that the cells don't get outlined
    }

    public void draw() {
        // Draws the output based on the current gameState variable

        if (currentGameState == GameState.TITLE) {
            titleScreen.draw();
        }

        if (currentGameState == GameState.MAP) {
            mapSelection.draw();
        }

        if (currentGameState.isGameMap()) {
            if (currentGameState == GameState.BRAIN) {
                if (difficultySelected) {
                    brainMap.setup();
                    brainMap.draw();
                    mouseCheck();
                } else {
                    assert(brainDifficulty.runner != null);
                    brainDifficulty.draw();
                }
            }

            if (currentGameState == GameState.LUNG) {
                if (difficultySelected) {
                    lungMap.setup();
                    lungMap.draw();
                    mouseCheck();
                } else {
                    lungDifficulty.draw();
                }
            }

            if (currentGameState == GameState.HEART) {
                if (difficultySelected) {
                    heartMap.setup();
                    heartMap.draw();
                    mouseCheck();
                } else {
                    heartDifficulty.draw();
                }
            }

            if (currentGameState == GameState.KIDNEY) {
                if (difficultySelected) {
                    kidneyMap.setup();
                    kidneyMap.draw();
                    mouseCheck();
                } else {
                    kidneyDifficulty.draw();
                }
            }
        }

        if (currentGameState == GameState.WON) {
            winScreen.draw();
        }

        if (currentGameState == GameState.LOST) {
            loseScreen.draw();
        }
    }

    public void mouseMoved() {
        if (currentGameState == GameState.TITLE || currentGameState == GameState.MAP) {
            germX = mouseX;
            germY = mouseY;
        }
    }

    public void mousePressed() {
        // Iterates through the array of buttons which change the displays and changes states if they are currently displayed & pressed
        for (StateChangingButton x : stateChangingButtons) {
            x.changeStates();
        }
        // Will need to add similar logic for tower button?
    }

    public void mouseCheck() { // Highlights cell outlines green or red depending on if they're buildable
        int x = (int) (mouseX / cellSize);
        int y = (int) (mouseY / cellSize);

        if ((x < Grid.length && y < Grid[0].length) && !gameWindow.onButton()) {
            Grid[x][y].outline();
        }
    }

    void disappear(Projectile p) {
        AllProjectiles.remove(p);
    }


    public static void main(String[] args) {
        PApplet.main("Runner");
    }


}