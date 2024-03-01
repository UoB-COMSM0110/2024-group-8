int WIDTH = 1000;
int HEIGHT = (int)(WIDTH * 0.8);

PImage startPageBackground;
PImage germ;
PImage brain;
PImage heart;
PImage kidney;
PImage lung;
boolean gameStarted = false;
boolean selectingMap = false;
String selectedMap = "";

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
  
  startPageBackground = loadImage("startpage.png");
  startPageBackground.resize(WIDTH, HEIGHT); // Resize the image to match window dimensions
  
  // Load germ image
  germ = loadImage("germ.png");
  
  // Load map images and resize them to the same size
  brain = loadImage("brain.png");
  lung = loadImage("lung.png");
  heart = loadImage("heart.png");
  kidney = loadImage("kidney.png");
  
  
  int imageSize = 200;
  
  // Resize each map image
  brain.resize(imageSize, imageSize);
  lung.resize(imageSize, imageSize);
  heart.resize(imageSize, imageSize);
  kidney.resize(imageSize, imageSize);
  germ.resize(150, 150);
  
  // Set initial position for the germ character
  germX = width / 2;
  germY = height / 2;
}


void draw() {
  background(startPageBackground);
  
  if (!gameStarted) {
    // Draw title
    textSize(80);
    fill(0);
    text("Tower Defence Game", WIDTH/7, HEIGHT/4);
    
    // Draw start button
    fill(255);
    rect(WIDTH/2 - 100, HEIGHT/2 - 50, 200, 100);
    fill(0);
    textSize(40);
    text("Start", WIDTH/2 - 35, HEIGHT/2 + 10);
  } else if (selectingMap) {
    // Display map selection page
    displayMapSelection();
  } else {
    // Game logic goes here
    textSize(80);
    fill(0, 80, 612, 816);
    text("Tower Defence Game", WIDTH/7, HEIGHT/2);
  }
  
  // Draw the germ character
  image(germ, germX, germY);
}

void mousePressed() {
  if (!gameStarted && mouseX > WIDTH/2 - 100 && mouseX < WIDTH/2 + 100 &&
      mouseY > HEIGHT/2 - 50 && mouseY < HEIGHT/2 + 50) {
    gameStarted = true;
    selectingMap = true;
  } else if (selectingMap) {
    // Check which map was selected and open its program accordingly
    if (mouseX > WIDTH/6 && mouseX < WIDTH/6 + 200 &&
        mouseY > HEIGHT/5 + 50 && mouseY < HEIGHT/5 + 250) {
      // Open the brain map program
      // You can call the function or method to open the brain map program here
    } else if (mouseX > WIDTH/3 + 250 && mouseX < WIDTH/3 + 450 &&
               mouseY > HEIGHT/5 + 50 && mouseY < HEIGHT/5 + 250) {
      // Open the lung map program
      
      // You can call the function or method to open the lung map program here
    } else if (mouseX > WIDTH/6 && mouseX < WIDTH/6 + 200 &&
               mouseY > HEIGHT/5 + 350 && mouseY < HEIGHT/5 + 550) {
      // Open the heart map program
      // You can call the function or method to open the heart map program here
    } else if (mouseX > WIDTH/3 + 250 && mouseX < WIDTH/3 + 450 &&
               mouseY > HEIGHT/5 + 350 && mouseY < HEIGHT/5 + 550) {
      // Open the kidney map program
      // You can call the function or method to open the kidney map program here
    }
  }
}


void displayMapSelection() {
  textSize(40);
  fill(0);
  text("Select a map:", WIDTH/3, HEIGHT/4);
  
  // Display map images
  image(brain, WIDTH/6, HEIGHT/5 + 50);
  image(lung, WIDTH/3+250, HEIGHT /5 +50);
  image(heart, WIDTH/6, HEIGHT/5 + 350);
  image(kidney, WIDTH/3 +250, HEIGHT/5 + 350);
}

// Update the position of the germ character based on mouse movement
void mouseMoved() {
  
  if (mouseX > germX) {
    germX += germSpeed;
  } else if (mouseX < germX) {
    germX -= germSpeed;
  }

}
