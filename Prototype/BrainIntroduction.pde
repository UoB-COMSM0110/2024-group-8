class BrainIntroduction extends Display {
    PImage background;
    PImage frame;
    PImage brainintro;
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
       // this.frame = loadImage("brainframe.png");
       // this.frame.resize(850, 850);
        this.brainintro = loadImage("brainintroo.png");
        this.brainintro.resize(700, 700);


       // this.understoodButton = loadImage("understood.png");
      //  this.understoodButton.resize(buttonWidth, buttonHeight); // Resize the button image
    }
    

    boolean draw(){
        // Waits before detecting user input
        if ((this.entryTime == 0) || (millis()-entryTime) > 100000) {
            entryTime = millis();
        }
       
        background(background);
        image(brainintro, 120, 40);
        //image(frame, 100, 0.5); 
        fill(255);
        //textSize(20);
        //text("Enter the cerebral battlefield, where the stakes are high and time is ticking. ", 200, 220);
        //textSize(20);
        //text("The brain faces imminent danger from an aneurysm, and only your strategic prowess can save it.", 200, 320);
        textSize(40);
        //text("Press S to start", 350, 620);

        
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
