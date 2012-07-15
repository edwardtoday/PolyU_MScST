% A demo script showing how to compute a PCA subspace
% 
% DEMO NAME: PERFORM PCA DEMO
% 
% GENERAL DESCRIPTION
% The script demonstrates how to compute a PCA subspace from actual image
% data. The demo assumes that you have downloaded the ORL database and have
% unpacked it to the /demos/database folder. This folder should now have
% the following internal structure:
% 
%   /demos/database/ --- s1/
%                    |-- s2/
%                    |-- s3/
%                    |-- s4/
%                    |-- s5/
%                    |-- s6/
%                    ...
%                    |-- s40/
% 
% Each of the 40 subfolders should contain 10 images in PGM format. If you
% have not downloaded and unpacked the ORL database at all or have unpacked
% it into a different folder this demo will not work!!!
% 
% Please follow the install instructions in the install script.
% 
% 
% IMPORTANT!!!!
% Note that you must run all demo scipts in this toolbox from the demos
% folder. This is particularly important, since some data needed by the
% scripts is located in folders whose paths are specified relative to the 
% demos folder. If you run the scripts from anywhere else, the scripts may
% fail.
% 
% 
% NOTES / COMMENTS
% The script was tested with Matlab version 7.11.0.584 (R2010b) running 
% on a 64-bit Windows 7 OS.
%
% 
% ABOUT
% Created:        29.11.2011
% Last Update:    29.11.2011
% Revision:       1.0
% 
%
% WHEN PUBLISHING A PAPER AS A RESULT OF RESEARCH CONDUCTED BY USING THIS CODE
% OR ANY PART OF IT, MAKE A REFERENCE TO THE FOLLOWING PUBLICATIONS:
% 
% Štruc V., Pavešic, N.: The Complete Gabor-Fisher Classifier for Robust 
% Face Recognition, EURASIP Advances in Signal Processing, vol. 2010, 26
% pages, doi:10.1155/2010/847680, 2010.
%
% Štruc V., Pavešic, N.:Gabor-Based Kernel Partial-Least-Squares 
% Discrimination Features for Face Recognition, Informatica (Vilnius), vol.
% 20, no. 1, pp. 115-138, 2009.
% 
% 
% The BibTex entries for the papers are here
% 
% @Article{ACKNOWL1,
%     author = "Vitomir \v{S}truc and Nikola Pave\v{s}i\'{c}",
%     title  = "The Complete Gabor-Fisher Classifier for Robust Face Recognition",
%     journal = "EURASIP Advances in Signal Processing",
%     volume = "2010",
%     pages = "26",
%     year = "2010",
% }
% 
% @Article{ACKNOWL2,
%     author = "Vitomir \v{S}truc and Nikola Pave\v{s}i\'{c}",
%     title  = "Gabor-Based Kernel Partial-Least-Squares Discrimination Features for Face Recognition",
%     journal = "Informatica (Vilnius)",
%     volume = "20",
%     number = "1",
%     pages = "115–138",
%     year = "2009",
% }
% 
% Official website:
% If you have down-loaded the toolbox from any other location than the
% official website, plese check the following link to make sure that you
% have the most recent version:
% 
% http://luks.fe.uni-lj.si/sl/osebje/vitomir/face_tools/PhDface/index.html
%
% 
% OTHER TOOLBOXES 
% If you are interested in face recognition you are invited too have a look
% at the INface toolbox as well. It contains implementations of several
% state-of-the-art photometric normalization techniques that can further 
% improve the face recognition performance, especcially in difficult 
% illumination conditions. The toolbox is available from:
% 
% http://luks.fe.uni-lj.si/sl/osebje/vitomir/face_tools/INFace/index.html
% 
%
% Copyright (c) 2011 Vitomir Štruc
% Faculty of Electrical Engineering,
% University of Ljubljana, Slovenia
% http://luks.fe.uni-lj.si/en/staff/vitomir/index.html
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files, to deal
% in the Software without restriction, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in 
% all copies or substantial portions of the Software.
%
% The Software is provided "as is", without warranty of any kind.
% 
% November 2011

%% Load sample image
disp(sprintf('This is a demo script for the PhD toolbox. It demonstrates how to use a \nfunction from the toolbox to construct a PCA subspace from \nactual face image data and how to visualize a few computed eigenfaces and the mean face.'));
disp(' ')
disp('Loading images from the ORL database.')

proceed = 1;
data_matrix = [];
try
    % construct image string and load image
    for i=1:40
        for j=1:10
            s = sprintf('database/s%i/%i.pgm',i,j);
            X=double(imread(s));
            data_matrix = [data_matrix,X(:)];
        end
    end
    [size_y,size_x] = size(X);    
catch
   proceed = 0;
   disp(sprintf('Could not load images from the ORL database. Did you unpack it into \nthe appropriate directory? If NOT please follow the instructions \nin the user manual or the provided install script. Ending demo prematurely.'));
end
disp('Finished loading ORL images.')

%% Main part
if(proceed)
    disp('Computing PCA subspace using the entire ORL database as training data.')
    model = perform_pca_PhD(data_matrix,399);
    disp('Finished PCA subspace construction.')
    disp('Displaying results.')
    figure(1)
    imshow(reshape(model.P,size_y,size_x),[])
    title('Mean face')
    figure(2)
    for i=1:6
        subplot(4,2,i)
        imshow(reshape(model.W(:,i),size_y,size_x),[])
        title(sprintf('Eigenface no. %i',i));
    end
    subplot(4,2,7)
    imshow(reshape(model.W(:,100),size_y,size_x),[])
    title('Eigenface no. 100')
    subplot(4,2,8)
    imshow(reshape(model.W(:,300),size_y,size_x),[])
    title('Eigenface no. 300')  
    set(gcf,'Name', 'PCA components/Eigenfaces/eigenvectors in image form')  
    disp('Note that this is only a simple example without prior localization and alignment.')
    disp('With proper preprocessing and alignement of the images you could get very different results.')
    disp('Press any key to continue ...')
    pause();
    close all
    disp('Finished demo.')
end






