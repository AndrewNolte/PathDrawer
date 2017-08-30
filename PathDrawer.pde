
PImage map;
PImage logo;

ArrayList<Drawable> stack = new ArrayList<Drawable>();
ArrayList<MovablePoint> bezps = new ArrayList<MovablePoint>();
ArrayList<WayPoint> path = new ArrayList<WayPoint>();
ArrayList<Pressable> buttons = new ArrayList<Pressable>();

BezierCurve curve;
private Mode mode = Mode.NONE;

WayPoint lastAdded = null;
float originX = 334;
float originY = 253;
float pixelsPerInch = 1.214;
float dbWaypoints = 15;

private boolean wantsRepaint = false;

void setup(){
  map = loadImage("Field Map.PNG");
  logo = loadImage("VortxLogo.png");
  size(1366,700);
  textFont(loadFont("Verdana-Bold-12.vlw"));
  repaint();
  
  float by = 10;
  buttons.add(new Button("Set Origin", 10,by, 130, 20){
    @Override
    public void pressed(){
        mode = Mode.ORIGINSET;
    }
  });
  by+=30;
  buttons.add(new Button("Clear Path", 10,by, 130, 20){
    @Override
    public void pressed(){
      clearPath();
    }
  });
  by += 30;
  buttons.add(new Button("Print Path", 10,by, 130, 20){
    @Override
    public void pressed(){
      if(curve != null && path.isEmpty()){
        System.out.println("Bezier: " + curve.toString());
      }else{
        System.out.println("Drawing: " + path.toString());
      }
    }
  });
  by+=30;
  buttons.add(new Button("Start Bezier", 10, by, 130, 20){
        @Override
    public void pressed(){
      clearPath();
      mode = Mode.BEZIER;
    }
  });
  by+=30;
  buttons.add(new Button("Start Drawing", 10, by, 130, 20){
        @Override
    public void pressed(){
      mode = Mode.DRAWPATH;
    }
  });
  Robot robot = new Robot(originX + Robot.l* .5 * pixelsPerInch, originY);
}

public enum Mode{
  NONE, ORIGINSET, DRAWPATH, BEZIER
}

public void clearPath(){
  lastAdded = null;
  for(Drawable p : path){
    stack.remove(p);
  }
  path.clear();
  bezps.clear();
  if(curve != null)curve.remove();
  curve = null;
  repaint();

}
void draw(){
  for(Drawable d : stack){
    d.update();
  }

  switch(mode){
    case ORIGINSET:
      break;
    case DRAWPATH:
        if(lastAdded != null && mousePressed && mouseX > 150){
          WayPoint wp = getCurrentwp();
          float dx = lastAdded.inchesX - wp.inchesX;
          float dy = lastAdded.inchesY - wp.inchesY;
          double dist = Math.hypot(dx,dy);
          if(dist > dbWaypoints){
            addWaypoint();
          }
        }
        break;
    case BEZIER:
      break;
    case NONE:
      break;
      
  }  

  if(wantsRepaint){
    repaint();
    wantsRepaint = false;
  }
}

public void repaint(){
  background(#00334c);
  fill(#7fc241);
  noStroke();
  //rect(0,0,150,height);
  image(map,150,0);
  float padx = 230;
  float pady = 20;
  image(logo,150 + padx,map.height + pady, map.width - 2 * padx, height-map.height- 2 * pady);
  for(Drawable d : stack){
    d.paint();
  }
}

void mousePressed(){
  switch(mode){
    case ORIGINSET:
      originX = mouseX;
      originY = mouseY;
      System.out.println("New Origin is (" + originX + "," + originY + ")");
      mode = Mode.NONE;
      break;
    case DRAWPATH:
      addWaypoint();
      break;
    case BEZIER:
      if(bezps.size() < 4){
        bezps.add(new MovablePoint(mouseX, mouseY));
        if(bezps.size() == 4){
          curve = new BezierCurve(bezps.get(0), bezps.get(1), bezps.get(2), bezps.get(3));
        }
      }
      break;
    case NONE:
  }
  
  for(Pressable p : buttons){
    p.pressedMouse();
  }
}

void mouseReleased(){
  for(Pressable p : buttons){
    p.releasedMouse();
  }
  if(mode == Mode.DRAWPATH){
    //mode = Mode.NONE;
  }
}

void addWaypoint(){
  if(mouseX > 150 && mouseX < 150 + map.width && mouseY < map.height){
    WayPoint p = getCurrentwp();
    p.paint();
    lastAdded = p;
    path.add(p);
  }
}

public WayPoint getCurrentwp(){
  return new WayPoint(mouseX, mouseY);
}

public void askForRepaint(){
  wantsRepaint = true;
}
  