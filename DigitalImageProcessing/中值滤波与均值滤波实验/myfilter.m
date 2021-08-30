function ImgAfterFilter = myfilter(img, type, q)
% 使用方式：myfilter(img,type,q)
% img为输入图像，type为滤波类型,q为滤波器核大小（>=3的奇数）
% "average"为均值滤波，"median"为中值滤波，"max"为最大值滤波，"min"为最小值滤波
% 其中，均值滤波为线性滤波，其他三种为非线性滤波

if isstring(img)
    image = imread(img);
else
    image = img;
end

flag = 1;
if (ndims(image) == 3)
    flag = 0; 
end

if flag
    outimg=addzero(image,q);
    ImgAfterFilter=process(outimg,type,q);
else
    R = image(:,:,1);outimg_R = addzero(R,q);finalimg_R=process(outimg_R,type,q);
    G = image(:,:,2);outimg_G = addzero(G,q);finalimg_G=process(outimg_G,type,q);
    B = image(:,:,3);outimg_B = addzero(B,q);finalimg_B=process(outimg_B,type,q);
    ImgAfterFilter = cat(3,finalimg_R,finalimg_G,finalimg_B);
end
end

% 补0
function ImgAfterAddZero=addzero(img,q)
[m, n] = size(img);
ImgAfterAddZero = zeros(m+q-1,n+q-1);
for i=1:m
    for j=1:n
        ImgAfterAddZero(i+(q-1)/2,j+(q-1)/2) = img(i,j);
    end
end
end

% 滤波
function finalimg=process(img,type,q)
qq=(q-1)/2;
img = double(img);
[m, n] = size(img);
finalimg = zeros(m+1-q,n+1-q);
for i=qq+1:m-qq
    for j=qq+1:n-qq                           
        pixs=img(i-qq:i+qq,j-qq:j+qq);                                        
        if type == "average"
            finalimg(i-qq,j-qq) = sum(sum(pixs))/(q*q);
        elseif type == "max"
            finalimg(i-qq,j-qq) = max(pixs(:));
        elseif type == "min"
            finalimg(i-qq,j-qq) = min(pixs(:));       
        elseif type == "median"
            finalimg(i-qq,j-qq) = median(pixs(:));
        end
    end
end
finalimg = uint8(finalimg);
end

