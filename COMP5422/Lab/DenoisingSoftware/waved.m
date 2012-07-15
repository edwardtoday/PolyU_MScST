%
% Decompose image to a desired level
% 

function [cA,cH,cV,cD]=waved(x,level,dec);

temp=x;
for i=1:level
    [cA,cH,cV,cD]=dwt2(temp,dec);
    temp=cA;
end

