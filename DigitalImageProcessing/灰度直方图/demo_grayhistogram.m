img = imread("lena512.bmp");

figure
subplot(121),imshow(img),title('原图');
subplot(122),grayhistogram(img),title('灰度直方图');
