function [outputimage]=Recognition(T,m1, Eigenfaces, ProjectedImages, imageno);
MeanInputImage=[];
[fname pname]=uigetfile('*.jpg','Select the input image for recognition');
InputImage=imread(fname);
InputImage=rgb2gray(InputImage);
InputImage=imresize(InputImage,[200 180],'bilinear');%resizing of input image. This is a part of preprocessing techniques of images
[m n]=size(InputImage);
imshow(InputImage);
Imagevector=reshape(InputImage',m*n,1);%to get elements along rows as we take InputImage'
MeanInputImage=double(Imagevector)-m1;
ProjectInputImage=Eigenfaces'*MeanInputImage;% here we get the weights of the input image with respect to our eigenfaces
% next we need to euclidean distance of our input image and compare it
% with our face space and check whether it matches the answer...we need
% to take the threshold value by trial and error methods
Euclideandistance=[];
for i=1:T
    temp=ProjectedImages(:,i)-ProjectInputImage;
    Euclideandistance=[Euclideandistance temp];
end
% the above statements will get you a matrix of Euclidean distance and you
% need to normalize it and then find the minimum Euclidean distance
tem=[];
for i=1:size(Euclideandistance,2)
    k=Euclideandistance(:,i);
    tem(i)=sqrt(sum(k.^2));
end
% We now set some threshold values to know whether the image is face or not
% and if it is a face then if it is known face or not
% The threshold values taken are done by trial and error methods
[MinEuclid, index]=min(tem);
if(MinEuclid<0.8e008)
if(MinEuclid<0.35e008)
    outputimage=(strcat(int2str(index),'.jpg'));
    figure,imshow(outputimage);
    switch index % we are entering the name of the persons in the code itself
        % There is no provision of entering the name in real time
        case 1
            disp('Jonathan Swift');
            disp('Age=22');
        case 2
            disp('Eliyahu Goldratt');
            disp('Age=25');
        case 3
            disp('Anpage');
            disp('Age=35');
        case 4
            disp('Rizwana');
            disp('Age=30');
        case 5
            disp('Rihana');
            disp('Age=48');
        case 6
            disp('Seema');
            disp('Age=19');
        case 7
            disp('Kasana');
            disp('Age=27');
        case 8
            disp('Hanifa');
            disp('Age=33');
        case 9
            disp('Alefiya');
            disp('Age=22');
        case 10
            disp('Mamta');
            disp('Age=50');
        case 11
            disp('Mayawati');
            disp('Age=39');
        case 12
            disp('Elizabeth');
            disp('Age=87');
        case 13
            disp('Cecelia Ahern');
            disp('Age=78');
        case 14
            disp('Shaista Khatun');
            disp('Age=56');
        case 15
            disp('Rahisa Khatun');
            disp('Age=45');
        case 16
            disp('Ruksana');
            disp('Age=64');
        case 17
            disp('Parizad Zorabian');
            disp('Age=38');
        case 18
            disp('Heena kundanani');
            disp('Age=20');
        case 19
              disp('Setu Savani');
              disp('Age=21');
         case 20
             disp('Mohd Zubair Saifi');
             disp('Age=20');
         otherwise
            disp('Image in database but name unknown')
    end

else
    disp('No matches found');
    disp('You are not allowed to enter this system');
    outputimage=0;
end
else
    disp('Image is not even a face');
    outputimage=0;
end
save test2.mat % this is used to save the variables of the file and thus can be used to set Eigenvalues
end
