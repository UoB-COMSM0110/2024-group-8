class Heart extends GameMap {
    Heart(PImage heart) {
        this.background = heart;
        
    }

    @Override
    void setup() {
        super.setup(); 
        
        try {
            pathMask = loadImage("route2.png");  // Load new path mask image
            pathMask.resize(WIDTH, HEIGHT); 
            path.mask(pathMask); 
        } catch (Exception e) {
            println("Error loading image: " + e.getMessage());
        }
    }
    
    //@Override
    //void draw(){
    //  super.draw();
    //  try { // Please add implementation of map animation within this to avoid null pointer exception after game is won/lost:)
        
      
    //  } catch (Exception e) { System.out.println("Game is already won/lost"); }    
    //}
      
    @Override                                      //load new vector for new path
    void initalisePath() {
      Vector[] path = new Vector[]{
        new Vector(0, 1),
        new Vector(17,  1),
        new Vector(17,  4),
        new Vector(2,  4),
        new Vector(2,  7),
        new Vector(17,  7),
        new Vector(17,  10),
        new Vector(0,  10), 
  
      
    };
    mapPath = new Path(path);
  }
}
