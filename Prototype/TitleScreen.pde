class TitleScreen extends Display {
    PImage startPageBackground;
    boolean isStartButtonHovered = false; // Track if the start button is being hovered over
    float titleX; // X position of the title for animation
    float titleY; // Y position of the title for animation
    float titleTargetX; // Target X position of the title for animation
    float titleTargetY; // Target Y position of the title for animation
    float titleSpeed = 3; // Speed of title animation (increased)
    PImage germL;
    PImage germR;

    void setup(){
        startPageBackground = loadImage("startpage.png");
        startPageBackground.resize(width, height); // Resize the image to match window dimensions

        // Load germ image
        germ = loadImage("germ.png");
        germ.resize(20, 20);
        // Set initial position for the germ character
        germX = width / 2;
        germY = height / 2;

        // Set initial position for the title
        titleX = -500; // Offscreen initially
        titleY = HEIGHT/4;
        titleTargetX = WIDTH/8 - 85;
        titleTargetY = HEIGHT/4;
    }

    void draw(){
    background(startPageBackground);
    //background(255);
    image(germ, germX, germY);
    textFont(font);
    textSize(80);
    fill(255);
    
    // Animate the title
    if (titleX < titleTargetX) {
        titleX += titleSpeed; // Move towards the target X position
    }
    if (titleY != titleTargetY) {
        titleY = titleTargetY; // Ensure Y position matches the target Y position
    }
    
    text("Immune System Defence", titleX, titleY);
    
    StateChangingButton startButton = new StateChangingButton(WIDTH/2 - 100, HEIGHT/2, 200, 60, GameState.MAP);
    stateChangingButtons.add(startButton);

    //Draw start button with animation
    if (startButton.onButton()) {
        fill(173, 224, 255); // Lighter color when hovered over
    } else {
        fill(153, 204, 255);
    }
    strokeWeight(8);
    strokeJoin(ROUND);
    stroke(153, 204, 255);
    rect(WIDTH/2 - 100, HEIGHT/2, 200, 60);
    fill(255);
    textSize(40);
    text("START", WIDTH/2 - 62 , HEIGHT/2 + 44);

    // Draw how to play button 
    PressableButton howToPlayButton = new PressableButton(WIDTH/2 - 80, HEIGHT/2 +100, 160, 60);
    if (howToPlayButton.onButton()) {
        fill(255, 153, 153); // Lighter color when hovered over
    } else {
        fill(255, 102, 102);
    }

    stroke(255, 102, 102);
    rect(WIDTH/2 - 90, HEIGHT/2 +100, 180, 50);
    fill(255);
    textSize(30);
    text("TUTORIAL", WIDTH/2 - 75 , HEIGHT/2 + 135);
    if (mousePressed && howToPlayButton.onButton()){
        howToPlayScreen.setup(currentGameState);
        currentGameState = GameState.HOWTO;
    }
}

}
