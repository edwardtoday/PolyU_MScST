clear all;
clc;

parent = 'C:\Documents and Settings\Neeraj.NEERAJ\Desktop\Final Project\CroppedYale\yaleB';
for i = 1:38
    direct = strcat(parent,int2str(i));
    addpath(direct);
    for j = 1:65
        imgsrc = strcat(int2str(i),' (',int2str(j),').pgm');
        a = imread(imgsrc);
        imgdst = strcat(int2str(i),'_',int2str(j),'.jpg');
        imwrite(a,imgdst);
    end
end