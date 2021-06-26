void DepthAcquisition()
{
 float [] mapDCT = kinect.getMapDepthToColor(); // 434176

  int count = 0;
  for (int i = 0; i < KinectPV2.WIDTHDepth; i++) {
    for (int j = 0; j < KinectPV2.HEIGHTDepth; j++) {

      //incoming pixels 512 x 424 with position in 1920 x 1080
      float valX = mapDCT[count * 2 + 0];
      float valY = mapDCT[count * 2 + 1];
      

      //maps the pixels to 512 x 424, not necessary but looks better
      int valXDepth = (int)((valX/1920.0) * 512.0);
      int valYDepth = (int)((valY/1080.0) * 424.0);

      if ( valXDepth >= 0 && valXDepth < 512 && valYDepth >= 0 && valYDepth < 424 &&
        valX >= 0 && valX < 1920 && valY >= 0 && valY < 1080) {
          PVector point = depthToPointCloudPos(valXDepth,valYDepth, depthRaw[(int)valYDepth*KinectPV2.WIDTHDepth + (int)valXDepth]);
          RGBtoDepth[(int)valY*1920 + (int)valX]= (int)point.z;
      } 
 
      count++;
    }
  }
  for (int i = 0; i < img.height; i++) {
    for (int j = 0; j < img.width; j++) {
       //output.println(i);
    //  Depth.println((i*img.width+j) + "\t" + RGBtoDepth[(i*img.width+j)]);
    }
  }
//  Depth.flush(); // Writes the remaining data to the file
 // Depth.close(); // Finishes the file
}

void Depth_Mapping()
{
  int marker=0;
  int[] depth_Of_Marked_pixels = new int[img.width*img.height];
  
    for(int y =0 ; y < depth_area_count; y++)
    { 
      int depth_marked_count = 0;
      for(int i = 0 ; i < img.height ; i++)
      {
        for(int j = 0 ; j < img.width ; j++)
        {
            int pos = i*img.width + j;
            marker = y == 0 ? -1 : y; 
            if(mark_pix_arr_for_depth[pos]==marker && RGBtoDepth[pos]!=0){ ///to be changed
              depth_Of_Marked_pixels[depth_marked_count] = RGBtoDepth[pos];
              temporary_depth[pos] = RGBtoDepth[pos];
              depth_marked_count++;
            }
        }
      }
      println("depth_m_c" + depth_marked_count);
      int[] depth_Of_Marked_pixels_replicate = new int[depth_marked_count];
      if(depth_marked_count!=0)
      {
        for(int i = 0 ; i < depth_marked_count ; i++)
        {
          depth_Of_Marked_pixels_replicate[i]=depth_Of_Marked_pixels[i];
        }
        bubbleSort(depth_Of_Marked_pixels_replicate);
       int position =0;
        for(int i = 0 ; i < img.height ; i++)
        {
          for(int j = 0 ; j < img.width ; j++)
          {
              int pos = i*img.width + j;
              if(depth_Of_Marked_pixels_replicate[0] == temporary_depth[pos] && depth_Of_Marked_pixels_replicate[0]!=0 )
              { 
                position=1;
                RGB_to_DEPTH_coordinates.println(j + " " + i + " " + depth_Of_Marked_pixels_replicate[0]);
                break;
              }
          }
          if(position == 1)break;
        }
      }
      
      for(int i = 0 ; i < img.height ; i++)
      {
        for(int j = 0 ; j < img.width ; j++)
        {
            int pos = i*img.width + j;
            depth_Of_Marked_pixels[pos]=0;
            temporary_depth[pos]=0;
        }
      }
      for(int i = 0 ; i < depth_marked_count ; i++)
      {
        depth_Of_Marked_pixels_replicate[i]=0;
      }
      
    }
    RGB_to_DEPTH_coordinates.flush(); // Writes the remaining data to the file
    RGB_to_DEPTH_coordinates.close(); // Finishes the file
     
}
