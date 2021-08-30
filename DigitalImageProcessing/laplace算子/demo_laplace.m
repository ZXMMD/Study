img = imread("Fig0338.tif");
img2 = laplace("Fig0338.tif");
img3 = img - img2;
figure
    subplot(131),imshow(img),title('原图');
    subplot(132),imshow(img2),title('laplace图像');
    subplot(133),imshow(img3),title('锐化后图像');