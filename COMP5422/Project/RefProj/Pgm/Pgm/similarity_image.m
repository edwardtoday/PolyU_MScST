function   [s] = similarity_image(HLGPP_CRe,HLGPP_Re,HLGPP_CIm,HLGPP_Im,HGGPP_CRe,HGGPP_Re,HGGPP_CIm,HGGPP_Im);
s1=0;
s2=0;
s3=0;
s4=0;
s = 0;
for v=1:5
    for i =0:63
        s1 = s1 + sum(min(HGGPP_CRe(v,i*16+[1:16],:),HGGPP_Re(v,i*16+[1:16],:)));
        s2 = s2 + sum(min(HGGPP_CIm(v,i*16+[1:16],:),HGGPP_Im(v,i*16+[1:16],:)));
    end
end
s1 = sum(s1);
s2 = sum(s2);
for v=1:5
    for u =1:8
        for i =0:63
             s3 = s3 + sum(min(HLGPP_CRe(u,v,i*16+[1:16],:),HLGPP_Re(u,v,i*16+[1:16],:)));
             s4 = s4 + sum(min(HLGPP_CIm(u,v,i*16+[1:16],:),HLGPP_Im(u,v,i*16+[1:16],:)));
        end
    end
end
s3 = sum(s3);
s4 = sum(s4);
s = s1 + s2 + s3 + s4;