% This is the install script for the PhD face recognition toolbox. 
% 
% All this script does is 
% adding the toolbox paths to Matlabs search path. It should be noted that all 
% components of the toolbox were tested with Matlab version 7.11.0.584 
% (R2010b) running on Windows 7. Some parts were also tested with older 
% versions of Matlab. 
% 
% I have not tested any of the code on a Linux machine. Nevertheless, I see 
% no reason why it should not work on Linux as well. If this script fails you 
% probably do not have the necessary permissions to add the toolbox paths 
% to Matlabs "pathdef.m" file. Log in as an administrator and try again.


%% Get current directory and add all subdirectories to path
current = pwd;
addpath(current);
addpath([current '/classification']);
addpath([current '/eval']);
addpath([current '/features']);
addpath([current '/plots']);
addpath([current '/utils']);
savepath

disp(sprintf('This script has just installed the PhD toolbox on your computer. \nIt has added all toolbox paths to Matlabs search path and has \nmade the toolbox functional.'))
disp(' ')
disp(sprintf('Note that toolbox is self sufficient and requires no external software \nto function and to be used in face recognition experiments. However, \nsome of the demo scripts require face image data to work. I, therefore, \nencourage you to download the ORL (AT&T) database, and extract it to the \ndatabase folder, which is contained in the demos directory of the toolbox. \nThe toolbox is available from:\n\n http://www.cl.cam.ac.uk/Research/DTG/attarchive/pub/data/att_faces.zip'))
disp(' ')
disp(sprintf('If you do not trust the provided link, google "ORL database". The first hit \nis usually a link to the ORL/AT&T database that is required for most of \nthe demo scripts.'))
disp(' ')
disp(sprintf('Optionally, you can also download the DET software from NIST:\n \n http://www.nist.gov/itl/iad/mig/upload/DETware_v2-1-tar.gz \n\nWhile it is not needed by the toolbox to function properly, it can \nbe used by the toolbox to produce plots in form of DET curves.')      )

