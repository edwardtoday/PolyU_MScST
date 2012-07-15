%To read probe image
function face_recognition
clear all; close all;
% n1 = randperm(45);
% n =n1(15);
n=40;
s = zeros(40);
Probe_num = n;
cd(strcat('database\s',num2str(n)));
% n1 = randperm(3);
% n =n1(1);
n=10;
a = imread(strcat(num2str(n),'.pgm'));
% imshow(a);
% title('Probe image');
% drawnow;
%cd('C:\Users\user\Desktop\Face Recognition');
cd ..
cd ..
[HLGPP_CRe, HLGPP_CIm, HGGPP_CRe, HGGPP_CIm] = HGPP_image(a);
figure;
subplot(221);
imshow(a);
title(strcat('Probe image --->', num2str(Probe_num),num2str(n)));
load image_database2;
for i= 1:40
    HLGPP_R = hgpp(i).HLGPP_Re;
    HLGPP_I = hgpp(i).HLGPP_Im;
    HGGPP_R = hgpp(i).HGGPP_Re;
    HGGPP_I = hgpp(i).HGGPP_Im;
    [s(i)] = similarity_image(HLGPP_CRe, HLGPP_R, HLGPP_CIm, HLGPP_I, HGGPP_CRe, HGGPP_R, HGGPP_CIm, HGGPP_I);
    cd(strcat('database\s',num2str(i)));
    c = imread('1.pgm');
    subplot(222)
    imshow(c);
    title(strcat('Processed now --->',num2str(i)));
    drawnow;
    %cd('C:\Users\user\Desktop\Face Recognition');    
    cd ..
    cd ..
end
y = max(s(:));
for i=1:44
    if s(i) == y
        cd(strcat('database\s',num2str(i)));
        c = imread('1.pgm');
        subplot(222)
        imshow(c);
        title(strcat('Identified person --->',num2str(i)));
    end
end