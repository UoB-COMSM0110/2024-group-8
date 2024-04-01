class HowToPlayScreen extends Display {
    GameState stateDesiredOnClose;
    PImage background;
    PImage exit;
    PImage previousPage;
    PImage nextPage;

    int pageIndex = 0;


    HowToPlayScreen(){
        background = loadImage("startpage.png");
        background.resize(WIDTH, HEIGHT); // Resize the image to match window dimensions
        exit = loadImage("exit.png");
        previousPage = loadImage("previousPage.png");
        nextPage = loadImage("nextPage.png");
    }

    void setup(GameState previous){
        stateDesiredOnClose = previous;
    }

    void draw(){
        background(background);
        strokeWeight(8); 
        strokeJoin(ROUND);
        stroke(255);
        fill(153, 204, 255);
        rect(80, 80, 840, 640);
        
        fill(255);
        textSize(50);
        text("HOW TO PLAY", 320, 140);
        strokeWeight(4);
        stroke(255);
        line(310, 155, 675, 155);
        
        PressableButton exitButton = new PressableButton(90, 90, 30, 30);
        PressableButton previousPageButton = new PressableButton(100, 640, 60, 60);
        PressableButton nextPageButton = new PressableButton(840, 640, 60, 60);
        
        if (exitButton.onButton()){
           image(exit, 85, 85, 40, 40);
           if (mousePressed){ 
             currentGameState = stateDesiredOnClose;
           }
        } else {
           image(exit, 90, 90, 30, 30);
        }
        
        if (previousPageButton.onButton()){
           image(previousPage, 90, 630, 80, 80);
           if (mousePressed && pageIndex > 0){ 
             pageIndex--;
           }
        } else {
           image(previousPage, 100, 640, 60, 60);
        }
        
        if (nextPageButton.onButton()){
           image(nextPage, 830, 630, 80, 80);
           if (mousePressed && pageIndex < 2){ 
             pageIndex++;
           }
        } else {
           image(nextPage, 840, 640, 60, 60);
        }
        
        if (pageIndex == 0){ drawPage0(); }
        if (pageIndex == 1){ drawPage1(); }
        if (pageIndex == 2){ drawPage2(); }

    }
    
    void drawPage0(){
    }
    
    void drawPage1(){
    }
    
    void drawPage2(){
    }




}
