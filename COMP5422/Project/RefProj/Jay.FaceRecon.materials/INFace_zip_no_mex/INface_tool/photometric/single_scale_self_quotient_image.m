% The function applies the single scale self quotient image algorithm to an image.
% 
% PROTOTYPE
% [Y,L]=single_scale_self_quotient_image(X,siz,sigma,normalize);
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       X=imread('sample_image.bmp');
%       Y=single_scale_self_quotient_image(X);
%       figure,imshow(X);
%       figure,imshow(Y,[]);
% 
%     Example 2:
%       X=imread('sample_image.bmp');
%       Y=single_scale_self_quotient_image(X,11);
%       figure,imshow(X);
%       figure,imshow(Y,[]);
% 
%     Example 3:
%       X=imread('sample_image.bmp');
%       Y=single_scale_self_quotient_image(X,7,0.5);
%       figure,imshow(X);
%       figure,imshow(Y,[]);
% 
%     Example 4:
%       X=imread('sample_image.bmp');
%       [Y,L]=single_scale_self_quotient_image(X,[],[],0);
%       figure,imshow(X);
%       figure,imshow(Y,[]);
%       figure,imshow(L,[]);
% 
%     Example 5:
%       X=imread('sample_image.bmp');
%       [Y,L]=single_scale_self_quotient_image(X,7,0.5,0);
%       figure,imshow(X);
%       figure,imshow(Y,[]);
%       figure,imshow(L,[]);

%
%
% GENERAL DESCRIPTION
% The function performs photometric normalization of the image X using the
% self quotient image technique. Even though in the original paper the 
% technique is proposed to be implemente with several scales (similar to 
% the multi scale retinex technique), this implementation supprots only a 
% single scale. The multi scale self quotient image is implemented in a 
% separate function.
% 
% The function is intended for use in face recognition experiments and the
% default parameters are set in such a way that a "good" normalization is
% achieved for images of size 128 x 128 pixels. Of course the term "good" is
% relative.
%
%
% 
% REFERENCES
% This function is an implementation of the single scale self quotient
% image algorithm proposed in:
%
% H. Wang, S.Z. Li, Y. Wang, and J. Zhang, “Self Quotient Image for Face
% Recognition,?in: Proc. of the International Conference on Pattern 
% Recognition, October 2004, pp. 1397- 1400.
%
%
%
% INPUTS:
% X                     - a grey-scale image of arbitrary size
% siz				    - an odd scalar value determining the size of the
%                         filter, the default value is "siz = 5"
% sigma                 - a scalar value determining the bandwidth of the
%                         gaussian filter, default value is "sigma = 1"
% normalize             - a parameter controlling the post-processing
%                         procedure:
%                            0 - no normalization
%                            1 - perform basic normalization (truncation 
%                                of histograms ends and normalization to the 
%                                8-bit interval) - default
% 
%
% OUTPUTS:
% Y                     - a grey-scale image processed with the single
%                         scale self quotient image technique (the reflectance)
% L                     - the estimated luminance function
%                         
%
% NOTES / COMMENTS
% This function applies the single scale self quotient algorithm to the
% grey-scale image X. 
%
function [Y,L]=single_scale_self_quotient_image(X,siz,sigma,normalize);

%% Init
Y=[];
L=[];

%% Parameter checking
if nargin == 1
    siz = 5;
    sigma = 1;
    normalize = 1;
elseif nargin == 2
    if isempty(siz)
        siz = 5;
    end
    sigma = 1;
    normalize = 1;
elseif nargin ==3
    if isempty(siz)
        siz = 5;
    end
    if isempty(sigma)
        sigma = 1;
    end
    normalize = 1;
elseif nargin ==4
    if isempty(siz)
        siz = 5;
    end
    if isempty(sigma)
        sigma = 1;
    end
    if ~(normalize==1 || normalize==0)
        disp('Error: The fourth parameter can only be 0 or 1.');
        return;
    end
elseif nargin > 4
    disp('Error: Wrong number of input parameters.')
    return;
end

if mod(siz,2)==0
    siz=siz+1;
    disp(sprintf('Warning, The value of the parameter "siz" needs to be odd. Changing value to %i.',siz));
end

%% Init. operations
X=normalize8(X);
[a,b]=size(X);
filt = fspecial('gaussian',[siz siz],sigma);
padsize = floor(siz/2);

%% Image padding
padX = padarray(X,[padsize, padsize],'symmetric','both');


%% Process image
Z=zeros(siz,b);
for i=padsize+1:a+padsize
    for j=padsize+1:b+padsize
        region = padX(i-padsize:i+padsize, j-padsize:j+padsize);
        M=return_step(region);
        filt1=filt.*M;       
        
        summ=0;
        for k=1:siz
            for h=1:siz
                summ=summ+filt1(k,h);
            end
        end
        filt1=(filt1/summ);%*(0.7);
        Z(i-padsize,j-padsize)=(sum(sum(filt1.*region))/(siz*siz));        
    end
end


%% Compute self quotient image and correct singularities
Y=((X./(Z+0.01)));
%Y = log(double(X)+0.1)-log(Z+0.1); %we could also use this for kind of an "anisotropic retinex"
for i=1:a
    for j=1:b
        if isnan(Y(i,j))==1 || isinf(Y(i,j))==1
            if i~=1
                Y(i,j)=Y(i-1,j);
            else
                Y(i,j)=1;
            end
        end
    end
end

%% Adjust histogram (or not)
L=Z;
if normalize ~=0
    [Y, dummy] = histtruncate(Y,2,2);
    Y = normalize8(Y);
    L = normalize8(L);
end




%% This auxilary function computes the anisotropic filter
function M=return_step(X);

[a,b]=size(X);
M=zeros(a,b);
means=mean(X(:));

counter=0;
counter1=0;
for i=1:a
    for j=1:b
        if X(i,j)>=means
            M(i,j)=1;
            counter=counter+1;
        else
            M(i,j)=0;
            counter1=counter1+1;
        end
    end
end































