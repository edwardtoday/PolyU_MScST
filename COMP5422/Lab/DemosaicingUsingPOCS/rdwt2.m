%
% RDWT2 -> 2D Redundant Discrete Wavelet Transform
%		RDWT2 decomposes an image into its subbands. 
%
%		[a,h,v,d] = rdwt2(x,h0,h1) 
%		x 			-> Input image 
%		h0,h1 	    -> Low-pass and high-pass filters for subband decomposition
%		a,h,v,d 	-> approximation, horizontal detail, vertical detail, and diagonal detail subbands
%
% Bahadir K. Gunturk
% Department of Electrical and Computer Engineering
% Louisiana State University
% Email: bahadir@ece.lsu.edu
% URL  : http://www.ece.lsu.edu/~bahadir

function [a,h,v,d] = rdwt2(x,h0,h1)

[height,width] = size(x);
t0 = ceil(length(h0)/2);

% h0,h1,g0,g1 are row vectors...
z = conv2(x,h0);
a = conv2(z,h0'); a = a(t0:t0+height-1,t0:t0+width-1);
h = conv2(z,h1'); h = h(t0:t0+height-1,t0:t0+width-1);

z = conv2(x,h1);
v = conv2(z,h0'); v = v(t0:t0+height-1,t0:t0+width-1);
d = conv2(z,h1'); d = d(t0:t0+height-1,t0:t0+width-1);



