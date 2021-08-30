img = imread("Fig0342.tif");
img2 = sobel("Fig0342.tif");
figure
    subplot(121),imshow(img),title('原图');
    subplot(122),imshow(img2),title('Sobel梯度');