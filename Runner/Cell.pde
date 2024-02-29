class Cell{
  int x;
  int y;
  
  boolean isPath = false;
  
  
  Tower occupant = null;
  
  void buildOn(Tower t){
    if (buildable()){
      occupant = t;
      AllTowers.add(occupant); 
    }
  }
  
  
  boolean buildable(){
    if (occupant == null && !isPath){
      return true;
    } else {
      return false;
    }
  }
  
  void outline(){
    noFill();
    if(buildable())stroke(#00FF00);
    else stroke(#FF0000);
    rect(x * cellSize, y * cellSize, cellSize, cellSize);  
  }
    
  
 Cell(int x, int y){
    this.x = x;
    this.y = y;
  }

}
