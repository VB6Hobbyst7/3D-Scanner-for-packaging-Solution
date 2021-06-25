void Calculate_RGB_Access()
{
   temp_img=kinect.getColorImage();
   temp_img.loadPixels();
    PImage tempImg = createImage(temp_img.width, temp_img.height, RGB);

   for (int y = 0; y < temp_img.height; y++) 
      { // Skip top and bottom edges
      for (int x = 0; x < temp_img.width; x++) 
          { // Skip left and right edges
            
            int  pos = (y)*temp_img.width + (x);
             
             col_sum =red(temp_img.pixels[pos]);
             tempImg.pixels[(y)*temp_img.width + (x)] = color(col_sum,col_sum,col_sum);
             if(col_sum==0)
             {
               color_count ++; 
             }
        }
      }
    tempImg.updatePixels();
    image(temp_img,0,0);
}

void Set_RGB_Access()
{
  if(temp==1 && color_count<10000){
      save("IMAGE.jpg");
      pic_count++;
      RGB_Access=1;
      if(pic_count==5)
      {
        RGB_Access=1;
        pic_count=0;
         temp=0;
      }
   }
   color_count=0;
}

int Calculate_Depth_Access(int d_count)
{
  depthRaw = kinect.getRawDepthData(); // Length: 2,073,600
  
 if(Depth_Access == 0){
    for (int y = 0; y < KinectPV2.HEIGHTDepth; y++) 
      { // Skip top and bottom edges
      for (int x = 0; x < KinectPV2.WIDTHDepth; x++) 
          { // Skip left and right edges
            
             int  pos = (y)*KinectPV2.WIDTHDepth + (x);
             int d= depthRaw[pos];
             PVector point=depthToPointCloudPos(x,y,d);
             if(point.z==0)
             {
               d_count ++; 
             }
        }
      }
  }
  return d_count; 
}
void Set_Depth_Access(int d_count)
{
    if(Depth_Hold==1 && d_count<100000){
    depth_pic_count++;
    if(depth_pic_count==5)
    {
      Depth_Access=1;
      depth_pic_count=0;
      Depth_Hold=0;
    }
   }
   d_count=0;

}
