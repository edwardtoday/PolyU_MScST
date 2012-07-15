function out = lcc1(in) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% 
% function out = lcc1(in) 
% returns the color interpolated image using Laplacian 
% second-order color correction I 
% 
% Assumptions : in has following color patterns 
% 
%  ------------------> x 
%  |  G R G R ... 
%  |  B G B G ... 
%  |  G R G R ... 
%  |  B G B G ... 
%  |  . . . . . 
%  |  . . . .  . 
%  |  . . . .   . 
%  | 
%  V y 
% 
% 
% Input : 
% 
% in : original image matrix (mxnx3), m&n even 
% 
% Output : 
% 
% out : color interpolated image 
% 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
[m,n] = size(in);
inR = in; inG = in; inB = in; 
out = in; 
outR = inR; outG = inG; outB = inB; 

% G channel 
for i=4:2:m-2, 
    for j=3:2:n-3, 
        delta_H = abs(inB(i,j-2)+inB(i,j+2)-2*inB(i,j))+abs(inG(i,j-1)-inG(i,j+1)); 
        delta_V = abs(inB(i-2,j)+inB(i+2,j)-2*inB(i,j))+abs(inG(i-1,j)-inG(i+1,j)); 
        if delta_H < delta_V, 
           outG(i,j) = 1/2*(inG(i,j-1)+inG(i,j+1))+1/4*(2*inB(i,j)-inB(i,j-2)-inB(i,j+2)); 
        elseif delta_H > delta_V, 
           outG(i,j) = 1/2*(inG(i-1,j)+inG(i+1,j))+1/4*(2*inB(i,j)-inB(i-2,j)-inB(i+2,j)); 
        else 
           outG(i,j) = 1/4*(inG(i,j-1)+inG(i,j+1)+inG(i-1,j)+inG(i+1,j))+1/8*(4*inB(i,j)-inB(i,j-2)-inB(i,j+2)-inB(i-2,j)-inB(i+2,j)); 
        end 
    end 
end 

for i=3:2:m-3, 
    for j=4:2:n-2, 
        delta_H = abs(inR(i,j-2)+inR(i,j+2)-2*inR(i,j))+abs(inG(i,j-1)-inG(i,j+1)); 
        delta_V = abs(inR(i-2,j)+inR(i+2,j)-2*inR(i,j))+abs(inG(i-1,j)-inG(i+1,j)); 
        if delta_H < delta_V, 
           outG(i,j) = 1/2*(inG(i,j-1)+inG(i,j+1))+1/4*(2*inR(i,j)-inR(i,j-2)-inR(i,j+2)); 
        elseif delta_H > delta_V, 
           outG(i,j) = 1/2*(inG(i-1,j)+inG(i+1,j))+1/4*(2*inR(i,j)-inR(i-2,j)-inR(i+2,j)); 
        else 
           outG(i,j) = 1/4*(inG(i,j-1)+inG(i,j+1)+inG(i-1,j)+inG(i+1,j))+1/8*(4*inR(i,j)-inR(i,j-2)-inR(i,j+2)-inR(i-2,j)-inR(i+2,j)); 
        end 
    end 
end 

outG = round(outG); 
ind = find(outG>255); 
outG(ind) = 255; 
ind = find(outG<0); 
outG(ind) = 0; 

% R channel 
for i=1:2:m-1, 
    outR(i,3:2:n-1) = 1/2*(inR(i,2:2:n-2)+inR(i,4:2:n))+1/4*(2*outG(i,3:2:n-1)-outG(i,2:2:n-2)-outG(i,4:2:n)); 
end 

for i=2:2:m-2, 
    outR(i,2:2:n) = 1/2*(inR(i-1,2:2:n)+inR(i+1,2:2:n))+1/4*(2*outG(i,2:2:n)-outG(i-1,2:2:n)-outG(i+1,2:2:n)); 
end 

for i=2:2:m-2, 
    for j=3:2:n-1, 
        delta_P = abs(inR(i-1,j+1)-inR(i+1,j-1))+abs(2*outG(i,j)-outG(i-1,j+1)-outG(i+1,j-1)); 
        delta_N = abs(inR(i-1,j-1)-inR(i+1,j+1))+abs(2*outG(i,j)-outG(i-1,j-1)-outG(i+1,j+1)); 
        if delta_N < delta_P, 
           outR(i,j) = 1/2*(inR(i-1,j-1)+inR(i+1,j+1))+1/2*(2*outG(i,j)-outG(i-1,j-1)-outG(i+1,j+1)); 
        elseif delta_N > delta_P, 
           outR(i,j) = 1/2*(inR(i-1,j+1)+inR(i+1,j-1))+1/2*(2*outG(i,j)-outG(i-1,j+1)-outG(i+1,j-1)); 
        else 
           outR(i,j) = 1/4*(inR(i-1,j-1)+inR(i-1,j+1)+inR(i+1,j-1)+inR(i+1,j+1))+1/4*(4*outG(i,j)-outG(i-1,j-1)-outG(i-1,j+1)-outG(i+1,j-1)-outG(i+1,j+1)); 
        end 
     end 
end 

outR = round(outR); 
ind = find(outR>255); 
outR(ind) = 255; 
ind = find(outR<0); 
outR(ind) = 0; 

% B channel 
for i=2:2:m, 
    outB(i,2:2:n-2) = 1/2*(inB(i,1:2:n-3)+inB(i,3:2:n-1))+1/4*(2*outG(i,2:2:n-2)-outG(i,1:2:n-3)-outG(i,3:2:n-1)); 
end 

for i=3:2:m-1, 
    outB(i,1:2:n-1) =  1/2*(inB(i-1,1:2:n-1)+inB(i+1,1:2:n-1))+1/4*(2*outG(i,1:2:n-1)-outG(i-1,1:2:n-1)-outG(i+1,1:2:n-1)); 
end 

for i=3:2:m-1, 
    for j=2:2:n-2, 
        delta_P = abs(inB(i-1,j+1)-inB(i+1,j-1))+abs(2*outG(i,j)-outG(i-1,j+1)-outG(i+1,j-1)); 
        delta_N = abs(inB(i-1,j-1)-inB(i+1,j+1))+abs(2*outG(i,j)-outG(i-1,j-1)-outG(i+1,j+1)); 
        if delta_N < delta_P, 
            outB(i,j) = 1/2*(inB(i-1,j-1)+inB(i+1,j+1))+1/2*(2*outG(i,j)-outG(i-1,j-1)-outG(i+1,j+1)); 
        elseif delta_N > delta_P, 
            outB(i,j) = 1/2*(inB(i-1,j+1)+inB(i+1,j-1))+1/2*(2*outG(i,j)-outG(i-1,j+1)-outG(i+1,j-1)); 
        else 
            outB(i,j) = 1/4*(inB(i-1,j-1)+inB(i-1,j+1)+inB(i+1,j-1)+inB(i+1,j+1))+1/4*(4*outG(i,j)-outG(i-1,j-1)-outG(i-1,j+1)-outG(i+1,j-1)-outG(i+1,j+1)); 
        end 
     end 
end 

outB = round(outB); 
ind = find(outB>255); 
outB(ind) = 255; 
ind = find(outB<0); 
outB(ind) = 0; 

out(:,:,1) = outR; 
out(:,:,2) = outG; 
out(:,:,3) = outB; 

