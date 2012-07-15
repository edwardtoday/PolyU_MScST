function motiondetect
obj = videoinput('winvideo', 1);
open('project8.exe');
cd 'fscommand';
    open('nxtfrm_no.exe');
cd ..;
imaqmotion(obj);


function imaqmotion(obj)
try
    % Make sure we've stopped so we can set up the acquisition.
    stop(obj);
    
    % Configure the video input object to continuously acquire data.
    triggerconfig(obj, 'manual');
    
    %     set(obj, 'FramesAcquiredFcnCount', 1, ...
    %         'TimerFcn', @localFrameCallback, 'TimerPeriod', 0.1);
    %setting the returned color space to RGB rather then YCbCr which is set as
    % default and hence was causing issue with face recognition.
    set(obj, 'FramesAcquiredFcnCount', 1, ...
        'TimerFcn', @localFrameCallback, 'TimerPeriod', 0.1, 'ReturnedColorSpace', 'rgb');
    
    % Store the application data the video input object needs.
    appdata.background = [];
    obj.UserData = appdata;
    
    % Start the acquisition.
    start(obj);
    
    % Avoid peekdata warnings in case it takes too long to return a frame.
    warning off imaq:peekdata:tooManyFramesRequested
catch
    % Error gracefully.
    error('MATLAB:imaqmotion:error', ...
        sprintf('IMAQMOTION is unable to run properly.\n%s', lasterr))
end
clear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function localFrameCallback(vid, event)
% Executed by the videoinput object callback
% to update the image display.

% If the object has been deleted on us,
% or we're no longer running, do nothing.
if ~isvalid(vid) || ~isrunning(vid)
    return;
end

% Access our application data.
appdata = get(vid, 'UserData');
background = appdata.background;

% Peek into the video stream. Since we are only interested
% in processing the current frame, not every single image
% frame provided by the device, we can flush any frames in
% the buffer.
frame = peekdata(vid, 1);
if isempty(frame),
    return;
end
flushdata(vid);

% First time through, a background image will be needed.
if isempty(background),
    background = getsnapshot(vid);
end

%WAIT for FLASH GUI
cont = 'no';
nxtfrm = 'no';
cd 'fscommand';
while strcmp(cont,'no')
    fid = fopen('cont.txt', 'r');
    cont = fread(fid, '*char');
end
fclose(fid);

%%10 sec TIMER
% t = timer('TimerFcn','disp(''Started'')', ...
%           'StartDelay', 10);
% 
% %Start it running.
% start(t)

% Update the figure and our application data.
fid = fopen('nxtfrm.txt', 'r');
nxtfrm = fread(fid, '*char');
fclose(fid);

cd ..;

% fid = fopen('rec.txt', 'r');
% rec = fread(fid, '*char');
% fclose(fid);
% 
% %RECORD FILES
% aviobj = avifile('Unknown_compilation.avi');
% aviobj.Fps = 1;
% if strcmp(rec,'true') == 1
%     aviobj = addframe(aviobj,frame);
% end
% aviobj = close(aviobj);

if (strcmp(nxtfrm,'no') == 1 || strcmp(nxtfrm','no') == 1)
    localUpdateFig(vid, frame, background);
    cd 'fscommand';
    open('nxtfrm_yes.exe');
    cd ..;
end
if strcmp(nxtfrm,'add') == 1
    localUpdateFig_updateDB(vid, frame, background);
    cd 'fscommand';
    open('nxtfrm_yes.exe');
    cd ..;
end



appdata.background = frame;
set(vid, 'UserData', appdata);
clear


function localUpdateFig(vid, frame, background)
% Update the figure display with the latest data.

% If the figure has been destroyed on us, stop the acquisition.
% if ~ishandle(figData.hFigure),
%     stop(vid);
%     return;
% end

I = imabsdiff(frame, background);

Img = double (rgb2gray(frame));


% SAVES THE NEW FRAME AS A JPG
imwrite(imresize(frame, [400 600]),strcat('frame.jpg'));

% Check if its motion or not
graylevel = graythresh(I);
fid = fopen('motion.txt', 'w');
if graylevel ~= 0
    fwrite(fid, 'true');
    Face = FaceDetect('haarcascade_frontalface_alt2.xml',Img);
else
    fwrite(fid, 'false');
    Face = -1;
end
fclose(fid);

level = max(0, floor(100*graylevel));

number_faces = 0;
counter_pos = 1;
counter_pos_string = '';

if Face ~= -1
    fid = fopen('coordinates.txt', 'w');
    for i = 1:size(Face,1)
        Rectangle = [Face(i,1) Face(i,2); Face(i,1)+Face(i,3) Face(i,2); Face(i,1)+Face(i,3) Face(i,2)+Face(i,4); Face(i,1)  Face(i,2)+Face(i,4); Face(i,1) Face(i,2)];
        
        %Face detection validation check
        s1 = Rectangle(2,1)-Rectangle(1,1);
        s2 = Rectangle(4,2)-Rectangle(1,2);
        
        if((abs(s1)>200)&(abs(s1-s2)<350)&(ratio_check(s1,s2)<1.5)&(s1>100))
            number_faces = number_faces + 1;
            facerecog(frame, Rectangle);
            if number_faces == 1
                load face_counter.mat
                if number_face == 1
                    counter_pos = 10;
                else
                    counter_pos = number_face-1;
                end
                counter_pos_string = strcat(counter_pos_string,num2str(counter_pos),',');
            end
            % SAVES THE COORDINATES OF THE DETECTED FACES
            fwrite(fid, strcat(num2str(floor(((Face(i,1)/1280)*600))),',',num2str(floor((Face(i,2)/1024)*400)),','));
        end
    end
    fclose(fid);
    
    fid = fopen('variables.txt', 'w');
    
    fwrite(fid, strcat(num2str(number_faces),',',counter_pos_string));
    fclose(fid);
    
end
clear

function localUpdateFig_updateDB(vid, frame, background)

%MOTION is set to true as we want to indicate the user to move a bit.
fid = fopen('motion.txt', 'w');
fwrite(fid, 'true');
fclose(fid);

I = double(rgb2gray(frame));
Face = FaceDetect('haarcascade_frontalface_alt2.xml',I);

% SAVES THE NEW FRAME AS A JPG
imwrite(imresize(frame, [400 600]),strcat('frame.jpg'));

load databaseload.mat;

folder_label = (strcat('s',num2str(k)))

if exist(folder_label) ~= 7 %if the folder exists matlab returns 7
    mkdir(folder_label);
end

number_faces = 10;
counter_pos = 1;

if Face ~= -1
    fid = fopen('coordinates.txt', 'w');
    cd(folder_label);
    for i = 1:size(Face,1)
        Rectangle = [Face(i,1) Face(i,2); Face(i,1)+Face(i,3) Face(i,2); Face(i,1)+Face(i,3) Face(i,2)+Face(i,4); Face(i,1)  Face(i,2)+Face(i,4); Face(i,1) Face(i,2)];
        
        %Face detection validation check
        s1 = Rectangle(2,1)-Rectangle(1,1);
        s2 = Rectangle(4,2)-Rectangle(1,2);
        
        if((abs(s1)>200)&(abs(s1-s2)<350)&(ratio_check(s1,s2)<1.5)&(s1>100))
            
            %checking if the detection is outside the image resolution
            if (Rectangle(2,1) > size(frame,1))
                Rectangle(2,1) = size(frame,1);
            end
            if (Rectangle(4,2) > size(frame,2))
                Rectangle(4,2) = size(frame,2);
            end
            
            %if facedetect gives 0 then equal to 1 to meets matlab array structure
            if (Rectangle(1,1)==0)
                Rectangle(1,1) = 1;
            end
            if (Rectangle(2,1)==0)
                Rectangle(2,1) = 1;
            end
            if (Rectangle(1,2)==0)
                Rectangle(1,2) = 1;
            end
            if (Rectangle(4,2)==0)
                Rectangle(4,2) = 1;
            end
            
            face = frame(Rectangle(1,2):Rectangle(4,2),Rectangle(1,1):Rectangle(2,1));
            %           imshow(face);
            imwrite(imresize(face, [112 92]), strcat(num2str(e),'.pgm'));
            
            cd ..;
            imwrite(imresize(face, [200 200]),strcat(num2str(e),'.jpg'));
            fid = fopen(strcat(num2str(e),'.txt'), 'w');
            fwrite(fid, strcat('SHOT ',num2str(e)));
            fclose(fid);
            cd(folder_label);
            if e == 10
                e = 1;
                k = k+1;
                txtfile(folder_label);
                cd ..;
                save databaseload.mat e k
                stop(vid);
                load_database();
                clear;
                return;
            end
            e = e+1;
        end
    end
    cd ..;
    fid = fopen('variables.txt', 'w');
    fwrite(fid, strcat(num2str(number_faces),',',num2str(counter_pos)));
    fclose(fid);
    save databaseload.mat e k
end

clear

function out=ratio_check(s1,s2);
if s1<s2
    ratio = s1/s2;
else
    ratio = s2/s1;
end
clear s1 s2
out=ratio;

function txtfile(folder_label)
user_entry = input('Please enter name of the new entry: ', 's');
fid = fopen('ID.txt', 'w');
fwrite(fid, user_entry);
fclose(fid);
clear

function load_database();
% We load the database the first time we run the program.

persistent loaded;
persistent w;
if(isempty(loaded))
    k = database_size;
    v=zeros(10304,k*10);
    for i=1:k
        cd(strcat('s',num2str(i)));
        for j=1:10
            a=imread(strcat(num2str(j),'.pgm'));
            v(:,(i-1)*10+j)=reshape(a,size(a,1)*size(a,2),1);
        end
        cd ..
    end
    w=uint8(v); % Convert to unsigned 8 bit numbers to save memory.
end
loaded=1;  % Set 'loaded' to aviod loading the database again.
save w.mat w;
clear


function facerecog(I, Rectangle)
%% Face recognition
% This algorithm uses the eigenface system (based on pricipal component
% analysis - PCA) to recognize faces. For more information on this method
% refer to http://cnx.org/content/m12531/latest/

%% Download the face database
% You can find the database at the follwoing link,
% http://www.cl.cam.ac.uk/research/dtg/attarchive/facedatabase.html The
% database contains 400 pictures of 40 subjects. Download the zipped
% database and unzip it in the same directory as this file.

%% Loading the database into matrix v
%w=load_database();
load w.mat;
load face_counter.mat;

%% Initializations

persistent r;
r = zeros(10304);

%error check
if (Rectangle(2,1) > size(I,1))
    Rectangle(2,1) = size(I,1);
end
if (Rectangle(4,2) > size(I,2))
    Rectangle(4,2) = size(I,2);
end

if (Rectangle(1,1)==0)
    Rectangle(1,1) = 1;
end
if (Rectangle(2,1)==0)
    Rectangle(2,1) = 1;
end
if (Rectangle(1,2)==0)
    Rectangle(1,2) = 1;
end
if (Rectangle(4,2)==0)
    Rectangle(4,2) = 1;
end

face = I(Rectangle(1,2):Rectangle(4,2),Rectangle(1,1):Rectangle(2,1));
% SAVES THE DETECTED FACE AS A JPG
imwrite(imresize(face, [200 200]),strcat(num2str(number_face),'.jpg'));

imwrite(imresize(face, [112 92]), 'temp.pgm');
a=imread('temp.pgm');
r=reshape(a,size(a,1)*size(a,2),1);
r = uint8(r); % Convert to unsigned 8 bit numbers to save memory.

v = w;
clear w;

N=20;                               % Number of signatures used for each image.
%% Subtracting the mean from v
O=uint8(ones(1,size(v,2)));
m=uint8(mean(v,2));                 % m is the mean of all images.
vzm=v-uint8(single(m)*single(O));   % vzm is v with the mean removed.

%% Calculating eignevectors of the correlation matrix
% We are picking N of the 400 eigenfaces.
L=single(vzm)'*single(vzm);
[V,D]=eig(L);
V=single(vzm)*V;
V=V(:,end:-1:end-(N-1));            % Pick the eignevectors corresponding to the 10 largest eigenvalues.


%% Calculating the signature for each image
cv=zeros(size(v,2),N);
for i=1:size(v,2);
    cv(i,:)=single(vzm(:,i))'*V;    % Each row in cv is the signature for one image.
end


%% Recognition
%  Now, we run the algorithm and see if we can correctly recognize the face.
p=r-m;                              % Subtract the mean
s=single(p)'*V;
z=[];
for i=1:size(v,2)
    z=[z,norm(cv(i,:)-s,2)];
end

no_of_min = 3;
value_min = [];
[a,i]=min(z); %find the most closest one

for k=1:no_of_min
    [a,i]=min(z); %find the most closest one
    z(i) = max(z);
    value_min = [value_min i];
end

mu_min = mean(value_min);

fid2 = fopen(strcat(num2str(number_face),'.txt'), 'w');

if ((abs(value_min(1)-mu_min)<10) & (abs(value_min(2)-mu_min)<10) & (abs(value_min(3)-mu_min)<10))
    % SAVES THE RECOGNISED FACE AS A JPG
    imwrite(imresize((reshape(v(:,value_min(1)),112,92)), [200 200]),strcat('r',num2str(number_face),'.jpg'));
    cd(strcat('s',num2str(floor(value_min(1)/10)-1)));
    
    fid = fopen('ID.txt', 'r');
    str = fread(fid, '*char')';
    fclose(fid);
    cd ..;
    
    fwrite(fid2, str);
    fid3 = fopen('rec.txt', 'w');
    fwrite(fid3, 'false');
    fclose(fid3);

else
    fwrite(fid2, 'UNKNOWN');
    email(strcat(num2str(number_face),'.jpg'));
    fid3 = fopen('rec.txt', 'w');
    fwrite(fid3, 'true');
    fclose(fid3);
end

fclose(fid2);

if number_face == 10
    number_face = 0;
end
number_face = number_face + 1;
save face_counter.mat number_face
clear

function email(image);
% Define these variables appropriately:
mail = 'MAfacedetrec@gmail.com'; %Your GMail email address
password = 'intruder_MA'; %Your GMail password

% Then this code will set up the preferences properly:
setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);

% Required on some machines
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

% Send the email
sendmail('MAfacedetrec@gmail.com','Face Detection/Recognition System','INTRUDER DETECTED:', image)

function out=database_size;
load databaseload.mat;
db_size = k - 1;
clear k e
out=db_size;
