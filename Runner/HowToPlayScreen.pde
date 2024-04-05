class HowToPlayScreen extends Display {
    GameState stateDesiredOnClose;
    PImage background;
    PImage exit;
    PImage previousPage;
    PImage nextPage;

    int pageIndex = 0;
    int lastPageTurn = 0;
    
    PImage body;
    PImage towerA;
    PImage towerB;


    HowToPlayScreen(){
        background = loadImage("startpage.png");
        background.resize(WIDTH, HEIGHT); // Resize the image to match window dimensions
        exit = loadImage("exit.png");
        previousPage = loadImage("previousPage.png");
        nextPage = loadImage("nextPage.png");
        body = loadImage("body.png");
        towerA = loadImage("tower/antibody.png");
        towerB = loadImage("tower/towerB.png");
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
        
        if (pageIndex == 0){ drawPage0(); }
        if (pageIndex == 1){ drawPage1(); }
        if (pageIndex == 2){ drawPage2(); }

    }
    
    void drawPage0(){
      image(body, 675, 150, 250, 250);
      
      textSize(40);
      fill(255);
      text("Help! Infection is threatening", 155 , 230);
      text("the body! You must stop", 175 , 300);
      text("the germs from taking over", 165, 370);
      
      image(towerB, 125, 455, 150, 150);
      text("To do so, place mighty", 385, 480);
      text("Antibody towers in the organs", 320, 550);
      text("to zap those pesky germs!", 350, 620 );
      
    }
    
    void drawPage1(){
      textSize(30);
      fill(255);
      text("----------------------------------------------------", 150 , 240);
      text("----------------------------------------------------", 150 , 330);
      text("----------------------------------------------------", 150, 420);
      text("----------------------------------------------------", 150, 510 );
      text("----------------------------------------------------", 150, 600);
    }
    
    void drawPage2(){
      textSize(30);
      fill(255);
      text("----------------------------------------------------", 150 , 240);
      text("----------------------------------------------------", 150 , 330);
      text("----------------------------------------------------", 150, 420);
      text("----------------------------------------------------", 150, 510 );
      text("----------------------------------------------------", 150, 600);
    }




}
