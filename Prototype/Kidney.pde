class Kidney extends GameMap {
    Kidney(PImage kidney) {
        this.background = kidney;
        
    }

    @Override
    void setup() {
        super.setup(); 
        
        try {
            pathMask = loadImage("route.png");  // Load new path mask image
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
        new Vector(0,  11),
        new Vector(14,  11),
        new Vector(14,  5),
        new Vector(10,  5),
        new Vector(10,  8),
        new Vector(5,  8),
        new Vector(5,  2),
        new Vector(15,  2),
        new Vector(15,  7),
        new Vector(19,  7),
 
  
      
    };
    mapPath = new Path(path);
  }
}
