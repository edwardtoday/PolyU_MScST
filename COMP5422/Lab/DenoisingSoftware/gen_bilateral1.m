
% 
% Multiresolution Bilateral Filter
%
% by Ming Zhang and Bahadir K. Gunturk
%
% Input Parameters
% a: input image (single channel)
% sigma_d: spatial proximity parameter
% sigma_r: intensity proximity parameter
% window_d: window size parameter. 
%           The size of the window is (2*window_d+1)x(2*window_d+1)
% 
% Output Parameters
% a: denoised image
%
%

function [a] = gen_bilateral1(a,sigma_d,sigma_r,window_d);

window_d = round(double(window_d));
offset = window_d;

 
% Paddarray for the borders
a = padarray(a,[window_d,window_d],'symmetric');
c = a;
[height,width,depth] = size(a);

%%% UNCOMMENT TO TEST MEDIAN FILTERED VERSION %%%
%med_pixels = medfilt2(a);

d = -window_d:1:window_d;
d = d(:);
weights_d = exp(-d.*d/(2*sigma_d*sigma_d));
weights_dd = weights_d * weights_d';

for i=1+offset:height-offset,
    for j=1+offset:width-offset,

        pixels = a(i-window_d:i+window_d,j-window_d:j+window_d);
        weights = weights_dd .* exp(-(pixels-a(i,j)).*(pixels-a(i,j))/(2*sigma_r*sigma_r)) + 0.00000001; % Add a small number to prevent div-by-zero
        
        %%% UNCOMMENT TO TEST MEDIAN FILTERED VERSION %%%
        %weights = weights_dd .*exp(-(pixels-med_pixels(i,j)).*(pixels-med_pixels(i,j))/(2*sigma_r*sigma_r)) + 0.00000001;
        
        weights = weights./sum(sum(weights));
        c(i,j) = sum(sum(weights.*pixels));

    end
end
a=c(1+window_d:height-window_d,1+window_d:width-window_d);



