%
% RIDWT2 -> 2D Redundant Inverse Discrete Wavelet Transform
%		RIDWT2 reconstructs the image from its subbands. 
%
%		x = ridwt2(a,h,v,d,g0,g1) 
%		x 			-> Reconstructed image 
%		a,h,v,d 	-> approximation, horizontal detail, vertical detail, and diagonal detail subbands
%		g0,g1 	    -> Synthesizing filters
%
% Bahadir K. Gunturk
% Department of Electrical and Computer Engineering
% Louisiana State University
% Email: bahadir@ece.lsu.edu
% URL  : http://www.ece.lsu.edu/~bahadir

function x = ridwt2(a,h,v,d,g0,g1)

[height,width] = size(a);
t0 = ceil(length(g0)/2);

x = conv2(g0,g0,a)+ ... % Approximation.
    conv2(g1,g0,h)+ ... % Horizontal Detail.
    conv2(g0,g1,v)+ ... % Vertical Detail.
    conv2(g1,g1,d);     % Diagonal Detail.
 
 x = x(t0:t0+height-1,t0:t0+width-1);
 
 
 