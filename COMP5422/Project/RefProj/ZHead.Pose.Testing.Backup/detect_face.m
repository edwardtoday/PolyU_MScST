function []=detect_face(I)

ImageHeight=size(I,1);
ImageWidth=size(I,2);
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

%%%%%%%%%%%%%%%%%% LIGHTING COMPENSATION %%%%%%%%%%%%%%%
%%%%  Normalise Luminance by its data range 
%%%%  The Y image is essentially a greyscale copy of the main image.
%%%%  Remark : The Hue domain from HSV can be tested as Hue might provide better Skin chroma difference than Y.
YCbCr=rgb2ycbcr(I);
Y=YCbCr(:,:,1);

minY=min(Y);
maxY=max(Y);
Y=255.0*(Y-minY)./(maxY-minY);
Yavg=sum(Y)/(ImageWidth*ImageHeight);

%% multiplication factor used to arraywise power of each pixel luminance

T=1; 
if (Yavg<64)    % if avg luminance is less than 25%, increase R & G with power of 1.4
    T=1.4;
elseif (Yavg>192)  % if avg luminance is greater than 75%, reduce R & G with power of 0.6
    T=0.6;
end

if (T~=1)
    RI=R.^T;
    GI=G.^T;
else
    RI=R;
    GI=G;
end

C=zeros(ImageHeight,ImageWidth,3);
C(:,:,1)=RI;
C(:,:,2)=GI;
C(:,:,3)=B;

LightC = C/255;
subplot(3,3,1),imshow(LightC);title('Lighting compensation');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% EXTRACT SKIN %%%%%%%%%%%%%%%%%%%%%%
YCbCr=rgb2ycbcr(C);  %%%% Cr =  red-difference chroma components , SKIN chroma difference range between 10 and 45
Cr=YCbCr(:,:,3);

S=zeros(ImageHeight,ImageWidth);
[SkinIndexRow,SkinIndexCol] =find(10<Cr & Cr<45);
for i=1:length(SkinIndexRow)
    S(SkinIndexRow(i),SkinIndexCol(i))=1;
end
subplot(3,3,2),imshow(S);title('Extract Skin');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%% REMOVE NOISE %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Taking 5x5 pixels block sample and setting zeros the block if block sum is larger than half of the block size i.e. > 12.5 
%%%% The block size can be further adjust to accommodate image quality
SN=zeros(ImageHeight,ImageWidth);
for i=1:ImageHeight-5
    for j=1:ImageWidth-5
        localSum=sum(sum(S(i:i+4, j:j+4)));
        SN(i:i+5, j:j+5)=(localSum>12);
    end
end
subplot(3,3,3),imshow(SN);title('skin with noise removal');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ISN = ~SN;
%imshow(ISN)
radii = 5:1:15;
e = edge(ISN, 'canny');h = circle_hough(e, radii, 'same', 'normalise');
CC=bwconncomp(ISN,4);
S = regionprops(CC,'Area')
L = labelmatrix(CC)
Eyemin = round(ImageWidth/25 * ImageHeight/30)
Eyemax = round(ImageWidth/8 *ImageHeight/15)

TopArea = ceil(ImageHeight/5);
BottomArea = ceil(ImageHeight*4/5);
LeftArea = ceil(ImageWidth/5);
RightArea = ceil(ImageWidth*4/5);
L(1:TopArea,:) = 0;
L(BottomArea:ImageHeight,:) = 0;
L(TopArea:BottomArea,1:LeftArea) = 0;
L(TopArea:BottomArea,RightArea:ImageWidth) = 0;
if (size([S.Area],2) > 3)
    BW3 = ismember(L,find([S.Area] >= Eyemin))
else
    BW3 = ISN;
end

BW3(1:TopArea,:) = 0;
BW3(BottomArea:ImageHeight,:) = 0;
BW3(TopArea:BottomArea,1:LeftArea) = 0;
BW3(TopArea:BottomArea,RightArea:ImageWidth) = 0;
subplot(3,3,4);
imshow(BW3);title('Inverse Skin Block');

QQ = S    % copy area structure
if  (size([S.Area],2) > 3)
 outsideset = [find([QQ.Area] < Eyemin),find([QQ.Area] > Eyemax)];
else
    outsideset = find([QQ.Area] > Eyemax);
end
FaceComponent = BW3 %may try to copy ISN 


for i = 1:size(outsideset,2)
    FaceComponent (CC.PixelIdxList{outsideset(i)}) = 0;    
end
subplot(3,3,5);imshow(FaceComponent);title('Face component');

%%%%%%%%%%%%%%% FIND Componenet Orientation %%%%%%%%%%%%%%%%%

L = bwlabel(FaceComponent,8); %% SN
EyeOrientation  = regionprops(L,'Orientation');
AscOrder = sort( [EyeOrientation.Orientation]);

Eyeangle = AscOrder(ceil(size(AscOrder,2)/2))
precision = 3;
  titlestring = ['Eye angle is ~',  num2str(Eyeangle,precision)];
rgb=label2rgb(L);
subplot(3,3,6),imshow(rgb);title(titlestring);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



end
