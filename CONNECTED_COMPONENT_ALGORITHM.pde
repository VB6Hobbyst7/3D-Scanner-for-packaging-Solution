void Connected_component_Algorithm(PImage img)
{
  int zero_dif=1,zero_count=0,prev_zero=0,one_t=1;
     img.loadPixels();
     while(zero_dif!=0)
    {
    for (int y = 0; y < img.height; y++) 
      { // Skip top and bottom edges
      for (int x = 0; x < img.width; x++) 
          { // Skip left and right edges
            
             pos = (y)*img.width + (x);
             //pos=14635;
             pos1=(y-1)*img.width + (x);
             green_val =(int)green(img.pixels[pos]);
             green_val2 =pos-1>=0 ? (int)green(img.pixels[pos-1]) : 0;
             green_val3 =(y-1)>=0 && (y-1)<img.height && x>=0 && x<img.width ? (int)green(img.pixels[pos1]) : 0;
             if(green_val!=0)
             {
                 if( (green_val2 == 0 && green_val3 == 0 && pix[pos]==0 ))
                     {
                       pix[pos]=count++;
                     }
                     if(green_val2==255 && green_val3==255 )
                     {
                      if(pix[pos-1]>pix[pos1])
                       {
                         pix[pos]=pix[pos1]==0 ? pix[pos-1] : pix[pos1];
                         pix[pos1]=pix[pos1]==0 ? pix[pos-1] : pix[pos1];
                         parent[pix[pos-1]][pix[pos1]]=1;
                        
                       }
                      if(pix[pos-1]<pix[pos1])
                        {
                          pix[pos]=pix[pos-1]==0 ? pix[pos1] : pix[pos-1];
                          pix[pos-1]=pix[pos-1]==0 ? pix[pos1] : pix[pos-1];
                          parent[pix[pos1]][pix[pos-1]]=1;
                          
                         }
                      if(pix[pos-1]==pix[pos1])
                        {
                          pix[pos]=pix[pos-1];
                        }
                       
                     }
                     if(green_val2==255 && green_val3==0)
                     {
                       pix[pos]= pix[pos-1];
                     }
                     if(green_val2==0 && green_val3==255 )
                     {
                          pix[pos]=pix[pos1];
                      }
              }
   
          }
        }
     for (int y = 0; y < img.height; y++) 
      { // Skip top and bottom edges
      for (int x = 0; x < img.width; x++) 
          { // Skip left and right edges
             pos = (y)*img.width + (x);
             white_pixel_count[pos]=0;
             green_val =(int)green(img.pixels[pos]);
           //  println(green_val);
             if(green_val==255 && pix[pos]==0)
             {
              // println(pos);
              zero_count++;
             }
             
          }
      }
     //   println(parent[25][24]);
     // pos=14632;
    //  println(pix[pos]);
    //  println(pix[pos-1]);
     // println(pix[pos-img.width]);
      int[] p_count=new int[count];
      int end =0;
      int[] child_count=new int[count+1];
       
    for (int y = 1; y <= count; y++) 
      { // Skip top and bottom edges
      for (int x = 1; x <= count; x++) 
          { // Skip left and right edges
             pos = (y)*img.width + (x);
             if(parent[y][x]==1)
             {
               p_count[c_count]=x;
               c_count++;
             }
          }
        child_count[y]=c_count;
        int[] pix1=new int[c_count];
        for (int j = 0; j < c_count; j++) 
          {
              pix1[j]=p_count[j];
          }
        bubbleSort(pix1);
        for (int i = 0; i < c_count; i++) 
          {
            sub_parent[pix1[i]]=(sub_parent[pix1[i]]>0) ? sub_parent[pix1[i]]:pix1[0];
            sub_parent[y]=(sub_parent[pix1[i]]>0) ? sub_parent[pix1[i]]:pix1[0];
            sub_parent[pix1[i]]=(sub_parent[pix1[i]] <= sub_parent[pix1[0]]) ? sub_parent[pix1[i]]:pix1[0];
            sub_parent[y]=(sub_parent[pix1[i]] <= sub_parent[pix1[0]]) ? sub_parent[pix1[i]]:pix1[0];
            //  print(count);
             for(int j=0;j<child_count[pix1[i]];j++)
              {
                 for (int x = 1; x <= count; x++) 
                  { // Skip left and right edges
                     if(parent[pix1[i]][x]==1)
                     {
                         int temp_x=x;
                         int temp_pix1;
                         while(sub_parent[temp_x]>pix1[0])
                         {
                           temp_pix1=sub_parent[temp_x];
                           sub_parent[temp_x]=sub_parent[temp_x]>pix1[0] ? pix1[0] : sub_parent[temp_x];
                           sub_parent[temp_pix1]=sub_parent[temp_x];
                           temp_x=temp_pix1;
                         }  
                     }
                  }
                    
              }
                    
          }
          //  println(sub_parent[pix1[i]] + " " + c_count + " " + y+ " " + pix1[i] + " " + sub_parent[y] );
      //    println(count);
          for (int i = 0; i < c_count; i++) 
          {
              pix1[i]=0;
          }
         c_count=0;
      }
    int[] mark=new int[count];
    int[] mark_var=new int[count];
    int mark_count=0;
    for (int y = 0; y < img.height; y++) 
      { // Skip top and bottom edges
      for (int x = 0; x < img.width; x++) 
          { // Skip left and right edges
          
             pos = (y)*img.width + (x);
             pix[pos]=pix[pos]!=0 ? sub_parent[pix[pos]] : 0; 
            if(pix[pos]!=0 && mark[pix[pos]]==0)
            {
               mark[pix[pos]]=pix[pos];
               mark_var[mark_count]=pix[pos];
               mark_count++;
            }
        }
      }
      zero_dif=zero_count-prev_zero;
        prev_zero=zero_count;
        zero_count=0;
       one_t=0;   
    //   println(mark_count);
   }
   
    int[] mark=new int[count];
    int[] mark_var=new int[count];
    int mark_count=0;
    for (int y = 0; y < img.height; y++) 
      { // Skip top and bottom edges
      for (int x = 0; x < img.width; x++) 
          { // Skip left and right edges
          
             pos = (y)*img.width + (x);
             pix[pos]=pix[pos]!=0 ? sub_parent[pix[pos]] : 0; 
            if(pix[pos]!=0 && mark[pix[pos]]==0)
            {
               mark[pix[pos]]=pix[pos];
               mark_var[mark_count]=pix[pos];
               mark_count++;
               
            }
        }
      }
    int[] mark_var_new=new int[mark_count];
      
    for (int y = 0; y < mark_count; y++) 
      { // Skip top and bottom edges
         mark_var_new[y]=mark_var[y];
        // println(mark_var_new[y]);
      }
      bubbleSort(mark_var_new);
      int area_count=0,area_mark=0;
      int mark_pix_count=0;
      int reject_mark=0;
      int[] area=new int[mark_count]; 
      int[] f_area=new int[mark_count]; 
      int[] new_mark=new int[mark_count]; 
      int[] rejected_mark = new int[mark_count];
          
    for (int y = 0; y < mark_count; y++) 
      { // Skip top and bottom edges
        for (int i = 0; i < img.height; i++) 
          { // Skip top and bottom edges
          for (int j = 0; j < img.width; j++) 
              { // Skip left and right edges
                
                pos = (i)*img.width + (j);
                if(pix[pos]==mark_var_new[y] && (i>2 && i< 2045) && (j>2 && j< 3112) )
                {
                  mark_pix_count++;
                }
                
            }
         }
         area[y]=mark_pix_count;
         f_area[area_count]=mark_pix_count;
         area_count++; 
         if(area[y]<3500)
         {
            area_count--;
            rejected_mark[reject_mark++] = mark_var_new[y];
         }
         if(area[y]>=3500)
         {
            new_mark[area_mark] = mark_var_new[y];
            area_mark++;
         }
         mark_pix_count=0;
      }
    //+  println(reject_mark);
   int[] area_new=new int[area_count];
   int[] am_new=new int[area_count];
   int[] reject_new =new int[reject_mark];
   int[][] mark_pix_arr= new int[area_count][img.width*img.height];            // Verified (can be changed)
   int[] colored_mark=new int[img.width*img.height];
    int col=0;
    depth_area_count = area_count; 
     for (int y = 0; y < reject_mark; y++) 
      { // Skip top and bottom edges
         reject_new[y]=rejected_mark[y];
      }
    for (int y = 0; y < area_count; y++) 
      { // Skip top and bottom edges
         area_new[y]=f_area[y];
         am_new[y]=new_mark[y];
      }
      
      int[] area_pos_arr=new int[area_count];
      int area_pos_count=0;
      for (int y = 0; y < area_count; y++) 
      { // Skip top and bottom edges
        
        area_pos_count=0;
        for (int i = 0; i < img.height; i++) 
          { // Skip top and bottom edges
          for (int j = 0; j < img.width; j++) 
              { // Skip left and right edges
                
                pos = (i)*img.width + (j);
                if(pix[pos]==am_new[y])
                {
                  mark_pix_arr_for_depth[pos]= (y == 0) ? (-1) : y;
                  mark_pix_arr[y][pos]=1;
                  area_pos_count++;
                  colored_mark[pos]=-1;
                 // output.println(y + "\t" + pos);
                 }
              }
         }
         area_pos_arr[y]=area_pos_count;
         //println(am_new[y]);
      }
    //  output.flush(); // Writes the remaining data to the file
     // output.close(); // Finishes the file
    println(area_count);
    
    PImage passtwo = createImage(img.width, img.height, RGB);
  
    for (int i = 0; i < area_count; i++)
    {
      for (int y = 0; y < img.height; y++) 
      { // Skip top and bottom edges
         
      for (int x = 0; x < img.width; x++) 
          { // Skip left and right edges
            
            pos = (y)*img.width + (x);
            col =(int)green(img.pixels[pos]);
            if(colored_mark[pos]!=(-1))
            {
               col=0;
               white_pixel_count[pos]=0;
            }
            if(col == 255)white_pixel_count[pos]=1;
           passtwo.pixels[(y)*img.width + (x)] = color(col,col,col);
           passtwo.updatePixels();
        }
      }
      
    }
  passtwo.updatePixels();
  image(passtwo,0,0);
  save("FINAL_IMAGE.bmp");
  //return white_pixel_count;
}
