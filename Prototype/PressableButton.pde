public class PressableButton { 
  /* 
    Class to make pressable buttons easier to implement
    Consteruction is the same syntax as rect()
    i.e. new PressableButton(x, y, width, height)
    Will make it so that pressing anywhere in that space can trigger an event
  */
    int startX;
    int endX;
    int startY;
    int endY;
    
    protected PressableButton(int x, int y, int width, int height){
      this.startX = x;
      this.endX = x + width;
      this.startY = y;
      this.endY = y + height;
    } 
    
    boolean onButton(){
       return ((mouseX >= this.startX && mouseX < this.endX) && (mouseY >= this.startY && mouseY < this.endY));
    }
}
