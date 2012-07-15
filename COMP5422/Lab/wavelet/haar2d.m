function [ca,ch,cv,cd]=haar2d(x)
   % haar2d performs a single-level 2-D Haar wavelet decomposition
   % x: input signal
   % ca:approximation coefficients
   % ch:horizontal detail coeffiecients
   % cv:vertical detail coefficients
   % cd:diagonal detail coefficients
   ltemp=(x(:,2:size(x,2))+x(:,1:size(x,2)-1));
   htemp=(x(:,1:size(x,2)-1)-x(:,2:size(x,2)));
   ltemp=ltemp(:,1:2:size(ltemp,2)); %downsampling
   htemp=htemp(:,1:2:size(htemp,2));
   ca=(ltemp(2:size(ltemp,1),:)+ltemp(1:size(ltemp,1)-1,:)); % approaximation coefficients
   ch=(ltemp(1:size(ltemp,1)-1,:)-ltemp(2:size(ltemp,1),:)); % horizontal detail coeffiecients
   cv=(htemp(2:size(htemp,1),:)+htemp(1:size(htemp,1)-1,:)); % vertical detail coefficients
   cd=(htemp(1:size(htemp,1)-1,:)-htemp(2:size(htemp,1),:)); % diagonal detail coefficients
   ca=ca(1:2:size(ca,1),:)/2;
   ch=ch(1:2:size(ch,1),:)/2;
   cv=cv(1:2:size(cv,1),:)/2;
   cd=cd(1:2:size(cd,1),:)/2;