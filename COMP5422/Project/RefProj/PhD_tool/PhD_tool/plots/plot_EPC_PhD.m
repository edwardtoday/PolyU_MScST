% The function plots the so-called EPC curve based on the provided input data
% 
% PROTOTYPE
% h=plot_EPC_PhD(alpha,errors, color, thickness)
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       % we generate the scores through a random generator
%       true_scores = 0.5 + 0.9*randn(1000,1);
%       false_scores = 3.5 + 0.9*randn(1000,1);
%       [ver_rate, miss_rate, rates] = produce_ROC_PhD(true_scores,false_scores);
%       true_scores1 = 0.6 + 0.8*randn(1000,1);
%       false_scores1 = 3.3 + 0.8*randn(1000,1);
%       [alpha,errors,rates_and_threshs] = produce_EPC_PhD(true_scores,false_scores,true_scores1,false_scores1,rates,20);
%       h=plot_EPC_PhD(alpha, errors);
% 
%     Example 2:
%       % we generate the scores through a random generator
%       true_scores = 0.5 + 0.9*randn(1000,1);
%       false_scores = 3.5 + 0.9*randn(1000,1);
%       [ver_rate, miss_rate, rates] = produce_ROC_PhD(true_scores, false_scores);
%       true_scores1 = 0.6 + 0.8*randn(1000,1);
%       false_scores1 = 3.3 + 0.8*randn(1000,1);
%       [alpha,errors,rates_and_threshs] = produce_EPC_PhD(true_scores,false_scores,true_scores1,false_scores1,rates,20);
%       h=plot_EPC_PhD(alpha, errors,'b',4);
% 
% 
% GENERAL DESCRIPTION
% The function plots the so-called EPC (Expected Performance Curve)
% curve and returns a hanle to the plotted graph. 
% 
% The function takes four input arguments, where the first two represent 
% the data to be plotted. More specifically, the first argument represents 
% a vector of alphas and the second argument represents a vector 
% of corresponding error rates. Both arguments can be calculated 
% from the matching scores using the "produce_EPC_PhD" function from the
% PhD face recognition toolbox. The third and frouth argument of the function 
% are optional and stand for the color of the plotted graph and the thickness 
% of the plotted graph. 
% 
% It should be noted that it is possible to add several graphs to the same
% figure using this function. In this regard, its usage is more or less 
% identical to Matlabs build-in "plot" function. 
% 
% Note that the function plots the weighted error rates: 
% 
%                   WER = alpha*FAR+(1-alpha*FRR)) 
% 
% against the corresponding "alpha" value, where all alphas are drawn from 
% the interval [0,1].
%
% 
% REFERENCES
% A useful reference, wher you can learn about EPC curves is:
% 
% S. Bengio and J. Marithoz, “The expected performance curve: a new 
% assessment measure for person authentication,” in Proceedings of the 
% Speaker and Language Recognition Workshop Oddyssey, pp. 279–284, Toledo, 
% Spain, 2004.
% 
%
%
% INPUTS:
% alpha                 - a 1xN (or Nx1) vector of alpha values obtained 
%                         through the use of the "produce_EPC_PhD" 
%                         function or some of your own scripts/functions; 
%                         where N is the number of sampled points between 
%                         the smalest and largest possible alpha value;
%                         (obligatory argument)
% errors                - a 1xN (or Nx1) vector of weighted errors 
%                         obtained through the use of the 
%                         "produce_EPC_PhD" function or some of your own 
%                         scripts/functions; where N is the number of 
%                         sampled points between the smalest and largest 
%                         possible alpha value (obligatory argument)
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
% produce_EPC_PhD
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
% If you are interested in face recognition you are invited to have a look
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

function h=plot_EPC_PhD(alpha,errors, color, thickness)

%% Init ops
h=[];

%% Check inputs

%check number of inputs
if nargin <2
    disp('Wrong number of input parameters! The function requires at least two input arguments.')
    return;
elseif nargin >4
    disp('Wrong number of input parameters! The function requires at most four input arguments.')
elseif nargin==2
    color='r';
    thickness=2;
elseif nargin==3
    thickness=2;    
end


%check for values
    if isnumeric(alpha)~=1
        disp('The parameter alpha needs to be a numeric vector!')
        return;
    end
    
    if isvector(alpha)~=1
        disp('The parameter alpha needs to be a numeric vector!')
        return;
    end
    
    if isnumeric(errors)~=1
        disp('The errors need to be a numeric vector!')
        return;
    end
    
    if isvector(errors)~=1
        disp('The errors need to be a numeric vector!')
        return;
    end
    
%% Init operations
if numel(alpha)~=numel(errors)
    disp('The alpha vector and errors vector need to be of the same size!')
    return;
end

%% Plot axis
h=plot(alpha,errors,'Color',color,'Linewidth',thickness);


%axis labels
xlabel('\alpha')
ylabel('Error rate')

%grid lines 
grid on
axis([min(alpha) max(alpha) 0 1])

%other 
set(gca, ...
  'XMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XGrid'       , 'on'    );
































