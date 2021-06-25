
void setup() {
  
  size(1920,1080);
  //output = createWriter("positions.txt");
  RGB_to_DEPTH_coordinates=createWriter("HEIGHT_COORDINATES.txt");
  //Depth = createWriter("DEPTH_coordinates.txt");
 
  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.enableColorImg(true);
  kinect.enablePointCloud(true);

  kinect.init();
  img =loadImage("IMAGE.jpg");
  img_for_Adaptive=img;
  img_for_OTSU=img;
  
}

void draw() {
    
    int d_count=0;                                 // Verified
    depthRaw = kinect.getRawDepthData(); // Length: 2,073,600
    d_count = Calculate_Depth_Access(d_count);
    Set_Depth_Access(d_count);
    Calculate_RGB_Access();
    Set_RGB_Access();
    RGB_Access=1;
 if(RGB_Access == 1)
  {
    println("enetered");
      Adaptive_part();
     // OTSU_part();
     OTSU_with_Adaptive();
     RGB_Access=-1;
     exit();
  }
  if(Depth_Access == 1 && RGB_Access==(-1)){
     DepthAcquisition();   //issue needs to be solved
     Depth_Mapping();
     exit();
  }
}

void Adaptive_part()
{
     img_for_Adaptive = Grayscale.apply(img_for_Adaptive);
     img_for_Adaptive = Median_Filter(img_for_Adaptive);
     Integral_Image_method(img_for_Adaptive);
     img_for_Adaptive = Component_Filling( Adaptive_thresholding_Mean_withIM_method(img_for_Adaptive, 5, 2));
     img_for_Adaptive=Rough_thresholding(img_for_Adaptive);
     img_for_Adaptive = Median_Filter(img_for_Adaptive);
     Connected_component_Algorithm(img_for_Adaptive);
     
}

void OTSU_part()
{
      img_for_OTSU=RGB_to_Gray_Conversion(img_for_OTSU);
      filteredImg=Median_Filter(img_for_OTSU);
      img_for_OTSU = Component_Filling(Otsu_Thresholding(filteredImg));
      img_for_OTSU=Rough_thresholding(img_for_OTSU);
      img_for_OTSU = Median_Filter(img_for_OTSU);
      Connected_component_Algorithm(img_for_OTSU);
}

void OTSU_with_Adaptive()
{
      img_for_OTSU=RGB_to_Gray_Conversion(img_for_OTSU);
      img_for_OTSU=Median_Filter(img_for_OTSU);
      img_for_OTSU=Otsu_Thresholding(img_for_OTSU);
      img_for_OTSU = Component_Filling(img_for_OTSU);
      img_for_OTSU=Rough_thresholding(img_for_OTSU);
      img_for_OTSU=OTSU_Adaptive_comparison(img_for_OTSU);
    
      image(img_for_OTSU,0,0);
      save("temp.jpg");
      img_for_OTSU=Binary_Inverse(img_for_OTSU);
      img_for_OTSU = Component_Filling(img_for_OTSU);
      img_for_OTSU=Rough_thresholding(img_for_OTSU);
      img_for_OTSU = Median_Filter(img_for_OTSU);
      Connected_component_Algorithm(img_for_OTSU);
}
