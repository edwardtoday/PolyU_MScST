
clear all;%clear the workspace
close all; %close all windows

im1=double(imread('lenna256_c','tif')); %read the lenna image
im2=double(imread('baboon256_c','tif')); %read the baboon image

figure(1),clf;
imshow(im1/255);
pause

figure(2),clf;
imshow(im2/255);
pause

%%%%%%%%%%%%%%%%%%%
[ymax, xmax, c] = size(im1); %get the size of im1
%ymax is the row number, xmax is the column number and c=3 for color images

m = ymax/xmax;

tmax = 1;
dmax = sqrt(xmax*xmax+ymax*ymax);
out = zeros(ymax,xmax,3);

for t=0:0.1:tmax

    dtrans = dmax*t/tmax;

    for y=1:ymax
        for x=1:xmax
            d = dmax/2 * (y+m*x)/ymax;
            if d < dtrans
                out(y,x,:) = im1(y,x,:);
            else
                out(y,x,:) = im2(y,x,:);
            end
        end
    end
    figure(3),clf;
    imshow(out/255);
end
