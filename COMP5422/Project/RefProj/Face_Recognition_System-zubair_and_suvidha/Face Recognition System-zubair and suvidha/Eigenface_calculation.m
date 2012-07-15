function [T,m1, Eigenfaces, ProjectedImages, imageno]=Eigenface_calculation(imageno);% we need to make it a function to increase modularity of our program
T=imageno;
n=1;
aftermean=[];
I=[];
figure(1);
T=imageno;
for i=1:T
    imagee=strcat(int2str(i),'.jpg');% use strcat function to call T no of images

    eval('imagg=imread(imagee);');
    subplot(ceil(sqrt(T)),ceil(sqrt(T)),i)% plot them as matrix
    imagg=rgb2gray(imagg);
    imagg=imresize(imagg,[200,180],'bilinear');
    [m n]=size(imagg)
    imshow(imagg)
    temp=reshape(imagg',m*n,1);%to get elements along rows we take imagg'
    I=[I temp]
end
m1=mean(I,2);
 ima=reshape(m1',n,m);% to display the eigenfaces now we need to again take images in 200x180 format
     ima=ima';
     figure,imshow(ima);

for i=1:T
    temp=double(I(:,i))
    I1(:,i)=(temp-m1);% normalizing the images by substracting each column with the mean vector
end
for i=1:T
    subplot(ceil(sqrt(T)),ceil(sqrt(T)),i);
    imagg1=reshape(I1(:,i),n,m);%to again get original size so that we can get the value of m and n
    imagg1=imagg1';
    [m n]=size(imagg1);
    imshow(imagg1);% displays the mean images
end
a1=[];
for i=1:T% to change the format of values to double
    te=double(I1(:,i));
    a1=[a1,te];
end
a=a1';
covv=a*a';

[eigenvec eigenvalue]=eig(covv);
d=eig(covv);
sorteigen=[];
eigval=[];
for i=1:size(eigenvec,2);  %takes no of col of eigenvec
    if(d(i)>(0.5e+008))% we can take any value to suit our algorithm
        % this values generally are taken by trial and error
        sorteigen=[sorteigen, eigenvec(:,i)];
        eigval=[eigval, eigenvalue(i,i)];
    end;
end;
Eigenfaces=[];
Eigenfaces=a1*sorteigen;% got matrix of principal Eigenfaces

for i=1:size(sorteigen,2)
    k=sorteigen(:,i);
    tem=sqrt(sum(k.^2));
    sorteigen(:,i)=sorteigen(:,i)./tem;
end
Eigenfaces=a1*sorteigen; 
figure(4);
for i=1:size(Eigenfaces,2)
    ima=reshape(Eigenfaces(:,i)',n,m);% to display the eigenfaces now we need to again take images in 200x180 format
    ima=ima';
      subplot(ceil(sqrt(T)),ceil(sqrt(T)),i)
     imshow(ima);
end

ProjectedImages=[];
for i = 1 : T
    temp = Eigenfaces'*a1(:,i); % Projection of centered images into facespace
    ProjectedImages = [ProjectedImages temp]; 
    end
end