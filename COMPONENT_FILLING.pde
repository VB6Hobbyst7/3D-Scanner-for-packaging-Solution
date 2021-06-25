PImage Component_Filling(PImage binaryImg)
{
  binaryImg.loadPixels();
 
  //image(binaryImg2,0,0);
  //save("inverse_binary.jpg");
  binaryImg2=Binary_Inverse(binaryImg);
  binaryImg2.loadPixels();
  floodFill(binaryImg,5,2);                                     // top left
  floodFill(binaryImg,1900,2);                                  // top right
  floodFill(binaryImg,5,540);                                   // middle left
  floodFill(binaryImg,1900,540);                                // middle right     
  floodFill(binaryImg,5,1060);                                  // bottom left
  floodFill(binaryImg,1900,1060);                               // bottom right
  floodFill(binaryImg,960,2);                                   // top middle
  floodFill(binaryImg,960,1900);                                // bottom middle
  
  binaryImg.updatePixels();
 
  
  newImg = createImage(img.width, img.height, RGB);
  int filled_pixels=0;
    
    for (int y = 0; y < img.height; y++) 
      { // Skip top and bottom edges
      for (int x = 0; x < img.width; x++) 
          { // Skip left and right edges
            
             pos = (y)*img.width + (x);
             int col_sum=(int)green(binaryImg.pixels[pos])+(int)green(binaryImg2.pixels[pos]);
             
            newImg.pixels[(y)*img.width + (x)] = color(col_sum,col_sum,col_sum);
            if(col_sum == 255){
                filled_pixels ++;
            }
              newImg.updatePixels();
        }
      }
    
    if(filled_pixels >= 2073600)newImg = binaryImg2;
    return newImg;
}

PImage Binary_Inverse(PImage binaryImg)
{
  binaryImg.loadPixels();
  binaryImg2 = createImage(img.width, img.height, RGB);

   for (int y = 0; y < img.height; y++) 
    { // Skip top and bottom edges
    for (int x = 0; x < img.width; x++) 
        { // Skip left and right edges
          
           pos = (y)*img.width + (x);
           int col_sum=(int)green(binaryImg.pixels[pos]);
          binaryImg2.pixels[(y)*img.width + (x)] = color(255-col_sum,255-col_sum,255-col_sum);
      }
    }
    binaryImg2.updatePixels();
    return binaryImg2;
  
}
