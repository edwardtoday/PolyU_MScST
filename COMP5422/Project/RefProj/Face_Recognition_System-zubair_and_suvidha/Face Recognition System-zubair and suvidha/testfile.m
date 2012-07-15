T=18;

%persistent imageno;
%imageno=18;
%load Eigenface.mat;
n=1;
aftermean=[];
I=[];
figure(1);
for i=1:T
    imagee=strcat(int2str(i),'.jpg');% use strcat function to call 36 images in program

    eval('imagg=imread(imagee);');
    subplot(ceil(sqrt(T)),ceil(sqrt(T)),i)% plot them as 6X6 matrix
    imagg=rgb2gray(imagg);
    imagg=imresize(imagg,[200,180],'bilinear');
    [m n]=size(imagg)
    imshow(imagg)
    temp=reshape(imagg',m*n,1);%to get elements along rows we take imagg'
    I=[I temp]
end
m1=mean(I,2);
for i=1:T
    temp=double(I(:,i))
    %     m1=mean(temp);

    I1(:,i)=(temp-m1);% normalizing the imagges by substracting each column with the mean vector
end
%figure(2); %size very big
for i=1:T
    %subplot(ceil(sqrt(T)),ceil(sqrt(T)),i);
    imagg1=reshape(I1(:,i),n,m);%to again get original size so that i can get the value of m and n
    imagg1=imagg1';
    [m n]=size(imagg1);
    %imshow(imagg1);% displays the mean imagges
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
    if(d(i)>(0.0e+008))% we can take any value to suit our algorithm
        sorteigen=[sorteigen, eigenvec(:,i)];
        eigval=[eigval, eigenvalue(i,i)];
    end;
end;
%figure(3)
Eigenfaces=[];
Eigenfaces=a1*sorteigen;% got 36000 X 34 matrix cchanged
%imshow(Eigenfaces);
%reconstruct=a1*Eigenfaces;

for i=1:size(sorteigen,2)
    k=sorteigen(:,i);
    tem=sqrt(sum(k.^2));
    sorteigen(:,i)=sorteigen(:,i)./tem;
end
Eigenfaces=a1*sorteigen; % we will get 36000 X 36 matrix and it will contain normalized vectors
figure(3);
for i=1:size(Eigenfaces,2)
    ima=reshape(Eigenfaces(:,i)',n,m);% to display the eigenfaces now we need to again take imagges in 200x180 format
    ima=ima';
      subplot(ceil(sqrt(T)),ceil(sqrt(T)),i)
     imshow(ima);
end

ProjectedImages=[];
for i = 1 : T
    temp = Eigenfaces'*a1(:,i); % Projection of centered images into facespace
    ProjectedImages = [ProjectedImages temp]; % results are same with both methods
    %except ProjectedImages'=imweight
end
reconstruct=I*
for i=1:size(reconstruct,2)
    ima=reshape(reconstruct(:,i)',n,m);% to display the eigenfaces now we need to again take imagges in 200x180 format
    ima=ima';
      %subplot(ceil(sqrt(T)),ceil(sqrt(T)),i)
    figure(4);
      imshow(ima);
end
