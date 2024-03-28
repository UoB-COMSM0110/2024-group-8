import processing.core.*;

public class Path {
    Runner runner;
    Vector[] Pathway;
    Lane[] allLanes;
    Vector spawnPos;

    Vector getSpawn() {
        return spawnPos;
    }

    Direction getDire(int i) {
        if (i < allLanes.length) {
            return allLanes[i].dir;
        } else {
            return allLanes[allLanes.length - 1].dir;
        }
    }

    PathStatus checkPos(Vector v, int lane) {
        if (lane > allLanes.length - 1) {
            return PathStatus.finished;
        }

        boolean check = allLanes[lane].checkPos(v);
        if (check) {
            return PathStatus.next;
        } else {
            return PathStatus.stay;
        }
    }


    public class Lane {
        int endPos;
        Direction dir;

        boolean checkPos(Vector v) {
            return switch (dir) {
                case up -> (endPos > v.y);
                case down -> (endPos < v.y);
                case left -> (endPos > v.x);
                case right -> (endPos < v.x);
                default -> false;
            };
        }

        Lane(Direction _dir, Vector cell) {
            // Creates a 'lane' of pathway between the current cell and the next turning point
            dir = _dir;
            if (_dir == Direction.up || _dir == Direction.down) {
                endPos = PApplet.round(runner.cellSize * cell.y);
            } else {
                endPos = PApplet.round(runner.cellSize * cell.x);
            }
        }
    }

    Path(Vector[] v, Runner runner) {
        this.runner = runner;
        Pathway = v;
        Direction[] directions = new Direction[v.length - 1];
        spawnPos = new Vector((int) (v[0].x * runner.cellSize), (int) (v[0].y * runner.cellSize));

        for (int i = 0; i < v.length - 1; i++) {
            runner.Grid[v[i].x][v[i].y].isPath = true;

            int difference = v[i].x - v[i + 1].x;
            // Difference is GridX position = a difference in width between path points
            // i.e., path is turning right/left
            if (difference != 0) {//using x
                for (int j = 0; j < PApplet.abs(difference); j++) {
                    if (difference < 0) {
                        runner.Grid[v[i].x + j][v[i].y].isPath = true; // Turning right
                        directions[i] = Direction.right;
                    } else {
                        runner.Grid[v[i].x - j][v[i].y].isPath = true; // Turning left
                        directions[i] = Direction.left;
                    }
                }
            } else {
                // Difference is GridY position = a difference in height between path points
                // i.e., path is moving up/down
                difference = v[i].y - v[i + 1].y;

                for (int j = 0; j < PApplet.abs(difference); j++) {
                    if (difference < 0) {
                        runner.Grid[v[i].x][v[i].y + j].isPath = true; // Moving down
                        directions[i] = Direction.down;
                    } else {
                        runner.Grid[v[i].x][v[i].y - j].isPath = true;// Moving up
                        directions[i] = Direction.up;
                    }
                }
            }
        }

        if (v.length > 0) {
            runner.Grid[v[v.length - 1].x][v[v.length - 1].y].isPath = true;
        }

        allLanes = new Lane[directions.length];
        for (int i = 0; i < allLanes.length; i++) {
            allLanes[i] = new Lane(directions[i], v[i + 1]);
        }
    }

}
