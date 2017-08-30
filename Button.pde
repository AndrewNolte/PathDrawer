public abstract class Button implements Drawable, Pressable{
  String name;
  float x;
  float y;
  float w;
  float h;
  private boolean onButton;
  private boolean lastOnButton;
  private color bgColor = color(100);
  
  public Button(String name, float x, float y, float w, float h){
    this.name = name;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    stack.add(this);
    update();
    paint();
  }
  
  public void update(){    
    if(onButton()){
      bgColor = color(10);
      onButton = true;
    }else{
      bgColor = color(50);
      onButton = false;
    }
    if(onButton != lastOnButton){
      paint();
    }
    lastOnButton = onButton;
    
  }
  
  void paint(){
      fill(bgColor);
      stroke(0);
      strokeWeight(.5);
      rect(x,y,w,h, .05 * w);
      strokeWeight(1);

      fill(255);
      stroke(0);
      textSize(12);
      textAlign(LEFT, CENTER);
      text(name, x + .1 *w, y + h/2);
  }
  
  private boolean onButton(){
    return mouseX < x + w && mouseX > x && mouseY < y + h && mouseY > y;
  }
  
  public void pressedMouse(){
    if(onButton()){
      pressed();
    }
  }
  public void releasedMouse(){
  }
  public abstract void pressed();
  
}
  