int WIDTH = 1000;
int HEIGHT = (int)(WIDTH * 0.8);

PImage startPageBackground;
PImage germ;
PImage brain;
PImage heart;
PImage kidney;
PImage lung;

protected Lung lungMap;
protected Kidney kidneyMap;
protected Brain brainMap;
protected Heart heartMap;

public enum GameState {
  TITLE, MAP, BRAIN, LUNG, HEART, KIDNEY;
}

GameState gameState;

// Define variables for the germ character
float germX;
float germY;
float germSpeed = 5; // Adjust the speed as needed

void settings() {
  size(WIDTH, HEIGHT);
}

void setup() {
  fill(0);
  textSize(40);
  
  // Set Game State to be title
  gameState = GameState.TITLE;
  
  startPageBackground = loadImage("startpage.png");
  startPageBackground.resize(WIDTH, HEIGHT); // Resize the image to match window dimensions
  
  // Load germ image
  germ = loadImage("germ.png");
  
  // Load map images and resize them to the same size
  brain = loadImage("brain.png");
  lung = loadImage("lung.png");
  heart = loadImage("heart.png");
  kidney = loadImage("kidney.png");
  lungMap = new Lung(); 
  kidneyMap = new Kidney();
  brainMap = new Brain();
  heartMap = new Heart();
  
  int imageSize = 200;
  
  // Resize each map image
  brain.resize(imageSize, imageSize);
  lung.resize(imageSize, imageSize);
  heart.resize(imageSize, imageSize);
  kidney.resize(imageSize, imageSize);
  germ.resize(20, 20);
  
  // Set initial position for the germ character
  germX = width / 2;
  germY = height / 2;
}


void draw() {
  background(startPageBackground);
  
  // Draw the germ character
  image(germ, germX, germY);
  
  if (gameState == GameState.TITLE) {
    titleScreen();
  }
    
  if (gameState == GameState.MAP) {
    // Display map selection page
    mapSelection();
  } 
  
  if (gameState == GameState.BRAIN){
    background(255);
    brainMap.draw();
  }
  
  if (gameState == GameState.LUNG){
    background(255);
    lungMap.draw();
  }
  
  if (gameState == GameState.HEART){
    background(255);
    heartMap.draw();
  }
  
  if (gameState == GameState.KIDNEY){
    background(255);
    kidneyMap.draw();
  }
    
}

void titleScreen(){
  // Draw title
  textSize(80);
  fill(0);
  text("Immune System Defence", WIDTH/8, HEIGHT/4);
    
  // Draw start button
  fill(255);
  rect(WIDTH/2 - 100, HEIGHT/2 - 50, 200, 100);

  fill(0);
  textSize(40);
  text("START", WIDTH/2 - 35, HEIGHT/2 + 10);
  PressableButton startButton = new PressableButton(WIDTH/2 - 100, HEIGHT/2 - 50, 200, 100);
  
  if (mousePressed && startButton.onButton() == true){
    gameState = GameState.MAP;
    mapSelection();
  }
}

void mapSelection(){
  textSize(40);
  fill(0);
  text("Select a map:", WIDTH/3, HEIGHT/4);
  
  int imageSize = 200;
  
  // Display map images
  image(brain, WIDTH/6, HEIGHT/5 + 50);
  PressableButton brainButton = new PressableButton(WIDTH/6, HEIGHT/5 + 50, imageSize, imageSize);
  
  image(lung, WIDTH/3+250, HEIGHT /5 +50);
  PressableButton lungButton = new PressableButton(WIDTH/3+250, HEIGHT /5 +50, imageSize, imageSize);
  
  image(heart, WIDTH/6, HEIGHT/5 + 350);
  PressableButton heartButton = new PressableButton(WIDTH/6, HEIGHT/5 + 350, imageSize, imageSize);
  
  image(kidney, WIDTH/3 +250, HEIGHT/5 + 350);
  PressableButton kidneyButton = new PressableButton(WIDTH/3 +250, HEIGHT/5 + 350, imageSize, imageSize);
  
  if (mousePressed && brainButton.onButton() == true){
    gameState = GameState.BRAIN;
    draw();
  }
  
  
  if (mousePressed && lungButton.onButton() == true){
    gameState = GameState.LUNG;
    draw();
  }
  
  if (mousePressed && heartButton.onButton() == true){
    gameState = GameState.HEART;
    draw();
  }
  
  if (mousePressed && kidneyButton.onButton() == true){
    gameState = GameState.KIDNEY;
    draw();
  }
   
}

// Update the position of the germ character based on mouse movement
void mouseMoved() {
  germX = mouseX;
  germY = mouseY;
}
