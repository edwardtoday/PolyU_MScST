function [Eyeangle , ConfidentLevel]=detect_headpose(GrayImage,skinlevelmin,skinlevelmax,displaystatus)

Eyeangle = 0;
ConfidentLevel = 0;
ImageHeight=size(GrayImage,1);
ImageWidth=size(GrayImage,2);
if (displaystatus == 1)
    subplot(3,3,1),imshow(GrayImage);title('Input Image');
end
I = 255 - GrayImage ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% EXTRACT SKIN %%%%%%%%%%%%%%%%%%%%%%
S=zeros(ImageHeight,ImageWidth);
[SkinIndexRow,SkinIndexCol] =find(skinlevelmin<I & I<skinlevelmax);
for i=1:length(SkinIndexRow)
    S(SkinIndexRow(i),SkinIndexCol(i))=1;
end
if (displaystatus == 1)
    subplot(3,3,2),imshow(S);title('Extract Skin');
end
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
if (displaystatus == 1)
    subplot(3,3,3),imshow(SN);title('skin with noise removal');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ISN = ~SN;

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
if (displaystatus == 1)
    subplot(3,3,4);imshow(BW3);title('Inverse Skin Block');
end

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
if (displaystatus == 1)
    subplot(3,3,5);imshow(FaceComponent);title('Face component');
end


%%%%%%%%%%%%%%% FIND Componenet Orientation %%%%%%%%%%%%%%%%%

L = bwlabel(FaceComponent,8); %% SN
EyeOrientation  = regionprops(L,'Orientation');
AscOrder = sort( [EyeOrientation.Orientation]);
Eyeresult = 0;
if (size(AscOrder,2) > 0) 
    Eyeangle = AscOrder(ceil(size(AscOrder,2)/2));
    precision = 3;
    titlestring = ['Eye angle is (',  num2str(Eyeangle,precision),')'];
    Eyeresult = 1;
else 
    Eyeangle = 0;
    titlestring = 'Unable to detect feature component';
end
    
rgb=label2rgb(L);
if (displaystatus == 1)
    subplot(3,3,6),imshow(rgb);title(titlestring);
end
TransformedImage = imrotate(GrayImage,-1*Eyeangle,'bilinear','crop');
if (displaystatus == 1)
    subplot(3,3,7),imshow(TransformedImage);title('Transformed Image');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (Eyeresult > 0)
    EyeTopArea = ceil(ImageHeight/3);
    EyeAreaHeight = ceil(ImageHeight/6);
    EyeLeftArea = ceil(ImageWidth/3);
    EyeAreaWidth = ceil(ImageWidth/3);
    I2 = imcrop(TransformedImage,[EyeLeftArea EyeTopArea EyeAreaWidth EyeAreaHeight]);


    AvgLeft=mean(mean( I2(:,1:round(EyeAreaWidth/2)) ));
    AvgRight=mean(mean(I2(:,round(EyeAreaWidth/2):EyeAreaWidth) ));

    ConfidentLevel = 1 - abs(AvgLeft-AvgRight)/max([AvgLeft,AvgRight]);
    titlestring =  ['Level is (',  num2str(ConfidentLevel,precision),')'];
    if (displaystatus == 1)
        subplot(3,3,8),imshow(I2);title(titlestring);
    end

else
    ConfidentLevel = 0;
end
end
