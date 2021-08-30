img = imread("lena512.bmp");
img2 = prewitt("lena512.bmp");
figure
    subplot(121),imshow(img),title('原图');
    subplot(122),imshow(img2),title('Prewitt算子提取边缘');