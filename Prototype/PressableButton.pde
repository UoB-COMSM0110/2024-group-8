public class PressableButton { 
  /* 
    Class to make pressable buttons easier to implement
    Consteruction is the same syntax as rect()
    i.e. new PressableButton(x, y, width, height)
    Used for triggering events when mousePressed && onButton()
  */
    int startX;
    int endX;
    int startY;
    int endY;
    
    //int width;
    //int height;
    
    //GameState requiredGameState;
    //boolean onScreen;
    //boolean lastClicked;
    
    protected PressableButton(int x, int y, int buttonWidth, int buttonHeight){
      this.startX = x;
      this.endX = x + buttonWidth;
      this.startY = y;
      this.endY = y + buttonHeight;
      
      //this.width = buttonWidth;
      //this.height = buttonHeight;
      //this.requiredGameState = current;
      //this.onScreen = false;
    } 
    
    //void drawButton(){
    //  determineIfOnScreen();
    //  if (onScreen){
    //    strokeWeight(8);
    //    strokeJoin(ROUND);
    //    stroke(255);
    //    noFill();
    //    rect(this.startX - 5, this.startY - 5, this.width + 5, this.height +5);
    //  }
    //  return;
    //}
    
    //void determineIfOnScreen(){
    //  GameState current = getCurrentGameState();
      
    //  if (this.requiredGameState.isGameMap() && current.isGameMap()){ // If the button is supposed to be displayed on GameMap screen
    //      onScreen = true;
    //  } else if (this.requiredGameState == current){ // Button is displayed at current GameState
    //    onScreen = true; 
    //  } else {
    //    onScreen = false;
    //  }   
    //}
    
    boolean onButton(){
       return ((mouseX >= this.startX && mouseX < this.endX) && (mouseY >= this.startY && mouseY < this.endY));
    }
    
    
}
