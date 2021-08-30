function ImgAfterFilter = laplace(img)
% laplace算子锐化图像
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

% laplace算子
% g = [1 1 1;1 -8 1;1 1 1];
g=[0 1 0;1 -4 1;0 1 0];
if flag
    ImgAfterAddZero=addzero(img1,3);
    ImgAfterFilter=process(ImgAfterAddZero,g);
else
    R = img1(:,:,1);ImgAfterAddZero_R = addzero(R,3);finalimg_R=process(ImgAfterAddZero_R,g);
    G = img1(:,:,2);ImgAfterAddZero_G = addzero(G,3);finalimg_G=process(ImgAfterAddZero_G,g);
    B = img1(:,:,3);ImgAfterAddZero_B = addzero(B,3);finalimg_B=process(ImgAfterAddZero_B,g);
    ImgAfterFilter = cat(3,finalimg_R,finalimg_G,finalimg_B);
end
end

function  outimg = process(img,g)
img1=double(img);
[m, n] = size(img1);
myimg = zeros(m-2,n-2);

for i=2:m-1
    for j= 2:n-1
		%卷积           
		pixs=img1(i-1:i+1,j-1:j+1);        
        new=sum((sum(g.*pixs')));
		%替换掉原像素
		myimg(i-1,j-1) = new;   
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