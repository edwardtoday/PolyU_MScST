clearvars;
%% Test samples : sample01.jpg to sample12.jpg 
for sampleloop=1:12
    close all;
    displaystatus = 1;
	clearvars -except sampleloop displaystatus
    filename=strcat('sample',int2str(sampleloop),'.jpg');
    
    fullpathname=strcat('html\',filename);
    resultname=strcat('sample',int2str(sampleloop),'_result','.jpg');
    fullresultname=strcat('html\',resultname);
    InputImage =imread(fullpathname);

    %% jpg image as parameter for function detect_face()
    %% create handle to export figure plate to JPEG file , {resultname} is saved
    
    f=figure('Name',['Head pose analysis - ',filename],'NumberTitle','off');
    I = rgb2gray(InputImage);
    %subplot(3,3,1);
    %imshow(InputImage), imshow(I);
    Imax = max(max(I));
    Imin = min(min(I));
    if (Imin > 0)
        if (Imin >  Imax*0.3)
            Imin = Imax*0.3
        else
            Imin = Imin*1.5;
        end
    else
        Imin = Imax*0.3;
    end
    if (Imax < Imin/0.7 )
        Imax = Imin/0.7;
    else
        Imax = Imax*0.7
    end
    
    [Eyeangle, ConfidentLevel] = detect_headpose(I,Imin,Imax,displaystatus);
    
	% The imrotate function can be used to rotate an image. 
	% The first parameter is the image to be resized and the second the rotation in degrees. 
	% If the degree is positive the image will be rotated counter-clockwise. 
	% If the degree is negative the image will be rotated clockwise.
    % Confident level is equal to zero if facial component can not be
    % detected 
    
	if (ConfidentLevel > 0.8 )
		TransformedImage = imrotate(I,-1*Eyeangle,'bilinear','crop');
    end
    if (displaystatus == 1)
        saveas(f,fullresultname)
    end
        k = waitforbuttonpress 

end  
  