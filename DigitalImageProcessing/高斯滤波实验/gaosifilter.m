function ImgAfterFilter = gaosifilter(img,q,segma)
% 高斯滤波
% img为待处理的图像，q为滤波器核大小（>=3的奇数）,segma为标准差
if isstring(img)
    img1 = imread(img);
else
    img1 = img;
end

flag = 1;
if (ndims(img1) == 3)
    flag = 0; 
end

% 高斯核
conv = double(zeros(q,q));
s = 0;
center  = (q+1)/2;
for i=1:q
	for j=1:q
		% 利用高斯函数计算模板的各个参数
		temp = exp ( -((i-center)^2 + (j-center)^2) / 2*(segma^2) );
		conv(i,j) = temp / (2*pi*segma^2);
		s =s +  conv(i,j);
	end
end
conv = conv ./ s;

if flag
    ImgAfterAddZero=addzero(img1,q);
    ImgAfterFilter=process(ImgAfterAddZero,conv,q);
else
    R = img1(:,:,1);ImgAfterAddZero_R = addzero(R,q);finalimg_R=process(ImgAfterAddZero_R,conv,q);
    G = img1(:,:,2);ImgAfterAddZero_G = addzero(G,q);finalimg_G=process(ImgAfterAddZero_G,conv,q);
    B = img1(:,:,3);ImgAfterAddZero_B = addzero(B,q);finalimg_B=process(ImgAfterAddZero_B,conv,q);
    ImgAfterFilter = cat(3,finalimg_R,finalimg_G,finalimg_B);
end
end


function  outimg = process(img,conv,q)
img1=double(img);
[m, n] = size(img1);
myimg = zeros(m+1-q,n+1-q);
% 用高斯滤波处理
qq=(q-1)/2;
for i=qq+1:m-qq
    for j= qq+1:n-qq
		%卷积：模板与图像对应部分相乘再累加
        pixs=img1(i-qq:i+qq,j-qq:j+qq);   
        new=sum(sum(conv.*pixs'));
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