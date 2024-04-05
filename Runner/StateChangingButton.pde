class StateChangingButton extends PressableButton {
  GameState requiredGameState;
  GameState desiredStateOnPress;
  
  
  StateChangingButton(int x, int y, int buttonWidth, int buttonHeight, GameState desired){
    super(x, y, buttonWidth, buttonHeight);
    this.requiredGameState = currentGameState;
    this.desiredStateOnPress = desired;
  }

  void changeStates(){
    if (this.onButton() && (currentGameState == this.requiredGameState)){
      currentGameState = desiredStateOnPress;
    }  
  }      
}
