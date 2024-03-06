class GameMap{
  /*
     Starting point for the GameMap class
     Still need to:
       - Make unique paths for each map that follow the background image nicely
       - Implement final boss for each map
       - Implement twist for each map
  */
  
  float playWindowHeight = WIDTH * 0.65;
  float cellSize = WIDTH / 20;
  float menuPosY = playWindowHeight + 1;
  float menuHeight = HEIGHT - menuPosY;
  PImage background;
  PImage path;
  PImage pathMask;
  PImage towerA;
  
  void setup(){
    // Initialize grid
    for (int x = 0; x < Grid.length; x++){
       for (int y = 0; y < Grid[0].length; y++){
          Grid[x][y] = new Cell(x, y);
       }
    }
    
    path();
    
    try {
      this.background.resize(WIDTH, HEIGHT);
      path = loadImage("whiteBG.png");
      path.resize(WIDTH, HEIGHT);
      pathMask = loadImage("route.png");
      pathMask.resize(WIDTH, HEIGHT);
      path.mask(pathMask);
      
      towerA = loadImage("tower/antibody.png");
    } catch (Exception e) {
      println("Error loading image: " + e.getMessage());
    }
  }

  void draw() {
    image(background, 0, 0, width, playWindowHeight);
    image(path, 0, 0, width, playWindowHeight);
    
    image(towerA, 50, height*0.85, 100, 100);
    towerAButton = new PressableButton(50, (int)(height*0.85), 100, 100);
    
    fill(255);
    rect(800, (int)(height*0.85), 150, 100);
    startRoundButton = new PressableButton(800, (int)(height*0.85), 150, 100);
    fill(0);
    textSize(40);
    text("START", 825, (int)(height*0.90));
    text("ROUND", 815, (int)(height*0.95));
    
    for (int i = 0; i < AllTowers.size(); i++){  // Changed length to size()
       AllTowers.get(i).drawme();  // Changed AllToweers to AllTowers
    }
     
    for (int i = 0; i< AllGerms.size(); i++){ 
        AllGerms.get(i).move(); 
    } 
   
  }
  
  void path(){   
    Vector[] path = new Vector[]{
    new Vector( 0,  5),
    new Vector( 3,  5),
    new Vector( 3,  8),
    new Vector( 1,  8),
    new Vector( 1,  11),
    new Vector( 9,  11),
    new Vector( 9,  8),
    new Vector( 6,  8),
    new Vector( 6,  3),
    new Vector( 10,  3),
    new Vector( 10,  5),
    new Vector( 11,  5),
    new Vector( 11,  10),
    new Vector( 14,  10),
    new Vector( 14,  8),
    new Vector( 17,  8),
    new Vector( 17,  5),
    new Vector( 13,  5),
    new Vector( 13,  0),     
    }; 
    
    mapPath = new Path(path);
    Grid[0][0].setUnbuildable();
    Grid[1][0].setUnbuildable();
    Grid[0][2].setUnbuildable();
    Grid[1][2].setUnbuildable();
    Grid[0][3].setUnbuildable();
  }
  
  
}
