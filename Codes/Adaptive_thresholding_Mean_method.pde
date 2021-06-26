void Integral_Image_method(PImage filteredImg)
{
  //filteredImg = Grayscale.apply(filteredImg);
  
  filteredImg.loadPixels();
  int[] pos= new int[4];
  long sum=0;
  
  for (int y = 0; y < filteredImg.height * filteredImg.width; y++) 
      { // Skip top and bottom edges
        integral_value[y]=0;
      }
  for (int y = 0; y < filteredImg.height; y++) 
      { // Skip top and bottom edges
         for (int x = 0; x < filteredImg.width; x++) 
            { // Skip left and right edges
               pos[0] = (y)*filteredImg.width + (x);
               pos[1] = (y)*filteredImg.width + (x-1);
               pos[2] = (y-1)*filteredImg.width + (x);
               pos[3] = (y-1)*filteredImg.width + (x-1);
               
               long  present_color= (int)red(filteredImg.pixels[pos[0]]);
               long  back_color= pos[1] >=0 ? integral_value[pos[1]] : 0;
               long above_color = pos[2] >=0 ? integral_value[pos[2]] : 0;
               long diagonal_color = pos[3] >=0 ? integral_value[pos[3]] : 0;
               sum = present_color + back_color + above_color - diagonal_color;
               integral_value[pos[0]]=sum;
               sum=0;
              // print(integral_value[pos[0]]);print(" present_color :");print(present_color);print(" diagonal_color :");println(diagonal_color);
            }
        }
      for (int y = 0; y < filteredImg.height * filteredImg.width; y++) 
      { // Skip top and bottom edges
       // println(integral_value[y]);
      }
}


PImage Adaptive_thresholding_Mean_withIM_method(PImage filteredImg, int window_size,int threshold)
{
  binaryImg = createImage(filteredImg.width, filteredImg.height, RGB);
  //filteredImg = Grayscale.apply(filteredImg);
  for (int y = (window_size/2)+1 ; y < filteredImg.height - (window_size/2)- 1; y++) 
      { // Skip top and bottom edges
        for (int x = (window_size/2)+1; x < filteredImg.width - (window_size/2) - 1; x++) 
            { // Skip left and right edges
               int pos = (y)*filteredImg.width + (x);
               int green_val =(int)green(filteredImg.pixels[pos]);
               int pos_top_left_corner = (y-((int)window_size/2)-1)*filteredImg.width + (x - ((int)window_size/2)-1);
               int pos_bottom_right_corner = (y+((int)window_size/2))*filteredImg.width + (x + ((int)window_size/2));
               int pos_bottom_left_corner = (y+((int)window_size/2))*filteredImg.width + (x - ((int)window_size/2)-1);
               int pos_top_right_corner = (y-((int)window_size/2)-1)*filteredImg.width + (x + ((int)window_size/2));
                              
               long total_sum = (integral_value[pos_bottom_right_corner] - integral_value[pos_top_right_corner]) - (integral_value[pos_bottom_left_corner] - integral_value[pos_top_left_corner]); 
               int col_sum = (int)total_sum/((int)pow(window_size,2)) - threshold;
               //print(col_sum); print(" "); println(green_val );
               if(green_val <= col_sum)col_sum=0;
               else col_sum=255;
               binaryImg.pixels[(y)*filteredImg.width + (x)] = color((int)col_sum,(int)col_sum,(int)col_sum);                           
            }
        }
      return  binaryImg;
}

void Adaptive_thresholding_Mean_woIM_method(PImage filteredImg, int window_size,int threshold)
{
  binaryImg = createImage(filteredImg.width, filteredImg.height, RGB);
  filteredImg = Grayscale.apply(filteredImg);
  for (int y = ((int)window_size/2)+1 ; y < filteredImg.height - ((int)window_size/2)- 1; y++) 
      { // Skip top and bottom edges
        for (int x = ((int)window_size/2)+1; x < filteredImg.width - ((int)window_size/2) - 1; x++) 
            { // Skip left and right edges
               int col_sum =0;
               int pos = y*filteredImg.width + x;
               int green_val = (int)green(filteredImg.pixels[pos]);
               int count=0;
               for (int i = y - ((int)window_size/2); i <= y + ((int)window_size/2) ; i++) 
                  { // Skip top and bottom edges
                    for (int j = x - ((int)window_size/2); j <= x + ((int)window_size/2); j++) 
                    {
                         int pos_2 = i*filteredImg.width + j;
                         col_sum += (int)green(filteredImg.pixels[pos_2]);
                         //print(pos_2); print(" ");println((int)green(filteredImg.pixels[pos_2]));
                         count++;
                    }
                  }
                  // if (count != ((int)pow(window_size,2))) print(count);
                  col_sum = (col_sum/((int)pow(window_size,2))) - threshold;
                  //print(((int)pow(window_size,2)));print(" ");
                  /*print(col_sum)*/; //print(" "); println(green_val );
                  if(green_val < col_sum)col_sum =0;
                  else col_sum =255;
                  binaryImg.pixels[(y)*filteredImg.width + (x)] = color((int)col_sum,(int)col_sum,(int)col_sum);
            }
        }
}
PImage Adaptive_thresholding_GaussianMean_woIM_method(PImage filteredImg, int window_size,int threshold)
{
  binaryImg = createImage(filteredImg.width, filteredImg.height, RGB);
  filteredImg = Grayscale.apply(filteredImg);
  int[] array_for_variance = new int[((int)pow(window_size,2))];
  for (int y = ((int)window_size/2)+1 ; y < filteredImg.height - ((int)window_size/2)- 1; y++) 
      { // Skip top and bottom edges
        for (int x = ((int)window_size/2)+1; x < filteredImg.width - ((int)window_size/2) - 1; x++) 
            { // Skip left and right edges
               int col_sum =0;
               int pos = y*filteredImg.width + x;
               int green_val = (int)green(filteredImg.pixels[pos]);
               int count=0;
               for (int i = y - ((int)window_size/2); i <= y + ((int)window_size/2) ; i++) 
                  { // Skip top and bottom edges
                    for (int j = x - ((int)window_size/2); j <= x + ((int)window_size/2); j++) 
                    {
                         int pos_2 = i*filteredImg.width + j;
                         col_sum += (int)green(filteredImg.pixels[pos_2]);
                         array_for_variance[count]=(int)green(filteredImg.pixels[pos_2]);
                         //print(pos_2); print(" ");println((int)green(filteredImg.pixels[pos_2]));
                         count++;
                    }
                  }
                  // if (count != ((int)pow(window_size,2))) print(count);
                  int average = (col_sum/((int)pow(window_size,2)));
                  int variance_sum=0;
                   for (int i = 0; i <  ((int)pow(window_size,2)) ; i++) 
                      {
                          variance_sum += (int)pow( array_for_variance[i] - average,2);
                      }
                      int variance_square= variance_sum/(((int)pow(window_size,2))-1);
                      int gaussian_mean =(int)exp(-(pow(x,2) + pow(y,2))/2*variance_square)/2*(int)Math.PI*variance_square;
                      print(gaussian_mean); print(" "); println((int)green(filteredImg.pixels[pos]));
                      col_sum = gaussian_mean - threshold;
                   //print(((int)pow(window_size,2)));print(" ");
                  /*print(col_sum)*/; //print(" "); println(green_val );
                  if(green_val < col_sum)col_sum =0;
                  else col_sum =255;
                  binaryImg.pixels[(y)*filteredImg.width + (x)] = color((int)col_sum,(int)col_sum,(int)col_sum);
            }
        }
        return binaryImg;
}
