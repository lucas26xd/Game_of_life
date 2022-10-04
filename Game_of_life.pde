int grid[][];
int resolution = 10;

void setup(){
  size(600, 400);
  //background(0);
  stroke(200);
  
  grid = new int[width/resolution][height/resolution];
  for(int i = 0; i < grid.length; i++){
    for(int j = 0; j < grid[i].length; j++){
      grid[i][j] = int(random(2));
      //print(grid[i][j]);
    }
  }
  
}

void draw(){
  for(int i = 0; i < grid.length; i++){
    for(int j = 0; j < grid[i].length; j++){
      rect(resolution * i, resolution * j, resolution, resolution);
      fill(grid[i][j] * 255);
    }
  }
}
