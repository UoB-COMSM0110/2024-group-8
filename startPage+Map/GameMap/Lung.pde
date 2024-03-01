class Lung extends Map{
  PImage background_lung;


  Lung() {
    // Initialize grid
    for (int x = 0; x < Grid.length; x++) {
      for (int y = 0; y < Grid[0].length; y++) {
        Grid[x][y] = 0; 
      }
    }
    
    try {
      background_lung = loadImage("lungmap.png");
      background_lung.resize(WIDTH, HEIGHT);

      path = loadImage("whiteBG.png");
      path.resize(WIDTH, HEIGHT);
      pathMask = loadImage("route.png");
      pathMask.resize(WIDTH, HEIGHT);
      path.mask(pathMask);
    } catch (Exception e) {
      println("Error loading image: " + e.getMessage());
    }
  }

  void draw() {
    image(background_lung, 0, 0, width, playWindowHeight);
    image(path, 0, 0, width, playWindowHeight);
  }
  
  
  
  void path(){   
    Vector[] Path = new Vector[]{
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
  }
  
}
