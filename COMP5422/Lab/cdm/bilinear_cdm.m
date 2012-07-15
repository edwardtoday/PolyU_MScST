function [RGB_image]=bilinear_cdm(CFA_image)
% Bilinear interpolation for color demosaicing
% --------------------------------------
% (c) 2012 QING Pei
% http://www.qingpei.me/

im=double(CFA_image);
    
height = size(im, 1);
width = size(im, 2);

%% Get the existing values for R, G and B
R=im .* repmat([0 1; 0 0], height/2, width/2);
G=im .* repmat([1 0; 0 1], height/2, width/2);
B=im .* repmat([0 0; 1 0], height/2, width/2);

for row = 1:2:height
    for col = 2:2:width
        % Interpolation for channel green at red pixels
        count = 0;
        sum = 0;
        if row > 1
            sum = sum + G(row-1,col);
            count = count + 1;
        end
        if col > 1
            sum = sum + G(row,col-1);
            count = count + 1;
        end
        if row < height
            sum = sum + G(row+1,col);
            count = count + 1;
        end
        if col < width
            sum = sum + G(row,col+1);
            count = count + 1;
        end
        G(row,col) = sum / count;
        
        % Interpolation for channel blue at red pixels
        count = 0;
        sum = 0;
        if row > 1
            sum = sum + B(row-1,col-1);
            count = count + 1;
            if col < width
                sum = sum + B(row-1,col+1);
                count = count + 1;
            end
        end
        if row < height
            sum = sum + B(row+1,col-1);
            count = count + 1;
            if col < width
                sum = sum + B(row+1,col+1);
                count = count + 1;
            end
        end
        B(row,col) = sum / count;
    end
end

for row = 2:2:height
    for col = 1:2:width
        % Interpolation for channel green at blue pixels
        count = 0;
        sum = 0;
        if row > 1
            sum = sum + G(row-1,col);
            count = count + 1;
        end
        if col > 1
            sum = sum + G(row,col-1);
            count = count + 1;
        end
        if row < height
            sum = sum + G(row+1,col);
            count = count + 1;
        end
        if col < width
            sum = sum + G(row,col+1);
            count = count + 1;
        end
        G(row,col) = sum / count;
        
        % Interpolation for channel red at blue pixels
        count = 0;
        sum = 0;
        if col > 1
            sum = sum + R(row-1,col-1);
            count = count + 1;
            if row < height
                sum = sum + R(row+1,col-1);
                count = count + 1;
            end
        end
        if col < width
            sum = sum + R(row-1,col+1);
            count = count + 1;
            if row < height
                sum = sum + R(row+1,col+1);
                count = count + 1;
            end
        end
        R(row,col) = sum / count;
    end
end

for row = 1:2:height
    for col = 1:2:width
        % Interpolation for channel blue at green pixels
        count = 0;
        sum = 0;
        if row > 1
            sum = sum + B(row-1,col);
            count = count + 1;
        end
        if row < height
            sum = sum + B(row+1,col);
            count = count + 1;
        end
        B(row,col) = sum / count;
        
        % Interpolation for channel red at green pixels
        count = 0;
        sum = 0;
        if col > 1
            sum = sum + R(row,col-1);
            count = count + 1;
        end
        if col < width
            sum = sum + R(row,col+1);
            count = count + 1;
        end
        R(row,col) = sum / count;
    end
end

for row = 2:2:height
    for col = 2:2:width
        % Interpolation for channel blue at green pixels
        count = 0;
        sum = 0;
        sum = sum + B(row,col-1);
        count = count + 1;
        if col < width
            sum = sum + B(row,col+1);
            count = count + 1;
        end
        B(row,col) = sum / count;
        
        % Interpolation for channel red at green pixels
        count = 0;
        sum = 0;
        if row > 1
            sum = sum + R(row-1,col);
            count = count + 1;
        end
        if row < height
            sum = sum + R(row+1,col);
            count = count + 1;
        end
        R(row,col) = sum / count;
    end
end

%% Concatenate RGB channels to a single image
RGB_image = cat(3,R,G,B);

end