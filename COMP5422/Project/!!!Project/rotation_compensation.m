function out=rotation_compensation(database_in);
% Rotate the faces in the database the first time we run the program.
persistent rotated;
persistent dataset_rotated;
if(isempty(rotated))
    disp('Applying rotation compensation to database...');
    tic;
    dataset=zeros(10304,400);

    for i=1:size(database_in,2)
        I = reshape(database_in(:,i),112,92);
%        Imax = max(max(I));
%        Imin = min(min(I));
%        if (Imin > 0)
%            if (Imin >  Imax*0.3)
%                Imin = Imax*0.3
%            else
%                Imin = Imin*1.5;
%%            end
%        else
%%            Imin = Imax*0.3;
 %       end
 %       if (Imax < Imin/0.7 )
 %           Imax = Imin/0.7;
 %       else
 %           Imax = Imax*0.7;
 %       end
        %[Eyeangle, ConfidentLevel] = detect_headpose(I,Imin,Imax,1);
                [Eyeangle, ConfidentLevel] = detect_headpose(I,0);
        if (ConfidentLevel > 0.9 )
            I_rot = imrotate(I,-1*Eyeangle,'bilinear','crop');
            dataset(:,i)=reshape(I_rot,112*92,1);
             display(['Dataset [', num2str(i) ,'] Image rotate angle detected = ', num2str(Eyeangle,2) ]);
        else
            dataset(:,i)=reshape(I,112*92,1);
        end
    end
    dataset_rotated=uint8(dataset); % Convert to unsigned 8 bit numbers to save memory. 
    toc;
end
rotated=1;  % Set 'rotated' to avoid rotating the images again. 
out=dataset_rotated;