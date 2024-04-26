class HowToPlayScreen extends Display {
    GameState stateDesiredOnClose;
    
    PImage background1;
    PImage background2;
    PImage background3;

    PImage exit;
    PImage previousPage;
    PImage nextPage;

    int pageIndex = 0;
    int lastPageTurn = 0;
    
  
        
    HowToPlayScreen(){
      
        background1 = loadImage("screen1.png");
        background1.resize(width, height); // Resize the image to match window dimensions
        background2 = loadImage("screen2.png");
        background2.resize(width, height); // Resize the image to match window dimensions
        background3 = loadImage("screen3.png");
       background3.resize(width, height); // Resize the image to match window dimensions

        exit = loadImage("exit.png");
        previousPage = loadImage("previousPage.png");
        nextPage = loadImage("nextPage.png"); 
    }

    void setup(GameState previous){
        stateDesiredOnClose = previous;
    }

    void draw(){
      if (pageIndex == 0) {
          background(background1);
      } else if (pageIndex == 1) {
          background(background2);
      } else if (pageIndex == 2) {
          background(background3);
      }       
        
        fill(255);
        textSize(50);
        text("HOW TO PLAY", 320, 140);
        strokeWeight(4);
        stroke(255);
        line(310, 155, 675, 155);
        
        textSize(30);
        text("PAGE  " +(pageIndex+1) + " / 3", 750, 120);
        
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
           if (mousePressed && (pageIndex > 0) && (millis()-lastPageTurn) >= 1000){ 
             pageIndex--;
             lastPageTurn = millis();
           }
        } else {
           image(previousPage, 100, 640, 60, 60);
        }
        
        if (nextPageButton.onButton()){
           image(nextPage, 830, 630, 80, 80);
           if (mousePressed && (pageIndex < 2) && (millis()-lastPageTurn) >= 500){ 
             pageIndex++;
             lastPageTurn = millis();
           }
        } else {
           image(nextPage, 840, 640, 60, 60);
        }
        
  

    }
    
  
}
