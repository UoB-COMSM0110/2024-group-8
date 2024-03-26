class TitleScreen extends Display {
    PImage startPageBackground;
    boolean isStartButtonHovered = false; // Track if the start button is being hovered over

    void setup(){
        startPageBackground = loadImage("startpage.png");
        startPageBackground.resize(WIDTH, HEIGHT); // Resize the image to match window dimensions

        // Load germ image
        germ = loadImage("germ.png");
        germ.resize(20, 20);
        // Set initial position for the germ character
        germX = width / 2;
        germY = height / 2;
    }

    void draw(){
        background(startPageBackground);
        image(germ, germX, germY);
        textFont(font);
        textSize(80);
        fill(255);
        text("Immune System Defence", WIDTH/8 - 50, HEIGHT/4);
        
        
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
        text("START", WIDTH/2 - 62 , HEIGHT/2 + 42);
    }
}
