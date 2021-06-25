PImage Otsu_Thresholding(PImage filteredImg)
{
  filteredImg.loadPixels();
  for (int y = 0; y < 256; y++) 
      { 
              otsu_count[y]=0;
              class_variance[y]=0;
      }
    for (int y = 0; y < img.height; y++) 
      { // Skip top and bottom edges
        for (int x = 0; x < img.width; x++) 
            { // Skip left and right edges
               int pos = (y)*img.width + (x);
               int pixel_val =(int)red(grayImg.pixels[pos]);
               otsu_count[pixel_val]++ ;
            }
        }
        
/////////////////////////////////////////////////////////////////////////////////////////    OTSU thresholding start
    for (int thresh_val = 0; thresh_val < 256; thresh_val++) 
      {  back_count=0;
        mean_back_count=0;
        fore_count=0;
        mean_fore_count=0;
        weight_prob_back=0;
        weight_prob_fore=0;
        back_variance_sum=0;
        fore_variance_sum=0;
        if(thresh_val > 0)
          {
            for (int y = 0; y < thresh_val; y++) 
            {
             weight_prob_back += (float)otsu_count[y]/ ((img.height-1)*(img.width-1)); //background probablity
             mean_back_count +=(float)y*otsu_count[y];                             // sum in the form of( y*count[y])
             back_count +=otsu_count[y];                                    // sum of count of intensity pixels of background
            }
            mean_back=mean_back_count/back_count;                      //mean of background                       
            
            for (int y = 0; y < thresh_val; y++) 
            {
              back_variance_sum +=((y-mean_back)*(y-mean_back)*otsu_count[y]);    // variance calculation of background
            }
            back_variance=back_variance_sum/back_count;
          }  
          //////////////////////////////////////////////////////////////////////////////////////////////////////////////
          
          for (int y = thresh_val ; y < 256; y++) 
          {
           weight_prob_fore += (float)otsu_count[y]/ ((img.height-1)*(img.width-1));  // same as above for foreground
           mean_fore_count +=(float)y*otsu_count[y];
           fore_count += otsu_count[y];
          }
          
            mean_fore= mean_fore_count/fore_count;
          
          for (int y = thresh_val; y < 256; y++) 
          {
            fore_variance_sum += ((y-mean_fore)*(y-mean_fore)*otsu_count[y]);    // variance calculation of foreground
          }
          
          fore_variance=fore_variance_sum/fore_count;
          
          class_variance[thresh_val]= (back_variance*mean_back) + (fore_variance*mean_fore); 
          temp_class_variance[thresh_val]=class_variance[thresh_val];
     }
    // println(class_variance[240]);
       for (int i = 0; i < 256; ++i) 
        {
        for (int j = i + 1; j < 256; ++j)
            {
              if (temp_class_variance[i]>temp_class_variance[j]) 
                {
                   float a =  temp_class_variance[i];
                    temp_class_variance[i]= temp_class_variance[j];
                    temp_class_variance[j]= a;
                 }     
            }
        }
    //    println(temp_class_variance[0]);
        int threshold=0;
        for (int i = 0; i < 256; ++i) 
        {
             if(temp_class_variance[0] == class_variance[i])
             {
               threshold=i;
             }
        }
     //  println(threshold);  
     //threshold =100;
     binaryImg = createImage(img.width, img.height, RGB);

    for (int y = 0; y < img.height; y++) 
      { // Skip top and bottom edges
      for (int x = 0; x < img.width; x++) 
          { // Skip left and right edges
            
             int pos = (y)*img.width + (x);
         
            float green_val =green(img.pixels[pos]);
          if(green_val >= threshold)                      //////////// binary_image
          {
            col_sum=255;
          }
          else if(  green_val < threshold)
          {
            col_sum=0;
          }
            binaryImg.pixels[(y)*img.width + (x)] = color(col_sum,col_sum,col_sum);
        }
      }
    binaryImg.updatePixels();
    return binaryImg;
}

PImage Rough_thresholding(PImage img)
{
 img.loadPixels();
    for (int y = 0; y < img.height; y++) 
      { // Skip top and bottom edges
      for (int x = 0; x < img.width; x++) 
          { // Skip left and right edges
          
             pos = (y)*img.width + (x);
             green_val =(int)green(img.pixels[pos]);
             if(green_val>250)
             {
               green_val=255;
             }
             else
             {
              green_val=0; 
             }
            img.pixels[(y)*img.width + (x)] = color(green_val,green_val,green_val);
        }
      }
    img.updatePixels();
    return img;
}

PImage OTSU_Adaptive_comparison(PImage img)
{
  img.loadPixels();
  for (int y = 0; y < img.height; y++) 
      { // Skip top and bottom edges
      for (int x = 0; x < img.width; x++) 
          { // Skip left and right edges
               pos = (y)*img.width + (x);
               green_val =(int)green(img.pixels[pos]);
               if(green_val == 255 && white_pixel_count[pos]==1)green_val=255;
               else green_val = 0;
               img.pixels[(y)*img.width + (x)] = color(green_val,green_val,green_val);
          }
      }
    img.updatePixels();
    return img;
}
