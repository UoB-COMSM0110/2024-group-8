class Cell{
  int x;
  int y;
  boolean isPath = false;
  
   Cell(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  DefenceTower occupant = null;
  
  void buildOn(DefenceTower t){
    if (buildable()){
      occupant = t;
      AllTowers.add(occupant); 
       System.out.println("Tower built!");
    }
  }
  
  DefenceTower getOccupant(){
    return this.occupant;
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
    strokeWeight(4);
    if(buildable())stroke(#00FF00);
    else stroke(#FF0000);
    rect(x * cellSize, y * cellSize, cellSize, cellSize);  
  }
  
  void confetti(color confetti, color outline){
    fill(confetti);
    strokeJoin(ROUND);
    strokeWeight(4);
    stroke(outline);
    rect(x * cellSize, y * cellSize, cellSize, cellSize); 
  }
  
  void setUnbuildable(){
     this.isPath = true;
  }

}
