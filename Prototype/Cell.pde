class Cell{
  int x;
  int y;
  boolean isPath = false;
  boolean buildable = true;
  
   Cell(int x, int y){
    this.x = x;
    this.y = y;
   }
  
  DefenceTower occupant;
  
  void buildOn(DefenceTower t){
    if (buildable() && !gameWindow.onButton()){
      this.occupant = t;
      System.out.println("Adding an occupant to: Grid[" +x+ "][" +y+"]");
      AllTowers.add(occupant); 
      this.buildable = false;
    }
  }
  
  boolean buildable(){
    return (this.buildable && !this.isPath);
  }
  
  void outline(){
    noFill();
    strokeWeight(4);
    
    if (buildable()){ 
       stroke(#00FF00); 
    } else { 
       stroke(#FF0000); 
    }
    rect(x * cellSize, y * cellSize, cellSize, cellSize);  
  }
  
  void confetti(color confetti, color outline){ // For the win screen, colours random changing bright colours on screen
    fill(confetti);
    strokeJoin(ROUND);
    strokeWeight(4);
    stroke(outline);
    rect(x * cellSize, y * cellSize, cellSize, cellSize); 
  }

  // Will need a similar method to confetti() for the lose screen but filled w/random changing germ images
  
  void setUnbuildable(){ // Called where a tower has been built
     this.buildable = false; 
  }

  void setPath(Vector v){ // Set the pathway at the start of the round
    Grid[v.x][v.y].isPath = true;
  }

}
