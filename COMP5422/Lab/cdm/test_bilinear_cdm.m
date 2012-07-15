clear;

I=imread('kodak_fence.tif','tif');
I=double(I);
figure,imshow(I/255);

[N,M,ch]=size(I);
A=zeros(N,M);
A(1:2:N,1:2:M)=I(1:2:N,1:2:M,2); % G
A(2:2:N,2:2:M)=I(2:2:N,2:2:M,2); % G
A(1:2:N,2:2:M)=I(1:2:N,2:2:M,1); % R
A(2:2:N,1:2:M)=I(2:2:N,1:2:M,3); % B

%% Bilinear interpolation
tic;
I2=bilinear_cdm(A);
toc;

%% Show results
% figure;
% subplot(2,2,1), subimage(I/255), title('Original'), axis off;
% subplot(2,2,2), subimage(I2/255), title('Bilinear Interpolated'), axis off;
% subplot(2,2,3), subimage(A/255), title('CFA'), axis off;
% subplot(2,2,4), subimage(abs(I-I2)/255), title('Diff'), axis off;

figure,imshow(I2/255);          % The interpolated image
figure,imshow(abs(I-I2)/255);   % Diff between original image and interpolation