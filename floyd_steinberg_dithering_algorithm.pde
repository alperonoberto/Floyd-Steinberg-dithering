PImage userImg;
boolean fileSelected;
String path;

int index(int x, int y) {
  return x + y * userImg.width;
}

String getFileExtension(String file) {
    int lastIndexOf = file.lastIndexOf(".");
    if (lastIndexOf == -1) {
        return "";
    }
    return file.substring(lastIndexOf);
}

void fileSelected(File selection) {
  String fileName = selection.getName();
  String extension = getFileExtension(fileName);
  
  if(selection == null || !(extension.equals(".jpg") || extension.equals(".JPG"))) {
    println("User closed window w/o selecting any file or the extension of the file was not jpg.");
    textSize(40);
    textAlign(CENTER);
    text("User closed window w/o selecting any file or the extension of the file was not jpg.", width/2, height/2);
  }else {
    path = selection.getAbsolutePath();
    fileSelected = true;
    println("User selected " + selection.getAbsolutePath());
  }
}

void keyPressed() {
 if (key == ' ') {
   if (fileSelected) {
     background(100);
   }
   selectInput("Select an image to process:", "fileSelected");
 };
}

void setup() {
  fill(0);
  textSize(40);
  textAlign(CENTER);
  text("Press the spacebar to load an image to process.", width/2, height/2);
  size(1200, 600);
  surface.setResizable(true);
}

void draw() {
  
  if(fileSelected){
    userImg = loadImage(path);
    userImg.resize(width/2, height);
    image(userImg, 0, 0);
    
    
    userImg.loadPixels();
    for(int y = 0; y < userImg.height - 1; y++) {
      for(int x = 1; x < userImg.width - 1; x++) {

        color pix = userImg.pixels[index(x, y)];
      
        float oldR = red(pix);
        float oldG = green(pix);
        float oldB = blue(pix);
      
        int factor = 1;
      
        float newR = round(factor * oldR / 255) * (255 / factor);
        float newG = round(factor * oldG / 255) * (255 / factor);
        float newB = round(factor * oldB / 255) * (255 / factor);
      
        userImg.pixels[index(x, y)] = color(newR, newG, newB);
      
        float redQuantErr = oldR - newR;
        float greenQuantErr = oldG - newG;
        float blueQuantErr = oldB - newB;
      
        int index = index(x + 1, y);
        color c = userImg.pixels[index];
        float r = red(c);
        float g = green(c);
        float b = blue(c);
        r = r + redQuantErr * (7 / 16.0);
        g = g + greenQuantErr * (7 / 16.0);
        b = b + blueQuantErr * (7 / 16.0);
        userImg.pixels[index] = color(r, g, b);
      
        index = index(x - 1, y + 1);
        c = userImg.pixels[index];
        r = red(c);
        g = green(c);
        b = blue(c);
        r = r + redQuantErr * (3 / 16.0);
        g = g + greenQuantErr * (3 / 16.0);
        b = b + blueQuantErr * (3 / 16.0);
        userImg.pixels[index] = color(r, g, b);
      
        index = index(x, y + 1);
        c = userImg.pixels[index];
        r = red(c);
        g = green(c);
        b = blue(c);
        r = r + redQuantErr * (5 / 16.0);
        g = g + greenQuantErr * (5 / 16.0);
        b = b + blueQuantErr * (5 / 16.0);
        userImg.pixels[index] = color(r, g, b);
      
        index = index(x + 1, y + 1);
        c = userImg.pixels[index];
        r = red(c);
        g = green(c);
        b = blue(c);
        r = r + redQuantErr * (1 / 16.0);
        g = g + greenQuantErr * (1 / 16.0);
        b = b + blueQuantErr * (1 / 16.0);
        userImg.pixels[index] = color(r, g, b);
      
      
      
      }
    }
    userImg.updatePixels();
    image(userImg, userImg.width, 0);
  }
  
  fileSelected = false;
  
}
