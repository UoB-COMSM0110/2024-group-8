class TitleScreen extends Display {
    PImage startPageBackground;

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
        
        //Draw start button
        strokeWeight(8);
        strokeJoin(ROUND);
        fill(153, 204, 255);
        stroke(153, 204, 255);
        rect(WIDTH/2 - 100, HEIGHT/2, 200, 60);
        StateChangingButton startButton = new StateChangingButton(WIDTH/2 - 100, HEIGHT/2, 200, 60, GameState.MAP);
        stateChangingButtons.add(startButton);
    
        fill(255);
        //textSize(30);
        //text("Click to Start!", WIDTH/2 - 92 , HEIGHT/2 + 40);
    
        textSize(40);
        text("START", WIDTH/2 - 62 , HEIGHT/2 + 42);
    
        // if (mousePressed && startButton.onButton()){
        //    currentGameState = GameState.MAP;
        //    MapSelection.draw();
        // }
    }
}
