function grayhistogram(img)
% 绘制图像的灰度直方图
% 请输入完整的文件路径，彩色图像或者灰度图像

if isstring(img)
    image = imread(img);
else
    image = img;
end
drawhist(image);
end

function drawhist(image)
if (ndims(image) == 2)
    myhist(image);title("灰度直方图");
else
    R = image(:,:,1);
    G = image(:,:,2);
    B = image(:,:,3);
    subplot(131), myhist(R); title("R通道灰度直方图");
    subplot(132), myhist(G); title("G通道灰度直方图");
    subplot(133), myhist(B); title("B通道灰度直方图");
end
end


function myhist(img)
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