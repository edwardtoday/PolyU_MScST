function y=haar2r(ca,ch,cv,cd)
% haar2d performs a single-level 2-D Haar wavelet reconstruction
% ca:approximation coefficients
% ch:horizontal detail coeffiecients
% cv:vertical detail coefficients
% cd:diagonal detail coefficients
% y: reconstruction signal
ca = dyadup(ca,'r');% upsampling along the column direction
ch = dyadup(ch,'r');
cv = dyadup(cv,'r');
cd = dyadup(cd,'r');
yca=ca(2:size(ca,1),:)+ca(1:size(ca,1)-1,:);% convolution of approximation coefficients and low-pass reconstruction filter
ycv=cv(2:size(cv,1),:)+cv(1:size(cv,1)-1,:);
ych=-ch(1:size(ch,1)-1,:)+ch(2:size(ch,1),:);
ycd=-cd(1:size(cd,1)-1,:)+cd(2:size(cd,1),:);
yca = dyadup(yca,'c'); % upsampling along the row direction
ych = dyadup(ych,'c');
ycv = dyadup(ycv,'c');
ycd = dyadup(ycd,'c');
yyca=(yca(:,2:size(yca,2))+yca(:,1:size(yca,2)-1))/2;
yych=(ych(:,2:size(ych,2))+ych(:,1:size(ych,2)-1))/2;
yycv=(-ycv(:,1:size(ycv,2)-1)+ycv(:,2:size(ycv,2)))/2;
yycd=(-ycd(:,1:size(ycd,2)-1)+ycd(:,2:size(ycd,2)))/2;
y=yyca+yych+yycv+yycd;

   