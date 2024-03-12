class MapSelection extends Display {
  PImage startPageBackground;
  
   void setup(){
    startPageBackground = loadImage("startpage.png");
    startPageBackground.resize(WIDTH, HEIGHT); // Resize the image to match window dimensions
    
    int imageSize = 200;

    brain = loadImage("brain.png");
    brain.resize(imageSize, imageSize);
  
    lung = loadImage("lung.png");
    lung.resize(imageSize, imageSize);
  
    heart = loadImage("heart.png");
    heart.resize(imageSize, imageSize);
  
    kidney = loadImage("kidney.png");
    kidney.resize(imageSize, imageSize);
   }

   void draw(){
    background(startPageBackground);
    image(germ, germX, germY);

    image(germ, germX, germY);
  
    textSize(40);
    fill(255);
    text("Choose which organ to defend:", WIDTH/5, HEIGHT/4 - 25);
  
    int imageSize = 200;
    int outlineSize = imageSize +20;

    strokeWeight(8); // Format for squares outlining the map images
    strokeJoin(ROUND);
    stroke(255);
    noFill();
  
    // Display map images and make them pressable buttons
    image(brain, WIDTH/6, HEIGHT/5 + 50, imageSize, imageSize);
    rect(WIDTH/6 - 10, HEIGHT/5 + 40, outlineSize, outlineSize);
    StateChangingButton brainButton = new StateChangingButton(WIDTH/6, HEIGHT/5 + 50, imageSize, imageSize, GameState.BRAIN);
    stateChangingButtons.add(brainButton);
  
    image(lung, WIDTH/3+250, HEIGHT/5 + 50, imageSize, imageSize);
    rect(WIDTH/3+240, HEIGHT/5 + 40, outlineSize, outlineSize);
    StateChangingButton lungButton = new StateChangingButton(WIDTH/3+250, HEIGHT /5 +50, imageSize, imageSize, GameState.LUNG);
    stateChangingButtons.add(lungButton);
  
    image(heart, WIDTH/6, HEIGHT/5 + 350, imageSize, imageSize);
    rect(WIDTH/6 - 10, HEIGHT/5 + 340, outlineSize, outlineSize);
    StateChangingButton heartButton = new StateChangingButton(WIDTH/6, HEIGHT/5 + 350, imageSize, imageSize, GameState.HEART);
    stateChangingButtons.add(heartButton);
  
    image(kidney, WIDTH/3 +250, HEIGHT/5 + 350, imageSize, imageSize);
    rect(WIDTH/3 +240, HEIGHT/5 + 340, outlineSize, outlineSize);
    StateChangingButton kidneyButton = new StateChangingButton(WIDTH/3 +250, HEIGHT/5 + 350, imageSize, imageSize, GameState.KIDNEY);
    stateChangingButtons.add(kidneyButton);
   }
}
