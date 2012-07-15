%% Loading the database into matrix v
dataset_uint8=load_database(); 

%% Rotation compensation
% dataset_rotation=rotation_compensation(dataset_uint8);
 dataset_rotation=dataset_uint8;

%% Image enhancement
% dataset_enhanced=image_enhancement(dataset_rotation);
 dataset_enhanced=dataset_rotation;

%% Initializations
% We randomly pick an image from our database and use the rest of the
% images for training. Training is done on 399 pictues. We later
% use the randomly selectted picture to test the algorithm.

% Randomly pick an index.
randon_image_id = 346;
% Get the image for testing
random_image=dataset_enhanced(:,randon_image_id);
% Get the rest 399 images as training dataset
training_dataset=dataset_enhanced(:,[1:randon_image_id-1 randon_image_id+1:end]);

N=20;                               % Number of signatures used for each image.
%% Subtracting the mean from v
O=uint8(ones(1,size(training_dataset,2))); 
m=uint8(mean(training_dataset,2));                 % m is the maen of all images.
training_dataset_mean_removed=training_dataset-uint8(single(m)*single(O));   % vzm is v with the mean removed. 

%% Calculating eignevectors of the correlation matrix
% We are picking N of the 400 eigenfaces.
L=single(training_dataset_mean_removed)'*single(training_dataset_mean_removed);
[V,D]=eig(L);
V=single(training_dataset_mean_removed)*V;
V=V(:,end:-1:end-(N-1));            % Pick the eignevectors corresponding to the 10 largest eigenvalues. 

%% Calculating the signature for each image
signiture=zeros(size(training_dataset,2),N);
for i=1:size(training_dataset,2)
    signiture(i,:)=single(training_dataset_mean_removed(:,i))'*V;    % Each row in cv is the signature for one image.
end


%% Recognition 
%  Now, we run the algorithm and see if we can correctly recognize the face. 
subplot(121); 
%  We know that the images are 112 px by 92 px.
imshow(reshape(random_image,112,92));title(num2str(randon_image_id),'FontWeight','bold','Fontsize',16,'color','red');

subplot(122);
p=random_image-m;                              % Subtract the mean
s=single(p)'*V;
z=[];
for i=1:size(training_dataset,2)
    z=[z,norm(signiture(i,:)-s,2)];
    if(rem(i,20)==0),imshow(reshape(training_dataset(:,i),112,92)),end;
    drawnow;
end

[a,i]=min(z);

if (i<randon_image_id)
    found=i;
else
    found=i+1;
end

subplot(122);

imshow(reshape(training_dataset(:,i),112,92));title(strcat('best match=',num2str(found)),'FontWeight','bold','Fontsize',16,'color','blue');
