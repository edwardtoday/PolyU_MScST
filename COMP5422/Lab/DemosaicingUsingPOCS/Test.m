%
% Test POCS-based demosaicking algorithm
%
% For details, please refer to the paper:
%  	Color plane interpolation using alternating projections 
%		Gunturk, B.K.; Altunbasak, Y.; Mersereau, R.M. 
%		Image Processing, IEEE Transactions on , Volume: 11 Issue: 9 , Sept 2002 
%		Page(s): 997 -1013
%
%
% Bahadir K. Gunturk
% Department of Electrical and Computer Engineering
% Louisiana State University
% Email: bahadir@ece.lsu.edu
% URL  : http://www.ece.lsu.edu/~bahadir


clear all;

% Read image
a = imread('16small.tif');

% Create Bayer sampled mosaic 
X = mosaic(a);

% Bilinear interpolation
[RGB_bilinear] = interp_bilinear(X);
imshow(uint8(RGB_bilinear)); title('Demosaicking using bilinear interpolation');


% Demosaicing Using Alternating Projections
N_iter = 5;
T = 0.02;
out_pocs = d_pocs(X, N_iter, T);

% Display result
figure; imshow(uint8(out_pocs)); title('Demosaicking using alternating projections');


