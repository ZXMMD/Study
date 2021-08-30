## prewitt

+ `prewitt.m`用来检测图像边缘

+ `Prewitt`算子是一种一阶微分算子，利用像素点上下左右邻点灰度差，在边缘处达到极值检测边缘，对噪声抑制作用。

+ 示例：`demo_prewitt.m`

  ```matlab
  img = imread("lena512.bmp");
  img2 = prewitt("lena512.bmp");
  figure
      subplot(121),imshow(img),title('原图');
      subplot(122),imshow(img2),title('Prewitt算子提取边缘');
  ```

![prewitt](image/prewitt.PNG)