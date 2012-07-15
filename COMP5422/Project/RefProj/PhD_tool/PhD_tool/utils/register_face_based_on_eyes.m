% Extracts the face region from an image based on provided eye coordinates
% 
% PROTOTYPE
% Y = register_face_based_on_eyes(X,eyes,size1)
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       eyes.x(1)=160;  %These coordinates were obtained using getpts(),
%       eyes.y(1)=184;  %but could also be read from a file
%       eyes.x(2)=193;
%       eyes.y(2)=177;
%       X=imread('sample_image.bmp');
%       Y = register_face_based_on_eyes(X,eyes,[128 100]);
%       figure,imshow(X,[]);
%       figure,imshow(uint8(Y),[]);
% 
%     Example 2:
%       eyes.x(1)=160;
%       eyes.y(1)=184;
%       eyes.x(2)=193;
%       eyes.y(2)=177;
%       X=imread('sample_image.bmp');
%       Y = register_face_based_on_eyes(X,eyes);
%       figure,imshow(X,[]);
%       figure,imshow(uint8(Y),[]);
% 
%     Example 3:
%       eyes.x(1)=160;
%       eyes.y(1)=184;
%       eyes.x(2)=193;
%       eyes.y(2)=177;
%       X=imread('sample_image.bmp');
%       Y = register_face_based_on_eyes(X,eyes,100);
%       Y = mean(Y,3);  % produce grey-scale image from color image
%       figure,imshow(X,[]);
%       figure,imshow(uint8(Y),[]);
%
%
% GENERAL DESCRIPTION
% The function extracts the facial region from the given image X based on
% the coordinates given in the structure "eyes". The image is then
% normalized to a fixed size given by the parameter "size1". It takes either
% two or three arguments. If the argument "size1" is omitted, the output
% facial region returned will be of size 128x128 pixels. The parameter size
% can be given as a single number (in pixels), in which case a square
% facial region is returned. When given as a 1x2 matrix with two elements, e.g.,
% size1 = [128 100], a region of this size is returned.
% 
% The input image X can be a color image or a grey-scale one. If the input
% is in color, the output is also in color, and similarly, if the input
% image is a grey-scale one, then the outputimage is also a grey-scale one.
%
% 
% REFERENCES
% Unfortunatelly, I have no reference (in english) of mine to demonstrate
% the procedure (eventually I plan to write a tutorial for beginners in the 
% field of face recognition).
%
%
%
% INPUTS:
% X                     - a grey-scale or color image of arbitrary size
% eyes				    - a structure containing the eye coordinates; the
%                         structure takes the following form:                           
%             eyes.x(1) - x coordinate of the images left eye 
%                         (this corresponds to the right eye in real life)
%             eyes.x(2) - x coordinate of the images right eye 
%                         (this corresponds to the left eye in real life)
%             eyes.y(1) - y coordinate of the images left eye 
%                         (this corresponds to the right eye in real life)
%             eyes.y(2) - y coordinate of the images right eye 
%                         (this corresponds to the left eye in real life)
% size1                 - a parameter determining the size of the output 
%                         image; it can take a single value, e.g., size=128, 
%                         or it can be a 1x2 matrix, e.g., size=[100 60].
%                         default: size1=[128 128]
%
% OUTPUTS:
% Y                     - a grey-scale or color facial image (depending on 
%                         the input format) extracted from the input image X 
%
% NOTES / COMMENTS
% This function extracts the facial region from the given input image X 
% based on some eye coordinates. Note that the eye coordinates have to be 
% read from an external source, e.g., a text file (if they were marked 
% manually and stored for later use), or they have to be provided by a 
% facial landmark detector. This function is not intended to perform the 
% localization for you, it just extracts the facial regions from the given 
% image and normalizes it in respect to rotation and size. However, it does 
% so based on the provided eye-coordinates.   
% 
% The function extracts the face region based on the following
% configuration: it first computes the interoccular distance di and uses the
% mid-point between the eyes (of the rotated image - the rotation angle is 
% determined in such a way that the line conecting the eyes is horizontal)
% as the starting point. From this point the upper bound of the face region 
% is deterimned by substartcing 0.6*di, the lower bound by adding 1.75*di, 
% and the left and right boundaries are computed by substracting and adding  
% 0.9*di, respectively. You can change the borders by changing the values
% of the coeffcients k1, k2, k3, and k4 in the last part of this function.
% However, to do so, you have to change the source code at the end of this 
% file. 
%
% The function was tested with Matlab ver. 7.9.0.529 (R2009b) and Matlab 
% ver. 7.11.0.584 (R2010b).
%
% 
% ABOUT
% Created:        3.2.2010
% Last Update:    10.11.2011
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

function Y = register_face_based_on_eyes(X,eyes,size1)

%% Init
Y=[];

%% Check inputs

%check number of inputs
if nargin <2
    disp('Wrong number of input parameters! The function requires at least two input arguments.')
    return;
elseif nargin >3
    disp('Wrong number of input parameters! The function takes no more than three input arguments.')
    return;
elseif nargin==2
    size1 = [128 128];
end

%check image
[a,b,c]=size(X);
if a<2 || b<2
    disp('X is not a valdi image. The height/width has to be larger than 1 pixel.')
    return;
end

%check coordinates
if isfield(eyes,'x')~=1
    disp('No x coordinates were found in the coordinates structure.')
    return;
end
if isfield(eyes,'y')~=1
    disp('No y coordinates were found in the coordinates structure.')
    return;
end

[a,b] = size(eyes.x);
if a==1 && b==2 || a==2 && b==1
else
    disp('The x coordinates were not defined properly. Please type "help register_face_based_on_eyes"')
    return;
end

[a,b] = size(eyes.y);
if a==1 && b==2 || a==2 && b==1
else
    disp('The y coordinates were not defined properly. Please type "help register_face_based_on_eyes"')
    return;
end

%check size parameter
[a,b]=size(size1);
if a==1 && b==1
    size1 = [size1 size1];
elseif a==1 && b==2
    size1=size1;
else
    disp('The parameter defining the size of the output is not in the right format.')
    return;
end
    

%% Parse inputs

%convert to double
X=double(X);

[a,b,dummy] = size(X);
x_cent = ceil(b/2);
y_cent = ceil(a/2);

%these are the remains of my previous implementation
x_leva = double(eyes.x(1));
y_leva = double(eyes.y(1));
x_desna = double(eyes.x(2));
y_desna = double(eyes.y(2));


%% Correct for rotation

%get rotation angle
kateta1 = abs(x_leva-x_desna);
kateta2 = abs(y_leva-y_desna);

if y_leva>y_desna
    angle = -(atan(kateta2/kateta1))*(180/pi);
elseif y_leva<y_desna
    angle = (atan(kateta2/kateta1))*(180/pi);
elseif y_leva==y_desna
    angle = 0;
end


%recompute the coordinates in the rotated image
if angle ==0
    Y=X;
    [c,d,e1]=size(Y);    
else
    Y=uint8(imrotate((X),angle,'bilinear'));
    [c,d,e]=size(Y);
    x_cent_rot = ceil(d/2);
    y_cent_rot = ceil(c/2);
    
    x_mid = round((x_leva+x_desna)/2);
    y_mid = round((y_leva+y_desna)/2);
    
    my_hypo = sqrt((x_leva-x_desna)^2+(y_leva-y_desna)^2);
    
    if x_mid == x_cent
     x_mid=x_mid+1;
    end

    if y_mid == y_cent
         y_mid=y_mid+1;
    end
    
    hipoten = sqrt((x_mid-x_cent)^2+(y_mid-y_cent)^2);
    x_koor = abs(x_mid-x_cent);
    if (x_mid > x_cent) & (y_mid<y_cent)        
        kot = acos(x_koor/hipoten)+(angle*pi/180);
        x1(1) = (x_cent_rot+cos(kot)*hipoten);
        y1(1) = (y_cent_rot-sin(kot)*hipoten);
    end   
    if (x_mid < x_cent) & (y_mid<y_cent)        
        kot = acos(x_koor/hipoten)-(angle*pi/180);
        x1(1) = (x_cent_rot-cos(kot)*hipoten);
        y1(1) = (y_cent_rot-sin(kot)*hipoten);
    end
    if (x_mid > x_cent) & (y_mid>y_cent)        
        kot = acos(x_koor/hipoten)-(angle*pi/180);
        x1(1) = (x_cent_rot+cos(kot)*hipoten);
        y1(1) = (y_cent_rot+sin(kot)*hipoten);
    end  
    if (x_mid < x_cent) & (y_mid>y_cent)        
        kot = acos(x_koor/hipoten)+(angle*pi/180);
        x1(1) = (x_cent_rot-cos(kot)*hipoten);
        y1(1) = (y_cent_rot+sin(kot)*hipoten);
    end
    
    x_leva = double(round(x1-(my_hypo/2))-1);
    x_desna = double(round(x1+(my_hypo/2))-1);
    y_leva = double(round(y1)-1);
    y_desna = double(round(y1)-1);
end


%% Extract facial region

% origin point for face frame
T_x = round((x_leva+x_desna)/2);
T_y = round((y_leva+y_desna)/2);
    
% frame coordinates calculation
d_ex = abs(x_desna-x_leva); 

% these determine the extracted region - in percentage (% = k*100) of the 
% interoccluar distance (You can play with these and get different facial areas)
k1 = 0.6;       %these are the final coefficient, there will be no more change - the xm2vts database was extracted a bit differently (just a bit)
k2 = 1.75;
k3 = 0.9;
k4 = 0.9;

% compute bounding box coordinates
y_u = T_y-round(k1*d_ex);
if y_u<=1
    y_u = 1;
end

y_l = T_y+round(k2*d_ex);
if y_l>a
    y_l=a;
end

x_f = T_x-round(k3*d_ex);
if x_f<1
    x_f=1;
end

x_s = T_x+round(k4*d_ex);
if x_s>b
    x_s=b;
end
    
    
%extract final facial region
Y=Y(y_u:y_l, x_f:x_s,:);
Y=imresize(Y,size1,'bilinear');
Y=uint8(Y);



















