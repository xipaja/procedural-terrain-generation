import controlP5.*;
import java.util.Map;

class Hexagon extends Base {
  //color hexColor;
  //int size;
  //int stroke;
  int hexCount;
  //int startSpeed;
  //float spacing;
  
  boolean hasStroke = false;
  
  //PVector position;
  
  Hexagon(){
    // Starting color and position - TODO: random positioning
    shapeColor = color(169, 106, 196);
    position =  new PVector(1200, 1000);
  }
  
  // Update hex position
  void Update(){
    int randomNum = (int)random(0, 7);
    println("Random number: ", randomNum);
       
    switch(randomNum){
      case 1:
        position.x += 2 * size * spacing;
        position.y += sqrt(3) * size * spacing;
        break;
      case 2:
        // should this be 2r?
        position.y += sqrt(3) * size * spacing;
        break;
      case 3:
        position.x -= 2 * size * spacing;
        position.y += sqrt(3) * size * spacing;
        break;
      case 4:
        position.x -= 2 * size * spacing;
        position.y -= sqrt(3) * size * spacing;
        break;
      case 5:
        position.y -= 2 * sqrt(3) * size * spacing;
        break;
      case 6:
        position.x += 2 * size * spacing;
        position.y -= sqrt(3) * size * spacing;
        break;
    }
    
  }
  
  // Draw hex based on color, stroke, size, location
  void Draw(){
    fill(shapeColor);
    drawHexShape(position.x, position.y, size, 6);
    
    if(!hasStroke){
      noStroke();
    }
    else{
     stroke(strokeColor); 
    }
  }
  
  void drawHexShape(float x, float y, int size, float numPoints){
    float angle = TWO_PI/numPoints;
    beginShape();
    
    for(float ang = 0; ang < TWO_PI; ang += angle){
      float sx = x + cos(ang) * size;
      float sy = y + sin(ang) * size;
      vertex(sx, sy);
    }
    
    endShape(CLOSE);
  }
  
  void getTerrainColor(){   
   for (PVector position : hexHash.keySet()){
     if(hexHash.get(position) < 4){
       shapeColor = color(160, 126, 84);
     }
     else if(hexHash.get(position) < 7){
       shapeColor = color(143, 170, 64); 
     }
     else if(hexHash.get(position) < 10){
       shapeColor = color(134, 134, 134); 
     }
     else{
      if(shapeColor > color(255)){
        shapeColor = color(255);
      }
       shapeColor = color(hexCount * 20);
     }
   }  
 }
 
} 
