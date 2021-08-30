function psnr = PSNR(img1,img2)
% 峰值信噪比

if isstring(img1)
    img11 = double(imread(img1));
else
    img11 = double(img1);
end
if isstring(img2)
    img22 = double(imread(img2));
else
    img22 = double(img2);
end

if (ndims(img11) == 3)
    img11=rgb2gray(img11);
end

if (ndims(img22) == 3)
    img22=rgb2gray(img22);
end

k = 8;
%k为图像是表示每个像素点所用的二进制位数，即位深。
fmax = 2.^k - 1;
a = fmax.^2;
[m,n]=size(img11);
R=0;
for i = 1:m
   for j = 1:n
      R=R+(img11(i,j)-img22(i,j))^2;
   end
end

MSE = R/(m*n);
psnr = 10*log10(a/MSE);
end