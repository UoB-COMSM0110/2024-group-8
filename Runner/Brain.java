
//////*****I know the new path doesn't look so great, it's just for testing, I will try to find other more interesting path for each map :)*****//////////

import processing.core.*;

public class Brain extends GameMap {
    Brain(PImage brain, Runner runner) {
        super(runner);
        this.background = brain;
        //this.pathMask = runner.loadImage("data/route2.png");
    }

    @Override
    public void setup() {
        super.setup();

        try {
            pathMask = runner.loadImage("data/route2.png");  // Load new path mask image
            pathMask.resize(runner.WIDTH, runner.HEIGHT);
            path.mask(pathMask);
        } catch (Exception e) {
            System.out.println("Error loading image Brain: " + e.getMessage());
        }
    }

    @Override                                      //load new vector for new path
    public void initialisePath() {
        Vector[] path = new Vector[]{
                new Vector(0, 1),
                new Vector(17, 1),
                new Vector(17, 4),
                new Vector(2, 4),
                new Vector(2, 7),
                new Vector(17, 7),
                new Vector(17, 10),
                new Vector(0, 10)
        };
        runner.mapPath = new Path(path, runner);
    }
}
