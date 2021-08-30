function ImgAfterFilter = sobel(img)
% sobel算子锐化图像
% img为待处理的图像
if isstring(img)
    img1 = imread(img);
else
    img1 = img;
end

flag = 1;
if (ndims(img1) == 3)
    flag = 0; 
end

% sobel算子
gy = [-1 -2 -1;0 0 0;1 2 1];
gx = [-1 0 1;-2 0 2;-1 0 1];

if flag
    ImgAfterAddZero=addzero(img1,3);
    ImgAfterFilter=process(ImgAfterAddZero,gx,gy);
else
    R = img1(:,:,1);ImgAfterAddZero_R = addzero(R,3);finalimg_R=process(ImgAfterAddZero_R,gx,gy);
    G = img1(:,:,2);ImgAfterAddZero_G = addzero(G,3);finalimg_G=process(ImgAfterAddZero_G,gx,gy);
    B = img1(:,:,3);ImgAfterAddZero_B = addzero(B,3);finalimg_B=process(ImgAfterAddZero_B,gx,gy);
    ImgAfterFilter = cat(3,finalimg_R,finalimg_G,finalimg_B);
end
end

function  outimg = process(img,gx,gy)
img1=double(img);
[m, n] = size(img1);
myimg = zeros(m-2,n-2);

qq=1;

for i=qq+1:m-qq
    for j= qq+1:n-qq
		%卷积
        pixs=img1(i-1:i+1,j-1:j+1);   
        new=(sum((sum(gx.*pixs')))^2+(sum(sum((gy.*pixs')))^2))^0.5;
		%替换掉原像素
		myimg(i-qq,j-qq) = new;   
    end
end
outimg = uint8(myimg);
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