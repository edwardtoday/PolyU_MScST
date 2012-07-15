clear all;%clear the workspace
close all; %close all windows

I1=imread('lenna_c','tif'); %read the lenna image
I2=imread('baboon_c','tif'); %read the baboon image

I1=double(I1);
I2=double(I2);
%convert them to double precision

figure(1);%open a figure window
imshow(I1/255); %show the lenna image
fprintf('press enter to continue \n');
pause

figure(2);%open the second figure window
imshow(I2/255); %show the baboon image
fprintf('press enter to continue \n');
pause

I=(I1+I2)/2; %average the two images
figure(3);% open the third figure window
imshow(I/255); %show the averaged image
fprintf('press enter to continue \n');
pause

imwrite(I/255,'test.tif','tif'); %write the image to "test.tif"
