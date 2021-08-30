function HistogramEqualization(imgname)
% 直方图均衡
% 请输入完整的文件路径,彩色图像或者灰度图像
img = imread(imgname);

flag = 1;
if (ndims(img) == 3)
    flag = 0; 
end

if flag
    outimg = Equalization(img);
    figure(1)
    subplot(121),imshow(img),title('原灰度图');
    subplot(122),imshow(mat2gray(outimg)),title('均衡化后');

    figure(2)
    subplot(121),grayhistogram(img),title('原图像直方图');
    subplot(122),grayhistogram(outimg),title('均衡化后的直方图');
else
    R = img(:,:,1);outimg_R = Equalization(R);
    G = img(:,:,2);outimg_G = Equalization(G);
    B = img(:,:,3);outimg_B = Equalization(B);
    outimg = cat(3,outimg_R,outimg_G,outimg_B);
    
    figure(1)
    subplot(121),imshow(img),title('原图');
    subplot(122),imshow(mat2gray(outimg)),title('均衡化后');
    
    figure(2)
    subplot(231),grayhistogram(img),title('原图像R通道直方图');
    subplot(232),grayhistogram(img),title('原图像G通道直方图');
    subplot(233),grayhistogram(img),title('原图像B通道直方图');
    subplot(234),grayhistogram(outimg_R),title('均衡化后R通道直方图');
    subplot(235),grayhistogram(outimg_G),title('均衡化后G通道直方图');
    subplot(236),grayhistogram(outimg_B),title('均衡化后B通道直方图');
end
end

function outimg = Equalization(img)
[m,n] = size(img);

% 计算直方图
his = zeros(1, 256); 
for i = 1:m
   for j = 1:n
      k = img(i, j); 
      his(k+1) = his(k+1) + 1; 
   end
end

% 计算累加直方图
for i = 2:256
    his(i) = his(i) + his(i-1);
end

% 计算新的灰度级
gray = zeros(1, 256); 
for i = 1:256
    gray(i) = 255/(m*n)*his(i);
end

% 用新的灰度级替换原来的灰度级
outimg = zeros(m, n);
for i = 1:m
   for j = 1:n
      k = img(i, j); 
      outimg(i, j) = uint8((gray(k))); 
   end
end

end

function grayhistogram(img)
[m,n] = size(img);

N = zeros(1, 256); 

for i = 1:m
   for j = 1:n
       k = img(i, j); 
       N(k+1) = N(k+1) + 1;  
   end
end
bar(N);
axis tight;  
end