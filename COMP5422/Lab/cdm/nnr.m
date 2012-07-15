function out = nnr(in,direction) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% 
% function out = nnr(in,direction) 
% returns the color interpolated image using Nearest 
% Neighbor Replication interpolation algorithm. 
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
% in : CFA image matrix (mxn), m&n even 
% 
% direction : '1' -- use upper green neighbor fill in the 
%                    missing green value 
%             '2' -- lower 
%             '3' -- left 
%             '4' -- right 
%             for simplicity, the replication for missing 
%             blue and red values is assumed to be the same 
%             for all cases 
% 
% Output : 
% 
% out : color interpolated image 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
[m,n] = size(in);
inR = in; inG = in; inB = in; 
out = in; 
outR = inR; outG = inG; outB = inB; 

% R channel 
for i=1:2:m-1, 
    outR(i,1:2:n-1) = inR(i,2:2:n); 
end 

for i=2:2:m, 
    outR(i,1:2:n-1) = inR(i-1,2:2:n); 
    outR(i,2:2:n) = inR(i-1,2:2:n); 
end 

% B channel 
for i=1:2:m-1, 
    outB(i,1:2:n-1) = inB(i+1,1:2:n-1); 
    outB(i,2:2:n) = inB(i+1,1:2:n-1); 
end 

for i=2:2:m, 
    outB(i,2:2:n) = inB(i,1:2:n-1); 
end 

% G channel 
switch direction 
   case 1, % upper 
        for i=2:2:m, 
             outG(i,1:2:n-1) = inG(i-1,1:2:n-1); 
       end 

       for i=3:2:m-1, 
            outG(i,2:2:n) = inG(i-1,2:2:n); 
       end 

       outG(1,2:2:n) = inG(2,2:2:n); 

   case 2, % lower 
        for i=1:2:m-1, 
             outG(i,2:2:n) = inG(i+1,2:2:n); 
        end 

        for i=2:2:m-2, 
             outG(i,1:2:n-1) = inG(i+1,1:2:n-1); 
        end 

        outG(m,1:2:n-1) = inG(m-1,1:2:n-1); 

   case 3, % left 
        for i=2:2:n, 
             outG(1:2:m-1,i) = inG(1:2:m-1,i-1); 
        end 

       for i=3:2:n-1, 
            outG(2:2:m,i) = inG(2:2:m,i-1); 
       end 

       outG(2:2:m,1) = inG(2:2:m,2); 

   case 4, % right 
        for i=1:2:n-1, 
             outG(2:2:m,i) = inG(2:2:m,i+1); 
        end 

        for i=2:2:n-2, 
             outG(1:2:m-1,i) = inG(1:2:m-1,i+1); 
       end 

       outG(1:2:m-1,n) = inG(1:2:m-1,n-1); 
end 

out(:,:,1) = outR; 
out(:,:,2) = outG; 
out(:,:,3) = outB; 

