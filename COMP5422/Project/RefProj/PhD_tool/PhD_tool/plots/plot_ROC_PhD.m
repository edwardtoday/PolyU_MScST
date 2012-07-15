% The function plots the so-called ROC curve based on the provided input data
% 
% PROTOTYPE
% h=plot_ROC_PhD(ver_rate, miss_rate, color, thickness)
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       % we generate the scores through a random generator
%       true_scores = 0.5 + 0.9*randn(1000,1);
%       false_scores = 3.5 + 0.9*randn(1000,1);
%       [ver_rate, miss_rate, rates] = produce_ROC_PhD(true_scores,false_scores);
%       h=plot_ROC_PhD(ver_rate, miss_rate);
% 
%     Example 2:
%       % we generate the scores through a random generator
%       true_scores = 0.5 + 1*randn(1000,1);
%       false_scores = 3.0 + 1*randn(1000,1);
%       [ver_rate, miss_rate, rates] = produce_ROC_PhD(true_scores,false_scores);
%       h=plot_ROC_PhD(1-ver_rate, miss_rate, 'b',4);
%       xlabel('False Acceptance Rate')
%       ylabel('False Rejection Rate')
% 
%     Example 3:
%       % we generate the scores through a random generator
%       figure(1)
%       true_scores = 0.5 + 0.9*randn(1000,1);
%       false_scores = 3.2 + 0.9*randn(1000,1);
%       [ver_rate, miss_rate, rates] = produce_ROC_PhD(true_scores,false_scores);
%       h=plot_ROC_PhD(ver_rate, miss_rate);
%       hold on
%       true_scores = 0.5 + 0.9*randn(1000,1);
%       false_scores = 3.0 + 0.9*randn(1000,1);
%       [ver_rate, miss_rate, rates] = produce_ROC_PhD(true_scores,false_scores);
%       h=plot_ROC_PhD(ver_rate, miss_rate,'b');
% 
% GENERAL DESCRIPTION
% The function plots the so-called ROC (Receiver Operating Characteristic)
% curve and returns a hanle to the plotted graph. 
% 
% The function takes four input arguments, where the first two represent 
% the data to be plotted. More specifically, the first argument represents 
% a vector of verification rates and the second argument represents a vector 
% of corresponding miss rates. Both arguments can be calculated 
% from the matching scores using the "produce_ROC_PhD" function from the
% PhD face recognition toolbox. The third and frouth argument of the function 
% are optional and stand for the color of the plotted graph and the thickness 
% of the plotted graph. 
% 
% It should be noted that it is possible to add several graphs to the same
% figure using this function. In this regard, its usage is more or less 
% identical to Matlabs build-in "plot" function. 
% 
% Note that the function plots the verification rate against the miss
% rate. If you would like to plot the common false accaptance against the
% false rejection rate, use the function as shown in Example 2 above. All
% grpahs here are ploted in the "semilogx" scale. To change this according 
% to your preferences, you have to change the corresponding line of code in 
% the functions body.  
%
% 
% REFERENCES
% There are several references available in the literature that describe 
% ROC curves and ways to plot them. A short description is alsgo given in:
% 
% Štruc V., Pavešic, N.: The Complete Gabor-Fisher Classifier for Robust 
% Face Recognition, EURASIP Advances in Signal Processing, vol. 2010, 26
% pages, doi:10.1155/2010/847680, 2010.
% 
%
%
% INPUTS:
% ver_rate              - a 1xN (or Nx1) vector of verification rates 
%                         obtained through the use of the "produce_ROC_PhD" 
%                         function or some of your own scripts/functions; 
%                         where N is the number of sampled points between 
%                         the smalest and largest matching score of your 
%                         experiments; the verification rate stands for 
%                         1-FRR, where FRR is the false rejection rate 
%                         (obligatory argument)
% miss_rate             - a 1xN (or Nx1) vector of miss rates (or false 
%                         acceptance rates) obtained through the use of the 
%                         "produce_ROC_PhD" function or some of your own 
%                         scripts/functions; where N is the number of 
%                         sampled points between the smalest and largest 
%                         matching score of your experiments; the 
%                         miss rate stands for FAR, where FAR is 
%                         the false rejection rate (obligatory argument)
% color                 - an argument determining the color of the plotted
%                         graph; see the help section of the "plot"
%                         function for details on this argument; e.g., 'r'
%                         (optional argument)
% thickness             - a parameter determinig the thickness of the
%                         plotted graph (optinal argument)
%
% OUTPUTS:
% h                     - the handle to the plotted graph 
%                         
%
% NOTES / COMMENTS
% The function was tested with Matlab ver. 7.9.0.529 (R2009b) and Matlab 
% ver. 7.11.0.584 (R2010b).
%
% 
% 
% RELATED FUNCTIONS (SEE ALSO)
% produce_ROC_PhD
% plot
% plot_EPC_PhD
% plot_CMC_PhD
% 
% 
% ABOUT
% Created:        11.2.2010
% Last Update:    21.11.2011
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
function h=plot_ROC_PhD(ver_rate, miss_rate, color, thickness)

%% Init operations
h = [];

%% Check inputs

%check number of inputs
if nargin <2
    disp('Wrong number of input parameters! The function requires at least two input arguments.')
    return;
elseif nargin==2
    color='r';
    thickness=2;
elseif nargin==3
    thickness=2;    
end


%check for values
    if isnumeric(ver_rate)~=1
        disp('The verification rate needs to be a numeric vector!')
        return;
    end
    
    if isvector(ver_rate)~=1
        disp('The verification rate needs to be a numeric vector!')
        return;
    end
    
    if isnumeric(miss_rate)~=1
        disp('The miss-rate needs to be a numeric vector!')
        return;
    end
    
    if isvector(miss_rate)~=1
        disp('The miss-rate needs to be a numeric vector!')
        return;
    end
    
%% Init operations
if numel(ver_rate)~=numel(miss_rate)
    disp('The verification rate vector and miss-rate vector need to be of the same size!')
    return;
end

%% Plot axis
h=semilogx(miss_rate,ver_rate,'Color',color,'Linewidth',thickness);


%axis labels
xlabel('False Accept Rate')
ylabel('Verification Rate')

%grid lines 
grid on
axis([1e-3 1 0 1])

%other 
set(gca, ...
  'XMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XGrid'       , 'on'      , ...
  'YTick'      , 0:0.1:1 );
































