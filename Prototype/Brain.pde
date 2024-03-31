class Brain extends GameMap {
    Brain(PImage brain) {
        this.background = brain;
        //this.pathMask = loadImage("route2.png"); 
        
    }

    @Override
    void setup() {
        super.setup(); 

        try {
            path = loadImage("route3.png");
            path.resize(WIDTH, HEIGHT);
            //pathMask = loadImage("route3.png");  // Load new path mask image
            //pathMask.resize(WIDTH, HEIGHT); 
            //path.mask(pathMask); 
        } catch (Exception e) {
            println("Error loading image: " + e.getMessage());
        }
    }
    
    @Override                                      //load new vector for new path
    void initalisePath() {
      Vector[] path = new Vector[]{
        new Vector(0, 3),
        new Vector(8,  3),
        new Vector(8,  1),
        new Vector(12,  1),
        new Vector(12,  3),
        new Vector(13,  3),
        new Vector(13,  6),
        new Vector(10,  6),
        new Vector(10,  4),
        new Vector(9,  4),
        new Vector(9,  8),
        new Vector(12,  8),
        new Vector(12,  12),
  
      
    };
    mapPath = new Path(path);
  }
}
