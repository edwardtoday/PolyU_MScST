function [gpout] = gabor_wavelet(I,u,v);
if isa(I,'double')~=1 
    I = double(I);
end
%computes size of image
k1 = pi * 2^(-(v+2)/2);
k = k1*k1;
sig = 4*pi*pi;
pha = u*(pi/8);
kv = [k1*cos(pha),k1*sin(pha)];
[m n]=size(I);
for x=1:m
    for y=1:n
        z = x^2 + y^2;
        zv = [x;y];
        G(x,y) = k/sig * exp(-1*k*z/2/sig)*(exp(i*kv*zv )-exp(-sig/2));
    end
end
gabout1 = conv2(I,G);
gpout = angle(gabout1)*180/pi;