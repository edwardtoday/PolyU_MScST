% A demo script showing how to compute oriented phase congrunecy from an input face image
% 
% DEMO NAME: PHASE CONGRUENCY FROM IMAGE DEMO
% 
% GENERAL DESCRIPTION
% The script demonstrates how to compute the phase congruency for an input
% face image. The demo first construct a filter bank of Gabor filters and
% then uses this bank to compute the phase congruency for each filter
% orientation in the filter bank. At the end the results are deisplay in a
% couple of figures.
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
% Created:        21.11.2011
% Last Update:    25.11.2011
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
disp(sprintf('This is a demo script for the PhD toolbox. It demonstrates how to use a \nfunction from the toolbox to construct a bank of Gabor filters and \nhow to compute phqse congruency features from an input image with the \nconstructed filter bank.'));
disp(' ')
disp('Constructing Gabor filter bank of 40 filters (8 orientation x 5 scales).')
filter_bank = construct_Gabor_filters_PhD(8, 5, [128 128]);


disp('Construction finished. Loading sample image for filtering operation.')
X=imread('data/sample_face.bmp');


disp('Computing phase congruency features (no downsampling).')
[pc,EO] = produce_phase_congruency_PhD(X,filter_bank);


disp('Filtering finished. Displaying results.')
figure(1)
imshow(X,[]);
title('Input face image')
figure(2)
for i=1:8
   subplot(2,4,i)
   imshow(pc{i},[])
end
figure(2)
set(gcf,'Name', 'Phase congrunecy features for all 8 filter orientations.')
disp('Press any key to continue ...')
pause();

close all

disp('Finished demo.')





