class TitleScreen extends Display {
    PImage startPageBackground;
    boolean isStartButtonHovered = false; // Track if the start button is being hovered over
    float titleX; // X position of the title for animation
    float titleY; // Y position of the title for animation
    float titleTargetX; // Target X position of the title for animation
    float titleTargetY; // Target Y position of the title for animation
    float titleSpeed = 5; // Speed of title animation (increased)
    PImage germL;
    PImage germR;

    void setup(){
        startPageBackground = loadImage("startpage.png");
        startPageBackground.resize(WIDTH, HEIGHT); // Resize the image to match window dimensions

        // Load germ image
        germ = loadImage("germ.png");
        germ.resize(20, 20);
        // Set initial position for the germ character
        germX = width / 2;
        germY = height / 2;

        // Set initial position for the title
        titleX = -500; // Offscreen initially
        titleY = HEIGHT/4;
        titleTargetX = WIDTH/8 - 50;
        titleTargetY = HEIGHT/4;
        
        germL = loadImage("germ/germ4L.png");
        germL.resize(WIDTH/5, HEIGHT/5);
        germR = loadImage("germ/germ4R.png");
        germR.resize(WIDTH/5, HEIGHT/5);
    }

    void draw(){
    background(startPageBackground);
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
    
    

    //Draw start button with animation
    if (isStartButtonHovered) {
        fill(173, 224, 255); // Lighter color when hovered over
        image(germR, WIDTH/2 - 350, HEIGHT/2);
    } else {
        fill(153, 204, 255);
        image(germL, WIDTH/2 - 350, HEIGHT/2);
    }
    strokeWeight(8);
    strokeJoin(ROUND);
    stroke(153, 204, 255);
    rect(WIDTH/2 - 100, HEIGHT/2, 200, 60);
    StateChangingButton startButton = new StateChangingButton(WIDTH/2 - 100, HEIGHT/2, 200, 60, GameState.MAP);
    stateChangingButtons.add(startButton);

    fill(255);
    textSize(40);
    text("START", WIDTH/2 - 62 , HEIGHT/2 + 42);

    // Check if the mouse is over the start button
    if (mouseX >= WIDTH/2 - 100 && mouseX <= WIDTH/2 + 100 &&
        mouseY >= HEIGHT/2 && mouseY <= HEIGHT/2 + 60) {
        isStartButtonHovered = true;
    } else {
        isStartButtonHovered = false;
    }
}

}
