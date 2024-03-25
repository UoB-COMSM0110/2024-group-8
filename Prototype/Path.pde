class Path{
  Vector[] Pathway;
  Lane[] allLanes;
  Vector spawnPos;
  
  Vector getSpawn(){
    return spawnPos;
  }
  
  Direction getDire(int i){
    if (i < allLanes.length){
      return allLanes[i].dir;
    } else {
     return allLanes[allLanes.length-1].dir;
    }
  }
  
  PathStatus checkPos(Vector v, int lane){
    if (lane > allLanes.length-1) {
      return PathStatus.finished;
    }
    
    boolean check = allLanes[lane].checkPos(v);
    if (check){
      return PathStatus.next;
    } else {
      return PathStatus.stay;
    }
  }

  
  class Lane{
    int endPos;
    Direction dir;
    
    boolean checkPos(Vector v) {
        switch (dir){
          case up:
              return (endPos > v.y);
          case down:
              return (endPos < v.y);
          case left:
              return (endPos > v.x);
          case right:
              return (endPos < v.x);
          default:
            return false;
        }
    }
    
    Lane(Direction _dir, Vector cell){
      // Creates a 'lane' of pathway between the current cell and the next turning point
      dir = _dir;
      if (_dir == Direction.up || _dir == Direction.down){ 
        endPos = round(cellSize * cell.y);
      } else {
        endPos = round(cellSize * cell.x);
      }
    }
  }
  
  Path(Vector[] v) {
  Pathway = v;
  Direction[] directions = new Direction[v.length-1];
  spawnPos = new Vector((int)(v[0].x * cellSize), (int)(v[0].y * cellSize));

  for (int i = 0; i < v.length - 1; i++) {
    Grid[v[i].x][v[i].y].isPath = true;

    int difference = v[i].x - v[i + 1].x;
    // Difference is GridX position = a difference in width between path points
    // i.e., path is turning right/left
    if (difference  != 0) {//using x
      for (int j = 0; j < abs(difference); j++) {
        if (difference < 0) {
          Grid[v[i].x + j][v[i].y].isPath = true; // Turning right
          directions[i]  = Direction.right;
        } else {
          Grid[v[i].x - j][v[i].y].isPath = true; // Turning left
          directions[i]  = Direction.left;
        }
      }
    } else { 
      // Difference is GridY position = a difference in height between path points
      // i.e., path is moving up/down
      difference = v[i].y - v[i + 1].y;

      for (int j = 0; j < abs(difference); j++) {
        if (difference < 0){
          Grid[v[i].x][v[i].y + j].isPath = true; // Moving down
          directions[i]  = Direction.down;
        } else {
          Grid[v[i].x][v[i].y - j].isPath = true;// Moving up
          directions[i]  = Direction.up;
        }
      }
    }
  }

  if (v.length > 0){
    Grid[v[v.length - 1].x][v[v.length - 1].y].isPath = true;
  }
  
  allLanes = new Lane[directions.length];
  for(int i = 0; i < allLanes.length; i++){
    allLanes[i] = new Lane(directions[i], v[i+1]);
  }
}
  
}
