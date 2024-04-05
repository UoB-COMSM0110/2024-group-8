class MapSelection extends Display {
    PImage startPageBackground;
    int imageSize = 200; // Define imageSize here

    void setup(){
        startPageBackground = loadImage("startpage.png");
        startPageBackground.resize(WIDTH, HEIGHT); // Resize the image to match window dimensions

        // Load and resize organ images
        brain = loadImage("brain.png");
        brain.resize(imageSize, imageSize);

        lung = loadImage("lung.png");
        lung.resize(imageSize, imageSize);

        heart = loadImage("heart.png");
        heart.resize(imageSize, imageSize);

        kidney = loadImage("kidney.png");
        kidney.resize(imageSize, imageSize);
        
        backButton = loadImage("backButton.png");
        
        //backButton.resize(imageSize/3, imageSize/3);

    }

      void draw(){
      background(startPageBackground);
      image(germ, germX, germY);
  
      textSize(40);
      fill(255);
      text("Choose which organ to defend:", WIDTH/5, HEIGHT/4 - 25);
  
      int outlineSize = imageSize + 20;
  
      strokeWeight(8); // Format for squares outlining the map images
      strokeJoin(ROUND);
      stroke(255);
      noFill();
  
      // Display map images and make them pressable buttons
      handleMapSelection(brain, WIDTH/6, HEIGHT/5 + 50, outlineSize, GameState.BRAIN);
      handleMapSelection(lung, WIDTH/3 + 250, HEIGHT/5 + 50, outlineSize, GameState.LUNG);
      handleMapSelection(heart, WIDTH/6, HEIGHT/5 + 350, outlineSize, GameState.HEART);
      handleMapSelection(kidney, WIDTH/3 + 250, HEIGHT/5 + 350, outlineSize, GameState.KIDNEY);
      
      BackButton(backButton, WIDTH/50, HEIGHT/50, 100, GameState.TITLE);
  }


    // Handle map selection and animate the selected map
    void handleMapSelection(PImage mapImage, int x, int y, int outlineSize, GameState state){
        // Check if mouse is over the map image
        if (mouseX >= x - 10 && mouseX <= x + outlineSize && 
            mouseY >= y - 10 && mouseY <= y + outlineSize) {
            image(mapImage, x - 5, y - 5, outlineSize + 10, outlineSize + 10); // Scale up slightly
            if (mousePressed) {
                currentGameState = state; // Change game state if the map is clicked
            }
        } else {
            image(mapImage, x+5, y+5, imageSize, imageSize); // Normal size if not hovered
        }
        //rect(x - 10, y - 10, outlineSize, outlineSize); // Draw outline
    }
    
    void BackButton(PImage mapImage, int x, int y, int outlineSize, GameState state){
        // Check if mouse is over the map image
        if (mouseX >= x - 10 && mouseX <= x + 70 && 
            mouseY >= y - 10 && mouseY <= y + 70) {
            image(mapImage, x-20 , y-20 , 110, 110); // Scale up slightly
            if (mousePressed) {
                currentGameState = state; // Change game state if the map is clicked
            }
        } else {
            image(mapImage, x, y, 70, 70); // Normal size if not hovered
        }
    }
}
