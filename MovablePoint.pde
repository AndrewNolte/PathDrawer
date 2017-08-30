
public class MovablePoint extends PVector implements Pressable, Drawable{
  
  float radius = 5;
  boolean isMoving = false;
  
  public MovablePoint(float x, float y){
    super(x,y);
    stack.add(this);
    buttons.add(this);
    paint();
  }
  
  public void update(){
    if(isMoving){
      x = mouseX;
      y = mouseY;
      askForRepaint();
    }
  }
  public void paint(){
    fill(0);
    stroke(0);
    strokeWeight(1);
    ellipse(x,y, radius, radius);
  }
  
  public void pressedMouse(){
    if(onDot()) isMoving = true;
      
  }
  
  public void releasedMouse(){
    isMoving = false;
  }
  
  public boolean onDot(){
    return Math.hypot(x-mouseX, y-mouseY) <= radius;
  }
  
    @Override
  public String toString(){
    return String.format("new Location(%.1f,%.1f)", (x - originX)/pixelsPerInch, -1 *(y - originY)/pixelsPerInch);
  }
}