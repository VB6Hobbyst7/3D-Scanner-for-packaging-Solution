import KinectPV2.*;
import java.util.ArrayList;
import java.nio.*;
import java.awt.Point;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;
import javax.imageio.ImageIO;
import javax.management.Query; 
import milchreis.imageprocessing.*;
import java.util.Random;
import java.awt.*;
import java.awt.image.*;
import java.io.*;
import javax.imageio.*;
import javax.swing.*;

boolean record = false;

boolean permit=false;
KinectPV2 kinect;

int RGB_Access=0,Depth_Access=0,Depth_Hold=1;   // Verified
int depth_pic_count=0;             // Verified

double gi_temp=0,gs_temp=0;
float temp_x=0,temp_y=0, min=0,max=255,val=0,col_sum=0,sigmaI=12,sigmaS=16 ;
int a=1,div=0,sum_red=0,sum_green=0,sum_blue=0,acc_red=0,acc_green=0,acc_blue=0,edge_pos=0,high_thresh=0,low_thresh=0,high_sum=0,low_sum=0;
int high_thresh_count=0,low_thresh_count=0,filter=0,color_count=0,pic_count=0;           
int mark_count=0,zero_count=4,depth_area_count=0,variable=0;
    
float[] class_variance=new float[256];
float[] temp_class_variance=new float[256];

int[] otsu_count=new int[256];
float back_variance_sum=0;
float fore_variance_sum=0;
float mean_back_count=0;
float mean_fore_count=0;
float mean_back=0;
float mean_fore=0;
float fore_variance=0;
float back_variance=0, weight_prob_back=0,weight_prob_fore=0;
int back_count=0;
int fore_count=0;
float pixel_val=0;
float blue_val=0;
float red_val=0;

int[] pix=new int[8041500];
int[] sub_parent=new int[8041500];
int[] pix0=new int[8041500];
int[] pix1=new int[8041500];
int[] mark_pix_arr_for_depth=new int[2073600];   // Verified
   
long[] integral_value=new long[2073600];
int[] white_pixel_count = new int[2073600];
int[][] parent=new int[11250][11250];
int[][] temp_parent=new int[1125][1125];
int[] mark_var=new int[100000];
 
int [] depthRaw;     // Verified
int[] RGBtoDepth=new int[2073600];  // Verified
int[] temporary_depth=new int[2073600];   // Verified
       
int col=0,col3=0,col2=0,c_count=0;
int pixel_sum=0,pos=0,pos1=0,count=0,x,y;
int green_val=0,green_val2=0,green_val3=0;
int temp=1,temp_c1=0,temp_c2=0,temp_c3=0,temp_c4=0,temp_c5=0;
private static JFrame frame;
private static JLabel label;
Queue<Point> queue = new LinkedList<Point>();

int [] depthZero;


//BUFFER ARRAY TO CLEAN DE PIXLES
PImage grayImg, filteredImg;       // Verified
PImage depthToColorImg;   //
PImage img , passone,depth, img_for_OTSU,img_for_Adaptive ;
PImage binaryImg,temp_img;                  // Verified  
PImage newImg ,fill_col,binaryImg2;
PrintWriter output;
PrintWriter RGB_to_DEPTH_coordinates;
PrintWriter Depth;
