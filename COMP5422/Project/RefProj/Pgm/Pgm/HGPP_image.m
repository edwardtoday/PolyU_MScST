function [HLGPP_CRe,HLGPP_CIm,HGGPP_CRe,HGGPP_CIm] = HGPP_image(a)
for v=0:4
    GGPP_Re=zeros(112,92);
    GGPP_Im=zeros(112,92);
    for u =0:7
        [d]=gabor_wavelet(a,u,v);
        [Probe_Re,Probe_Im] = daugman_encode(d,112,92);
        GGPP_Re = GGPP_Re+Probe_Re *2^(7-u);
        GGPP_Im = GGPP_Im+Probe_Im *2^(7-u);
        [LGPP_Re,LGPP_Im] = LGPP_block(Probe_Re,Probe_Im,112,92);
        k=0;
        for i=0:15
            for j=0:3
                HLGPP_CRe(u+1,v+1,k*16+[1:16],:) =  hist(LGPP_Re(i*7+[1:7],j*23+[1:23]) ,16);
                HLGPP_CIm(u+1,v+1,k*16+[1:16],:) =  hist(LGPP_Im(i*7+[1:7],j*23+[1:23]),16);
                k=k+1;
            end
        end
    end
        k=0;   
        for i=0:15
            for j=0:3
                HGGPP_CRe(v+1,k*16+[1:16],:) = hist(GGPP_Re(i*7+[1:7],j*23+[1:23]),16);
                HGGPP_CIm(v+1,k*16+[1:16],:) = hist(GGPP_Im(i*7+[1:7],j*23+[1:23]),16);
                k=k+1;
            end
        end
end