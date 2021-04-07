import controlP5.*;
import java.util.Map;

ControlP5 controls;
ControlP5 startButton;
ScrollableList dropdown;
Slider maxStepSlider, stepRateSlider, stepSizeSlider, stepScaleSlider;
Textlabel maxStepText, stepRateText, stepSizeText, stepScaleText;
Toggle constrainViewToggle, terrainColorToggle, strokeToggle, randomSeedToggle;
Textfield seedValueTextField;
int seedValInput;

int windowWidth = 2400;
int windowHeight = 2000;
int btnContainerWidth = 400;
int btnContainerHeight = 2000;

boolean start = false;
boolean dropped = false;
boolean toggled = false;

Square square;
HashMap<PVector, Integer> squareHash = new HashMap<PVector, Integer>();

Hexagon hex;
HashMap<PVector, Integer> hexHash = new HashMap<PVector, Integer>();

// Canvas setup
void setup(){
  size(2400, 2000);
  controls = new ControlP5(this);
  startButton = new ControlP5(this);

  square = new Square();
  hex = new Hexagon();
  
  background(49, 140, 210);
  
  // Buttons container
  fill(99, 101, 98);
  rect(0, 0, btnContainerWidth, btnContainerHeight);
  
  setupUI();
  
} // end setup


void draw(){
  if(int(dropdown.getValue()) == 0){
    shapeExperience(square, squareHash);
  }
  else if(int(dropdown.getValue()) == 1){
    shapeExperience(hex, hexHash); 
  }
}

public void controlEvent(ControlEvent e){
  // Check if group to avoid cp5 errors
  if(e.isGroup()){
   println("Event from group: " + e.getGroup().getValue() + " from " + e.getGroup()); 
  }
  else if(e.isController()){
   println(e.getController().getName()); 
  }
}

public void START(){
  if(!start){
    start = true;
    startButton.setColorBackground(color(3, 44, 88));
  }
  else{
   start = false;
  }
  
  background(49, 140, 210);
  
  // Button container UI
  fill(99, 101, 98);
  rectMode(CORNERS);
  rect(0, 0, 400, 2000);
}

// for square - size = length of side
// for hex - size = radius
void shapeExperience(Base shape, HashMap<PVector, Integer> hash){  
  int stepCount = (int)stepRateSlider.getValue();
  int maxSteps = (int)maxStepSlider.getValue();
    
  if(!start){
    
    for(int i = 0; i < stepCount; i++){
     for(int j = 0; j < maxSteps; j++){
       startButton.setColorBackground(color(0, 152, 0)); 
       
       shape.size = (int)stepSizeSlider.getValue();
       shape.spacing = stepScaleSlider.getValue();
       
       // Terrain color
       
       if(hash.containsKey(shape.position)){
        // if the position is in the hashmap, place it in the next position
        hash.put(shape.position, hash.get(shape.position) + 1); 
          if(terrainColorToggle.getState() == true){
              shape.getTerrainColor();
         }

       }
       else{
        hash.put(shape.position, 1);
        shape.shapeColor = color(160, 106, 196);
          if(terrainColorToggle.getState() == true){
              shape.getTerrainColor();
         }
       }
       
       // Constrain to viewport
       
       if(constrainViewToggle.getState() == true){
        // square goes into button container
        if(shape.position.x <= (btnContainerWidth + (int)shape.size)){
         shape.position.x += shape.size * 4;
        }
        // square goes outside right of window
        else if(shape.position.x >= (windowWidth - (int)shape.size)){
         shape.position.x -= shape.size * 4; 
        }
        // square goes outside top of window
        else if(shape.position.y <= (int)shape.size){
          shape.position.y += shape.size * 4;
        }
        // square goes outside bottom of window
        else if(shape.position.y >= (windowHeight - (int)shape.size)){
         shape.position.y -= shape.size * 4; 
        }
       }
       
       // Stroke
       
       if(strokeToggle.getState() == true){
        shape.hasStroke = true;
        shape.strokeColor = 0;
       }
       else{
        shape.hasStroke = false;
        shape.Draw();
        shape.Update();
       }
       
       // Use Random Seed
       if(randomSeedToggle.getState() == true){
        shape.Update();
       }
       else{
         // Limit input to ints
        seedValueTextField.setInputFilter(ControlP5.INTEGER);
        
        // Retrieve data from textfield
         shape.startSeed = int(seedValueTextField.getText());
       }
       
       square.Draw();
       square.Update();
     }
    }
    
  } // end if !start
  
} // end squareExperience()

void setupUI(){
 startButton.addButton("START")
             .setValue(0)
             .setPosition(20, 20)
             .setSize(150, 60);
  
  dropdown = controls.addScrollableList("CHOOSE SHAPE")
                     .setPosition(20, 100)
                     .setSize(250, 200)
                     .setItemHeight(50)
                     .setBarHeight(50)
                     .addItem("SQUARES", 0)
                     .addItem("HEXAGONS", 1);
  
  maxStepSlider = controls.addSlider("maxStepSlider")
                          .setPosition(20, 300)
                          .setRange(100, 50000)
                          .setSize(300, 40)
                          .setCaptionLabel("");
  maxStepSlider.getCaptionLabel();
  
  maxStepText = controls.addTextlabel("maxStepText")
                        .setText("Maximum Steps")
                        .setPosition(20, 290)
                        .setColorValue(255);
                        
  stepRateSlider = controls.addSlider("stepRateSlider")
                           .setPosition(20, 360)
                           .setRange(1, 1000)
                           .setSize(300, 40);
                           
  stepRateText = controls.addTextlabel("stepRateText")
                    .setText("Step Rate")
                    .setPosition(20, 350)
                    .setColorValue(255);
  
  stepSizeSlider = controls.addSlider("stepSizeSlider")
                           .setPosition(20, 475)
                           .setRange(10, 30)
                           .setSize(300, 40);
                           
  stepSizeText = controls.addTextlabel("stepSizeText")
                    .setText("Step Size")
                    .setPosition(20, 465)
                    .setColorValue(255);

  stepScaleSlider = controls.addSlider("stepScaleSlider")
                    .setPosition(20, 535)
                    .setRange(1.0, 1.5)
                    .setSize(300, 40);
  
  stepScaleText = controls.addTextlabel("stepScaleText")
                     .setText("Step Scale")
                     .setPosition(20, 525)
                     .setColorValue(255); 
                     
  constrainViewToggle = controls.addToggle("Constrain Steps")
                                .setPosition(20, 595)
                                .setSize(40, 40);
                                
  terrainColorToggle = controls.addToggle("Simulate Terrain")
                               .setPosition(20, 655)
                               .setSize(40, 40);
                               
  strokeToggle = controls.addToggle("Use Stroke")
                         .setPosition(20, 715)
                         .setSize(40, 40);
  
  randomSeedToggle = controls.addToggle("Use Random Seed Value")
                             .setPosition(20, 775)
                             .setSize(40, 40);
                             
  seedValueTextField = controls.addTextfield("Set Seed Value")
                    .setPosition(140, 775)
                    .setSize(90, 40);

} // end setupUI
