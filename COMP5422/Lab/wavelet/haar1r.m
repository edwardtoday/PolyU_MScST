function y=haar1r(ca,ch)
 % haar1r performs a single-level 1-D Haar wavelet reconstruction
 % ca:approximation coefficients
 % ch:detail coefficients
 % y: reconstruction signal
ca = dyadup(ca,'c'); %upsampling along the row direction
ch = dyadup(ch,'c');
yyca=(ca(1,2:size(ca,2))+ca(1,1:size(ca,2)-1)); % convolution of approximation coefficients and low-pass reconstruction filter
yych=(ch(1,2:size(ch,2))-ch(1,1:size(ch,2)-1));
y=yyca+yych;