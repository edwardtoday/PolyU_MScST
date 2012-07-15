clear all;

%%generate a signal
x=-20:0.3:18.3;
yy=-6*ones(1,size(x,2)).*(x<-6)+3*ones(1,size(x,2)).*(x<8.3)-5*ones(1,size(x,2)).*(x>3); % generate a 1-D signal
figure(1),plot(1:size(yy,2),yy),title('original signal');
y=yy;

%%decomposition
chtemp=[];
for i=1:3
   [ca,ch]=haar1d(y); % wavelet decomposition using the Haar wavelet
   y=ca;
   h{i}=ch;
   a{i}=ca;
end
figure(2),
chtemp1=h{1}; 
subplot('position',[0.03,0.11,0.4,0.81]),plot(1:size(a{1},2),a{1}), title('approximation coefficients at scale 1' );
subplot('position',[0.5,0.11,0.4,0.81]),plot(1:size(chtemp1,2),chtemp1),title('detail coefficients');
figure(3),
chtemp2=[h{2} h{1}]; 
subplot('position',[0.06,0.11,0.3,0.81]),plot(1:size(a{2},2),a{2}), title('approximation coefficients at scale 2' );
subplot('position',[0.5,0.11,0.42,0.81]),plot(1:size(chtemp2,2),chtemp2),title('detail coefficients');
figure(4),
chtemp3=[h{3} h{2} h{1}];
subplot('position',[0.13,0.11,0.2,0.81]),plot(1:size(a{3},2),a{3}), title('approximation coefficients at scale 3' );
subplot('position',[0.5,0.11,0.45,0.81]),plot(1:size(chtemp3,2),chtemp3),title('detail coefficients');

%%reconstruction
for i=3:-1:1
   y=haar1r(ca,h{i}); % wavelet reconstruction using the Haar wavelet
   ca=y;
   ry{i}=y;
end
figure(5),
subplot('position',[0.06,0.11,0.3,0.81]),plot(1:size(ry{3},2),ry{3}), title('reconstructed coefficients at scale 2' );
subplot('position',[0.5,0.11,0.42,0.81]),plot(1:size(chtemp2,2),chtemp2),title('detail coefficients');
figure(6),
subplot('position',[0.03,0.11,0.4,0.81]),plot(1:size(ry{2},2),ry{2}), title('reconstructed coefficients at scale 1' );
subplot('position',[0.5,0.11,0.4,0.81]),plot(1:size(chtemp1,2),chtemp1),title('detail coefficients');
figure(7),plot(1:size(ry{1},2),ry{1}),title('reconstructed coefficients at the original scale' );

%%calculate the reconstruction error
yv=yy-y; % reconstruction error
figure(8),plot(1:size(yv,2),yv),title('reconstruction error' );
err=mean(yv.^2) %%the power of reconstruction error;
%% we will see the power of reconstruction error is 0, which means a
%% perfect reconstruction
