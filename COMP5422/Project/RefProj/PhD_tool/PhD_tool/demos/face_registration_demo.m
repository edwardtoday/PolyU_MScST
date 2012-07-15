% A demo script showing how to use a function from the toolbox to register the face based on manually anotated eye coordinates. 
% 
% DEMO NAME: FACE REGISTRATION DEMO
% 
% GENERAL DESCRIPTION
% The script uses the "register_face_based_on_eyes" function from the PhD
% toolbox to demonstrate how to register the face based in manually
% enotated eye coordinates. Specifically, it demonstrates two different 
% examples. In the first the coordinates are hard coded in the script and
% in the second they are read from an external file. For more inormation on
% the "register_face_based_on_eyes" and its functionality, please type
% 
% help register_face_based_on_eyes
%
% into Matlab's command window.
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
% Created:        17.11.2011
% Last Update:    17.11.2011
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
disp(sprintf('This is a demo script for the PhD toolbox. It demonstrates how to use a function from the toolbox to register a face based on manually anotated eye coordinates'));
disp(' ')
disp('Loading sample image.')
disp(' ')
X=imread('data/sample_image.bmp');
figure, imshow(X,[])
disp('This is the sample image. Press any key to continue ...')
pause();


%% Set coordinates
eyes.x(1)=160;  %These coordinates were obtained using getpts(),
eyes.y(1)=184;  %but could also be read from a file
eyes.x(2)=193;
eyes.y(2)=177;

disp('The coordinates of the eyes were set in the follwing form:')
disp('eyes.x(1)=160;')
disp('eyes.y(1)=184;')
disp('eyes.x(2)=193;')
disp('eyes.y(2)=177;')
disp(' ')
disp('Extracting face region of size 128x100 pixels.')
Y = register_face_based_on_eyes(X,eyes,[128 100]);
figure
imshow(Y,[]);
disp('Finished first example. Press any key to continue ...')
disp(' ')
pause()

%% Reading coordinates from file
disp('This example uses a file to read the eye coordinates from.')
disp('The result is the same as in the previou example, the difference is only in the source of the data.')
disp(' ')
disp('Reading file with eye coordinates.')
A=textread('data/sample_coors.txt');
eyes.x(1)=A(1);  
eyes.y(1)=A(2); 
eyes.x(2)=A(3);
eyes.y(2)=A(4);
disp('Extracting grey-scale face region of size 128x128 pixels.')
Y = mean(register_face_based_on_eyes(X,eyes,[128 128]),3);
figure
imshow(Y,[]);
disp('Finished demo.')









