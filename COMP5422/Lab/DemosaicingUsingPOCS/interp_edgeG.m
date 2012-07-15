%
% interp_edgeG -> Edge-directed interpolation of G channel from a Bayer mosaic
%
%		[RGB] = interp_edgeG(X)
%		RGB			-> R and B are bilinearly interpolated, G is edge-directed interpolated 
%		X   	    -> Bayer sampled mosaic
%
% Bahadir K. Gunturk
% Department of Electrical and Computer Engineering
% Louisiana State University
% Email: bahadir@ece.lsu.edu
% URL  : http://www.ece.lsu.edu/~bahadir


function [RGB] = interp_edgeG(X)

% G R
% B G

[height,width] = size(X);

RGB = interp_bilinear(X);

G = RGB(:,:,2);

% Interpolate G over B samples (excluding borders)
% 
for j=4:2:height-4, 
   for i=3:2:width-4,
      deltaH = abs( G(j,i-1)-G(j,i+1) ) + abs( 2*X(j,i)-X(j,i-2)-X(j,i+2) );
	  deltaV = abs( G(j-1,i)-G(j+1,i) ) + abs( 2*X(j,i)-X(j-2,i)-X(j+2,i) );
      if deltaV>deltaH,
         G(j,i) = ( G(j,i-1)+G(j,i+1) )/2 + ( 2*X(j,i)-X(j,i-2)-X(j,i+2) )/4;
      elseif deltaH>deltaV,
         G(j,i) = ( G(j-1,i)+G(j+1,i) )/2 + ( 2*X(j,i)-X(j-2,i)-X(j+2,i) )/4;
      else
         G(j,i) = ( G(j-1,i-1)+G(j+1,i+1)+G(j-1,i+1)+G(j+1,i-1))/4 + ...
             ( 2*X(j,i)-X(j,i-2)-X(j,i+2) + 2*X(j,i)-X(j-2,i)-X(j+2,i))/8;
      end;
      
   end;
end;
%
% Interpolate G over R samples (excluding borders)
%
for j=3:2:height-4, 
   for i=4:2:width-4,
      deltaH = abs( G(j,i-1)-G(j,i+1) ) + abs( 2*X(j,i)-X(j,i-2)-X(j,i+2) );
      deltaV = abs( G(j-1,i)-G(j+1,i) ) + abs( 2*X(j,i)-X(j-2,i)-X(j+2,i) );
      if deltaV>deltaH,
         G(j,i) = ( G(j,i-1)+G(j,i+1) )/2 + ( 2*X(j,i)-X(j,i-2)-X(j,i+2) )/4;
      elseif deltaH>deltaV,
         G(j,i) = ( G(j-1,i)+G(j+1,i) )/2 + ( 2*X(j,i)-X(j-2,i)-X(j+2,i) )/4;
      else
         G(j,i) = ( G(j-1,i-1)+G(j+1,i+1)+G(j-1,i+1)+G(j+1,i-1))/4 + ...
             ( 2*X(j,i)-X(j,i-2)-X(j,i+2) + 2*X(j,i)-X(j-2,i)-X(j+2,i))/8;
      end;

   end;
end;

RGB(:,:,2) = G;
