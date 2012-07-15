clear all;

I=imread('lena.tif', 'tif');
I=double(I);

T=100; %set the threshold

B=(I>100);
%B will be a binary image that has the same size of I. 
%For those positions where I's value are greater than 100, the values in B
%will be 1; in other positions, the values in B are 0.

figure(1),clf;
imshow(I, [0 255]); % show the 8-bit image I

figure(2),clf;
imshow(B, [0 1]); % show the 1-bit image B