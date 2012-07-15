function out=load_database();
% Load the database the first time we run the program.
% The database can be found at
%   http://www.cl.cam.ac.uk/research/dtg/attarchive/facedatabase.html
% The code assumes that the pgm files can be found at
%   ./att_faces/s1/1.pgm, ...
persistent loaded;
persistent dataset_uint8;
if(isempty(loaded))
    disp('Loading database...');
    tic
    dataset=zeros(10304,400);
    for person_id=1:40
        cd(strcat('att_faces/s',num2str(person_id)));
        %%figure(person_id);
        for sample_id=1:10
            I=imread(strcat(num2str(sample_id),'.pgm'));
            dataset(:,(person_id-1)*10+sample_id)=reshape(I,size(I,1)*size(I,2),1);
            %%subplot(1,10,sample_id);
            %%imshow(I);
            
        end
        cd ..
        cd ..
    end
    dataset_uint8=uint8(dataset); % Convert to unsigned 8 bit numbers to save memory. 
    toc
end
loaded=1;  % Set 'loaded' to avoid loading the database again. 
out=dataset_uint8;