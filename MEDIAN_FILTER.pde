PImage Median_Filter(PImage Img )
{
   Img.loadPixels();
   filteredImg = createImage(img.width, img.height, GRAY);
  
   for(int filno = 0 ; filno < 1 ; filno++)
   {
  
    for (int y = 1; y < img.height-1; y++) 
      { // Skip top and bottom edges
      for (int x = 1; x < img.width-1; x++) 
          { // Skip left and right edges
                int[] sort=new int[9];
                int except_count=0;
                   
          for (int i = -1; i < 2; i++) 
            { // Skip top and bottom edges
            for (int j = -1; j < 2; j++) 
                { // Skip left and right edges
                  int  pos = (y+i)*img.width + (x+j);
                 float  green_val =green(Img.pixels[pos]);
               
                   sort[except_count]=(int)green_val;
                   except_count++;
                  }
              }
               for (int i = 0; i < 8; i++)
               {
                  for (int j = 0; j < 8 - i ; j++)
                    // To sort in descending order, change > to < in this line.
                    if (sort[j] > sort[j + 1])
                    {
                      int temp = sort[j];
                      sort[j] = sort[j + 1];
                      sort[j + 1] = temp;
                    }
                }
                int median=sort[5];
                filteredImg.pixels[(y)*img.width + (x)] = color(median,median,median);
                 filteredImg.updatePixels();
          }   
      }
   }
   return filteredImg;
}
