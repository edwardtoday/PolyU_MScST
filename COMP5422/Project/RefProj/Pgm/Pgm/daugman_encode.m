function [zr,zi] = daugman_encode(d, x, y)
for i=1:x
    for j=1:y
        if (d(i,j)<0)
            d(i,j)=d(i,j)+360;
        end
            if (d(i,j)>0 && d(i,j)<=180)
                zi(i,j)=0;
            else
                zi(i,j) =1;
            end
            if (d(i,j)>= 270 || d(i,j)<=90 )%| d(i,j)>=-90)
                zr(i,j)=0;
            else
                zr(i,j) =1;
            end 
    end
end