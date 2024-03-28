public class PressableButton {
    /*
      Class to make pressable buttons easier to implement
      Construction is the same syntax as rect()
      i.e. new PressableButton(x, y, width, height)
      Used for triggering events when mousePressed && onButton()
    */
    Runner runner;
    int startX;
    int endX;
    int startY;
    int endY;

    protected PressableButton(int x, int y, int buttonWidth, int buttonHeight, Runner runner) {
        this.runner = runner;
        this.startX = x;
        this.endX = x + buttonWidth;
        this.startY = y;
        this.endY = y + buttonHeight;
    }

    boolean onButton() {
        return ((runner.mouseX >= this.startX && runner.mouseX < this.endX) && (runner.mouseY >= this.startY && runner.mouseY < this.endY));
    }


}
