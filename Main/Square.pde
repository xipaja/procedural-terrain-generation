import controlP5.*;
import java.util.Map;

class Square extends Base{
  //color squareColor;
  //int size;
  //int stroke;
  // count for color hashmap
  int visitCount;
  int startSeed;
  boolean hasStroke = false;
  //float spacing;
  //PVector position;
  
  Square(){
    shapeColor = color(160, 106, 196);
    position = new PVector(1200, 1000);
  }
 
  // Update square position
  void Update(){
    int randomNum = (int)random(0, 5);
    
    switch(randomNum){
      case 1:
      // Move up
        position.y -= size * spacing;
        break;
      case 2:
      // Move right
        position.x += size * spacing;
        break;
      case 3:
      // Move down
        position.y += size * spacing;
        break;
      case 4:
      // Move left
        position.x -= size * spacing;
        break;
    } 
  }
  
  // Draw square based on color, stroke, size, location
  void Draw(){
    rectMode(CENTER);
    fill(shapeColor);
    rect(position.x, position.y, size, size);
    
    if(!hasStroke){
      noStroke();
    } else{
      stroke(strokeColor);
    }
  }
  
  void getTerrainColor(){    
   for(PVector position : squareHash.keySet()){
     if(squareHash.get(position) < 4){
       shapeColor = color(160, 126, 84);
     }
     else if(squareHash.get(position) < 7){
       shapeColor = color(143, 170, 64);
     }
     else if(squareHash.get(position) < 10){
        shapeColor = color(134, 134, 134);  
     }
     else{
       if(shapeColor > color(255)){
           shapeColor = color(255);
        }
        shapeColor = color(visitCount * 20);
     } 
    } 
   }
    
}
