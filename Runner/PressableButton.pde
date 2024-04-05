public class PressableButton { 
  /* 
    Class to make pressable buttons easier to implement
    Construction is the same syntax as rect()
    i.e. new PressableButton(x, y, width, height)
    Used for triggering events when mousePressed && onButton()
  */
    int startX;
    int endX;
    int startY;
    int endY;
    
    protected PressableButton(int x, int y, int buttonWidth, int buttonHeight){
      this.startX = x;
      this.endX = x + buttonWidth;
      this.startY = y;
      this.endY = y + buttonHeight;
    } 
    
    boolean onButton(){
       return ((mouseX >= this.startX && mouseX < this.endX) && (mouseY >= this.startY && mouseY < this.endY));
    }
    
    
}
