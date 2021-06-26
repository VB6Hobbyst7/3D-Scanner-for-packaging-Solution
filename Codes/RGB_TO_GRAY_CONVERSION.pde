PImage RGB_to_Gray_Conversion(PImage img){
  // img = loadImage("as.jpg");    // needs to be restored
   img.loadPixels();
   grayImg = createImage(img.width, img.height, RGB);

    for (int y = 0; y < img.height; y++) 
      { // Skip top and bottom edges
      for (int x = 0; x < img.width; x++) 
          { // Skip left and right edges
            
             int pos = (y)*img.width + (x);
         
            float green_val =green(img.pixels[pos]);
             blue_val =blue(img.pixels[pos]);
             red_val =red(img.pixels[pos]);
             col_sum = (green_val + red_val + blue_val)/3;
            grayImg.pixels[(y)*img.width + (x)] = color(col_sum,col_sum,col_sum);
        }
      }
   grayImg.updatePixels();
   return grayImg;
}
