% 
% Soft thresholding
%

function op=sthresh(X,T)

    ind=find(abs(X)<=T);
    ind1=find(abs(X)>T);
    X(ind)=0;
    X(ind1)=sign(X(ind1)).*(abs(X(ind1))-T);
    op=X;
    