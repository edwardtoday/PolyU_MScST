clearvars;
%% Test samples : sample01.jpg to sample12.jpg 
for sampleloop=1:12
    close all;
	clearvars -except sampleloop 
    filename=strcat('sample',int2str(sampleloop),'.jpg');
    
    fullpathname=strcat('html\',filename);
    resultname=strcat('sample',int2str(sampleloop),'_result','.jpg');
    fullresultname=strcat('html\',resultname);
    pic =imread(fullpathname);

    %% jpg image as parameter for function detect_face()
   %% create handle to export figure plate to JPEG file , {resultname} is saved
    I=double(pic);
    f=figure('Name',['Head pose analysis - ',filename],'NumberTitle','off');
    detect_face(I);
    saveas(f,fullresultname)

end  
  