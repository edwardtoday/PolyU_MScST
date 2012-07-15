function [zr,zi] = LGPP_block(Probe_Re,Probe_Im,p,q);
x=p-1;
y=q-1;
zr=zeros(p,q);
zi=zeros(p,q);
for i=2:x
        zr(i,1) =  XOR(Probe_Re(i,1), Probe_Re(i-1,1))* 2^6 + XOR(Probe_Re(i,1), Probe_Re(i-1,2))* 2^5 + XOR(Probe_Re(i,1), Probe_Re(i,2))* 2^4 + XOR(Probe_Re(i,1), Probe_Re(i+1,2))* 2^3 + XOR(Probe_Re(i,1), Probe_Re(i+1,1))* 2^2;
        zi(i,1) =  XOR(Probe_Im(i,1), Probe_Im(i-1,1))* 2^6 + XOR(Probe_Im(i,1), Probe_Im(i-1,2))* 2^5 + XOR(Probe_Im(i,1), Probe_Im(i,2))* 2^4 + XOR(Probe_Im(i,1), Probe_Im(i+1,2))* 2^3 + XOR(Probe_Im(i,1), Probe_Im(i+1,1))* 2^2;
        zr(i,q) = XOR(Probe_Re(i,q), Probe_Re(i-1,q-1))* 2^7 + XOR(Probe_Re(i,q), Probe_Re(i-1,q))* 2^6 + XOR(Probe_Re(i,q), Probe_Re(i+1,q))* 2^2 + XOR(Probe_Re(i,q), Probe_Re(i+1,q-1))* 2 + XOR(Probe_Re(i,q), Probe_Re(i,q-1));
        zi(i,q) = XOR(Probe_Im(i,q), Probe_Im(i-1,q-1))* 2^7 + XOR(Probe_Im(i,q), Probe_Im(i-1,q))* 2^6 + XOR(Probe_Im(i,q), Probe_Im(i+1,q))* 2^2 + XOR(Probe_Im(i,q), Probe_Im(i+1,q-1))* 2 + XOR(Probe_Im(i,q), Probe_Im(i,q-1));
    for j =2:y
        zr(i,j) = XOR(Probe_Re(i,j), Probe_Re(i-1,j-1))* 2^7 + XOR(Probe_Re(i,j), Probe_Re(i-1,j))* 2^6 + XOR(Probe_Re(i,j), Probe_Re(i-1,j+1))* 2^5 + XOR(Probe_Re(i,j), Probe_Re(i,j+1))* 2^4 + XOR(Probe_Re(i,j), Probe_Re(i+1,j+1))* 2^3 + XOR(Probe_Re(i,j), Probe_Re(i+1,j))* 2^2 + XOR(Probe_Re(i,j), Probe_Re(i+1,j-1))* 2 + XOR(Probe_Re(i,j), Probe_Re(i,j-1));
        zi(i,j) = XOR(Probe_Im(i,j), Probe_Im(i-1,j-1))* 2^7 + XOR(Probe_Im(i,j), Probe_Im(i-1,j))* 2^6 + XOR(Probe_Im(i,j), Probe_Im(i-1,j+1))* 2^5 + XOR(Probe_Im(i,j), Probe_Im(i,j+1))* 2^4 + XOR(Probe_Im(i,j), Probe_Im(i+1,j+1))* 2^3 + XOR(Probe_Im(i,j), Probe_Im(i+1,j))* 2^2 + XOR(Probe_Im(i,j), Probe_Im(i+1,j-1))* 2 + XOR(Probe_Im(i,j), Probe_Im(i,j-1));
    end
end
for j =2:y
        zr(1,j) = XOR(Probe_Re(1,j), Probe_Re(1,j+1))* 2^4 + XOR(Probe_Re(1,j), Probe_Re(2,j+1))* 2^3 + XOR(Probe_Re(1,j), Probe_Re(2,j))* 2^2 + XOR(Probe_Re(1,j), Probe_Re(2,j-1))* 2 + XOR(Probe_Re(1,j), Probe_Re(1,j-1));
        zi(1,j) = XOR(Probe_Im(1,j), Probe_Im(1,j+1))* 2^4 + XOR(Probe_Im(1,j), Probe_Im(2,j+1))* 2^3 + XOR(Probe_Im(1,j), Probe_Im(2,j))* 2^2 + XOR(Probe_Im(1,j), Probe_Im(2,j-1))* 2 + XOR(Probe_Im(1,j), Probe_Im(1,j-1));
        zr(p,j) = XOR(Probe_Re(p,j), Probe_Re(p-1,j-1))* 2^7 + XOR(Probe_Re(p,j), Probe_Re(p-1,j))* 2^6 + XOR(Probe_Re(p,j), Probe_Re(p-1,j+1))* 2^5 + XOR(Probe_Re(p,j), Probe_Re(p,j+1))* 2^4 + XOR(Probe_Re(p,j), Probe_Re(p,j-1));
        zi(p,j) = XOR(Probe_Im(p,j), Probe_Im(p-1,j-1))* 2^7 + XOR(Probe_Im(p,j), Probe_Im(p-1,j))* 2^6 + XOR(Probe_Im(p,j), Probe_Im(p-1,j+1))* 2^5 + XOR(Probe_Im(p,j), Probe_Im(p,j+1))* 2^4 + XOR(Probe_Im(p,j), Probe_Im(p,j-1));
end
    zr(p,q) = XOR(Probe_Re(p,q), Probe_Re(p-1,q-1))* 2^7 + XOR(Probe_Re(p,q), Probe_Re(p-1,q))* 2^6 + XOR(Probe_Re(p,q), Probe_Re(p,q-1));
    zi(p,q) = XOR(Probe_Im(p,q), Probe_Im(p-1,q-1))* 2^7 + XOR(Probe_Im(p,j), Probe_Im(p-1,q))* 2^6 + XOR(Probe_Im(p,q), Probe_Im(p,q-1));
    zr(1,1) = XOR(Probe_Re(1,1), Probe_Re(1,2))* 2^4 + XOR(Probe_Re(1,1), Probe_Re(2,2))* 2^3 + XOR(Probe_Re(1,1), Probe_Re(2,1))* 2^2;
    zi(1,1) = XOR(Probe_Im(1,1), Probe_Im(1,2))* 2^4 + XOR(Probe_Im(1,1), Probe_Im(2,2))* 2^3 + XOR(Probe_Im(1,1), Probe_Im(2,1))* 2^2;
    zr(p,1) = XOR(Probe_Re(p,1), Probe_Re(p-1,1))* 2^6 + XOR(Probe_Re(p,1), Probe_Re(p-1,2))* 2^5 + XOR(Probe_Re(p,1), Probe_Re(p,2))* 2^4;
    zi(p,1) = XOR(Probe_Im(p,1), Probe_Im(p-1,1))* 2^6 + XOR(Probe_Im(p,1), Probe_Im(p-1,2))* 2^5 + XOR(Probe_Im(p,1), Probe_Im(p,2))* 2^4;
    zr(1,q) = XOR(Probe_Re(1,q), Probe_Re(2,q))* 2^2 + XOR(Probe_Re(1,q), Probe_Re(2,q-1))* 2 + XOR(Probe_Re(1,q), Probe_Re(1,q-1));
    zi(1,q) = XOR(Probe_Im(1,q), Probe_Im(2,q))* 2^2 + XOR(Probe_Im(1,q), Probe_Im(2,q-1))* 2 + XOR(Probe_Im(1,q), Probe_Im(1,q-1));
    
    function [z] = XOR(a,b)
    if(a==b)
        z =0;
    else
        z =1;
    end