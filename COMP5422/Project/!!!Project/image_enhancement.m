function out=image_enhancement(database_in);
% Enhancing face images in the database the first time we run the program.
persistent image_enhanced;
persistent dataset_enhanced;
if(isempty(image_enhanced))
    disp('Enhancing face images in the database...');
    tic;
    dataset=zeros(10304,400);

    for i=1:size(database_in,2)
        I = reshape(database_in(:,i),112,92);
%         I = adapthisteq(I);
        I = imadjust(I);
%         I = single_scale_retinex(I);
        dataset(:,i)=reshape(I,112*92,1);
    end
    
    dataset_enhanced=uint8(dataset); % Convert to unsigned 8 bit numbers to save memory. 
    toc;
end
image_enhanced=1;  % Set 'image_enhanced' to avoid applying the enhancement again. 
out=dataset_enhanced;