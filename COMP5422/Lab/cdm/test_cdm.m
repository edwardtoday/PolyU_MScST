clear;

I=imread('kodak_fence.tif','tif');
I=double(I);

figure(1),clf;
imshow(I/255);%show the full color image

%%%%downsample I to Color Filter Array (CFA) image A based on Bayer pattern
[N,M,ch]=size(I);
A=zeros(N,M);
A(1:2:N,1:2:M)=I(1:2:N,1:2:M,2); % G
A(2:2:N,2:2:M)=I(2:2:N,2:2:M,2); % G
A(1:2:N,2:2:M)=I(1:2:N,2:2:M,1); % R
A(2:2:N,1:2:M)=I(2:2:N,1:2:M,3); % B

figure(2),clf;
imshow(A, [0 255]);%show the CFA image

%%%%% Method 1: Nearest Neighbor Replication %%%
I1=nnr(A,3);%refer to function nnr.m

figure(3),clf;
imshow(I1/255);
imwrite(I1/255, 'NNR_I.tif', 'tif');%write the demosaicked image to disk

%%%%% Method 2: Bilinear Interpolation %%%

%Please write the bilinear interpolation code. This is you second assignment.

I2=bilinear_cdm(A);

figure(4),clf;
imshow(I2/255);
imwrite(I2/255, 'BL_I.tif', 'tif');%write the demosaicked image to disk

%%%%% Method 3: Smooth Hue Transition %%%
I3=shtlin(A);%refer to function shtlin.m

figure(5),clf;
imshow(I3/255);
imwrite(I3/255, 'SHT_I.tif', 'tif');%write the demosaicked image to disk

%%%%% Method 4: Gradient-based Color Correction %%%
I4=lcc1(A);%refer to function shtlin.m

figure(6),clf;
imshow(I4/255);
imwrite(I4/255, 'GCC_I.tif', 'tif');%write the demosaicked image to disk

%%%%% Method 5: LMMSE-based demosaicking %%%
I5=dmsc(A);%refer to function dmsc.m

figure(7),clf;
imshow(I5/255);
imwrite(I5/255, 'LMMSE_I.tif', 'tif');%write the demosaicked image to disk

