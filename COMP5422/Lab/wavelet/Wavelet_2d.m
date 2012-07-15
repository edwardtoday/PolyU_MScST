clear all;

%%read an image
X=imread('lena.png');
x1=double(X);
x=x1;
figure(1),imshow(X); % show the original image

%%decompose the image into 3 scales
for i=1:3
   [ca,ch,cv,cd]=haar2d(x); % wavelet decomposition using the Haar wavelet 
   x=ca;
   a{i}=ca;
   h{i}=ch;
   v{i}=cv;
   d{i}=cd;
end
t1=[a{1} h{1}; v{1} d{1}];
tt2=[a{2} h{2}; v{2} d{2}];
ttt3=[a{3} h{3}; v{3} d{3}];
t2=[tt2 h{1}; v{1} d{1}];
tt3=[ttt3 h{2}; v{2} d{2}];
t3=[tt3 h{1}; v{1} d{1}];
figure(2),imshow(uint8(abs(t1)));
figure(3),imshow(uint8(abs(t2)));
figure(4),imshow(uint8(abs(t3)));

%%reconstruct the image
for i=3:-1:1
   y{i}=haar2r(ca,h{i},v{i},d{i}); % wavelet reconstruction using the Haar wavelet
   ca=y{i};
end
rry2=[y{3} abs(h{2}); abs(v{2}) abs(d{2})];
ry2=[rry2 abs(h{1}); abs(v{1}) abs(d{1})];
ry1=[y{2} abs(h{1}); abs(v{1}) abs(d{1})];
figure(5),imshow(uint8(ry2));
figure(6),imshow(uint8(ry1));
figure(7),imshow(uint8(y{1}));

%%reconstruction error
yv=y{1}-x1; % reconstruction error
figure(8),imshow(uint8(abs(yv)));

err=mean(mean(yv.^2)) %%the power of reconstruction error;
%% we will see the power of reconstruction error is 0, which means a
%% perfect reconstruction
