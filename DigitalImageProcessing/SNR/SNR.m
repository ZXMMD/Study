function snr=SNR(img1,img2)
% SNR 信噪比
% img1为原始图像，img2为去噪后图像

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

[m,n]=size(img11);
S=0;
for i = 1:m
   for j = 1:n
      S=S+img11(i,j)^2;
   end
end

R=0;
for i = 1:m
   for j = 1:n
      R=R+(img11(i,j)-img22(i,j))^2;
   end
end

snr=10*log10(S/R);
end