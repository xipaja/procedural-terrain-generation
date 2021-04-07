import controlP5.*;

public abstract class Base
{
  int maxSteps;
  int stepsTaken;
  int stepDistance;
  int stepScale; //step size aka width/height of square
  boolean hasTerrainColor;
  boolean hasStroke;
  int boundaries;
  
  int size;
  float spacing;
  PVector position;
  int strokeColor;
  int startSeed;
  int shapeColor;
  
  void Update(){
  }
  
  void Draw(){
  }
  
  void getTerrainColor(){
  }
  
}//end base class
