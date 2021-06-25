int map_value(int in_value, int in_min, int in_max, int out_min, int out_max)
{
  return (in_value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}
private void floodFill(PImage image, int x, int y){
    //set to true for fields that have been checked
    boolean[][] painted  = new boolean[image.width][image.height];

    //skip black pixels when coloring
    int blackColor =0;

    queue.clear();
    queue.add(new Point(x, y));

    while(!queue.isEmpty()){
        Point temp = queue.remove();
        int temp_x = (int)temp.getX();
        int temp_y = (int)temp.getY();

        //only do stuff if point is within pixmap's bounds
        if(temp_x >= 0 && temp_x < image.width && temp_y >= 0 && temp_y < image.height) {
            //color of current point
             pos = (temp_y)*image.width + (temp_x);
            int pixel =(int)green(image.pixels[pos]);
            if (!painted[temp_x][temp_y] && pixel != blackColor) {
                painted[temp_x][temp_y] = true;
                  image.pixels[pos] = color(0,0,0); 
           
                queue.add(new Point(temp_x + 1, temp_y));
                queue.add(new Point(temp_x - 1, temp_y));
                queue.add(new Point(temp_x, temp_y + 1));
                queue.add(new Point(temp_x, temp_y - 1));

            }
        }
    }}
int[] bubbleSort(int arr[]) 
    { 
        int n = arr.length; 
        for (int i = 0; i < n-1; i++) 
        {
            for (int j = 0; j < n-i-1; j++) 
              {
                if (arr[j] > arr[j+1]) 
                { 
                    // swap arr[j+1] and arr[i] 
                    int temp = arr[j]; 
                    arr[j] = arr[j+1]; 
                    arr[j+1] = temp; 
                }
              }
        }
        return arr;  
    } 
