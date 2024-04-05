class Heart extends GameMap {
    Heart(PImage heart) {
        this.background = heart;
        
    }

    @Override
    void setup() {
        super.setup(); 
        
        try {
            path = loadImage("routeHeart.png");  // Load new path mask image
            path.resize(WIDTH, HEIGHT); 
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
        new Vector(0, 3),
        new Vector(17,  3),
        new Vector(17,  10),
        new Vector(2,  10),
        new Vector(2,  6),
        new Vector(19,  6),
  
      
    };
    mapPath = new Path(path);
  }
}
