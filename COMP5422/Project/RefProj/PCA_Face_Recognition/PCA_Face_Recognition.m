% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code is PCA base face recognition programme. It reads nots(here 5)
% faces from ORL database and the rest (noc-nots) are used as test.
% PCA_Performance shows the recognition performance. 
%  
% In order to be able to run this programme for ORL face database you need
% to download the following zip-file. Then copy this code in the folder
% which includes the face samples and then run this script. The zip-file is
% available at: http://www.mathworks.com/matlabcentral/fileexchange/22466 
%  
% This code has been written in Spring 2006 by me, Gholamreza Anbarjafari
% (Shahab). You can use this code for any research and academic purposes
% and you may refer to us in your acknowledgement!
%  
% Feel free to contact us for any further information:
%  {hasan.demirel, shahab.jafari}@emu.edu.tr
%   http://faraday.ee.emu.edu.tr/shahab
%   http://faraday.ee.emu.edu.tr/hdemirel
%   (c) Demirel and Anbarjafari -2008
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clear memory
clc
zz=1;
noc=40;             %no_of_classes
nots=5;                %no_of_training_set
[face,MAP]=imread('face1.bmp');
[a,b]=size(face);

% Reading face from the databese for training set
counter=0;
for i=1:noc
    for j=1:nots
        file=['face' int2str((i-1)*10+j) '.bmp'];
        [face,MAP]=imread(file);
        grayface=ind2gray(face,MAP);
        vector_face=reshape(grayface,a*b,1);
        counter=counter+1;
        Covar_train(:,counter)=vector_face;
    end
end
Covar_train=double(Covar_train)/255;
% Reading face from the databese for test set
counter=0;
for i=1:noc
    for j=nots+1:10
        file=['face' int2str((i-1)*10+j) '.bmp'];
        [face,MAP]=imread(file);
        grayf=ind2gray(face,MAP);
        vector_face=reshape(grayf,a*b,1);
        counter=counter+1;
        Covar_test(:,counter)=vector_face;
    end
end
cd('C:\MATLAB7.5\work')
clear memory
Covar_test=double(Covar_test)/255;
AVERAGE=mean(Covar_train')';
Average_Matrix=(ones(noc*nots,1)*AVERAGE')';
clear memory

Difference=double(Covar_train)-double(Average_Matrix);
[V,D]=eig(Difference'*Difference);
Eigen_train=Difference*V;
[A,B]=size(Covar_train);

Pro_train=Eigen_train'*double(Difference);
clear Average_Matrix
Average_Matrix=(ones(noc*(10-nots),1)*AVERAGE')';
At_test=Eigen_train'*double(double(Covar_test)-Average_Matrix);
clear temp
counter=0;
for i=1:noc*(10-nots)
    error=[];
    for j=1:noc*nots
        temp=(At_test(:,i)-Pro_train(:,j))';
        distance=sqrt(temp*temp');
        error=[error distance];
    end
    Minimum_Error=max(error);
    for k=1:noc*nots
        if error(k)<Minimum_Error
            Minimum_Error=error(k);
            holder=k;
        end
    end
    if ceil(holder/nots)==ceil(i/(10-nots))
        counter=counter+1;
    end
end
PCA_Performance=(counter/(noc*(10-nots)))*100