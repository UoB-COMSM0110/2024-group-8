class BrainIntroduction extends Display {
    PImage background;
    PImage frame;
//    PImage understoodButton;
    
    int entryTime;
    boolean buttonPressed = false; // Track whether the button has been pressed
   /* 
    // Define button coordinates and size
    int buttonX = 160;
    int buttonY = 160;
    int buttonWidth = 600;
    int buttonHeight = 150;
*/
    BrainIntroduction(){
        this.background = loadImage("brainintro.png");
        this.background.resize(width, height);
        this.frame = loadImage("brainframe.png");
        this.frame.resize(650, 650);

       // this.understoodButton = loadImage("understood.png");
      //  this.understoodButton.resize(buttonWidth, buttonHeight); // Resize the button image
    }
    

    boolean draw(){
        // Waits before detecting user input
        if ((this.entryTime == 0) || (millis()-entryTime) > 100000) {
            entryTime = millis();
        }
        
        background(background);
        image(frame, 160, 100); 
        fill(255);
        textSize(40);
        text("Press S to start", 350, 420);

        
        // Draw the button
       // image(understoodButton, buttonX, buttonY);
        
        int timeOnScreen = (millis() - this.entryTime);
        
        if(timeOnScreen > 1000){
            if(keyPressed && key == 's' || key == 'S'){ // Check if 'S' key is pressed
           currentGameMap = brainMap;
           brainMap.draw();
           mouseCheck();
      
              }
        }
        
        if(buttonPressed){
            return true; // Return true when button is pressed to indicate introduction is finished
        } else {
            return false; // Return false if the introduction is still ongoing
        }
    }
}
