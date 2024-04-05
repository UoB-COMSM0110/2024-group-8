class TowerButton extends PressableButton {
  GameState requiredGameState;
  DefenceTower tower;
  
  TowerButton(int x, int y, int buttonWidth, int buttonHeight, DefenceTower towerForSelection){
    super(x, y, buttonWidth, buttonHeight);
    this.requiredGameState = currentGameState;
    this.tower = towerForSelection;
  }

  void selectTower(){
    if (currentGameState == requiredGameState && onButton()){
        currentGameMap.setSelectedTower(tower, true);
    } 
  }      
}
