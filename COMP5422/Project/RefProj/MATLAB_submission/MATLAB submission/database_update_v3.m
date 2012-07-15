function database_update
obj = videoinput('winvideo', 1);
imaqmotion(obj);

function imaqmotion(obj)
try
    stop(obj);
    triggerconfig(obj, 'manual');
    set(obj, 'FramesAcquiredFcnCount', 1, ...
        'TimerFcn', @localFrameCallback, 'TimerPeriod', 0.1, 'ReturnedColorSpace', 'rgb');
    appdata.background = [];
    obj.UserData = appdata;
    start(obj);
    warning off imaq:peekdata:tooManyFramesRequested
catch
    error('MATLAB:imaqmotion:error', ...
        sprintf('IMAQMOTION is unable to run properly.\n%s', lasterr))
end
clear

function localFrameCallback(vid, event)
if ~isvalid(vid) || ~isrunning(vid)
    return;
end

appdata = get(vid, 'UserData');
background = appdata.background;

frame = peekdata(vid, 1);
if isempty(frame),
    return;
end
flushdata(vid);

if isempty(background),
    background = getsnapshot(vid);
end

localUpdateFig(vid, frame, background);
appdata.background = frame;
set(vid, 'UserData', appdata);
clear

function localUpdateFig(vid, frame, background)

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
            imshow(face);
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

function out=database_size;
load databaseload.mat;
db_size = k - 1;
clear k e
out=db_size;
