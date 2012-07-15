function varargout = FaceRecognitionTool(varargin)
% FACERECOGNITIONTOOL M-file for FaceRecognitionTool.fig
%      FACERECOGNITIONTOOL, by itself, creates a new FACERECOGNITIONTOOL or raises the existing
%      singleton*.
%
%      H = FACERECOGNITIONTOOL returns the handle to a new FACERECOGNITIONTOOL or the handle to
%      the existing singleton*.
%
%      FACERECOGNITIONTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FACERECOGNITIONTOOL.M with the given input arguments.
%
%      FACERECOGNITIONTOOL('Property','Value',...) creates a new FACERECOGNITIONTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FaceRecognitionTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FaceRecognitionTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FaceRecognitionTool

% 

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @FaceRecognitionTool_OpeningFcn, ...
    'gui_OutputFcn',  @FaceRecognitionTool_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before FaceRecognitionTool is made visible.
function FaceRecognitionTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FaceRecognitionTool (see VARARGIN)

% Choose default command line output for FaceRecognitionTool
set(handles.togglebutton3,'visible','off')
set(handles.togglebutton4,'visible','off');
set(handles.text3,'visible','off');
set(handles.edit2,'visible','off');
set(handles.text4,'visible','off');
axes(handles.axes4)
cla
axes(handles.axes3)
cla
handles.output = hObject;
% addpath(genpath([pwd '\']));
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FaceRecognitionTool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FaceRecognitionTool_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global A m1 n1 No_Files_In_Class_Folder Class_Count Training_Set_Folder

Training_Set_Folder = [uigetdir(''),'\'];
m1 = 6;
n1 = 3;
TS_Vector = dir(Training_Set_Folder);
No_Folders_In_Training_Set_Folder = length(TS_Vector);
File_Count = 1;
Class_Count = 1;
h = waitbar(0,'Reading Test Images,Please wait...');
for k = 3:No_Folders_In_Training_Set_Folder
    waitbar(k/(No_Folders_In_Training_Set_Folder-2))
    Class_Folder = [Training_Set_Folder '\' TS_Vector(k).name,'\'];
    CF_Tensor = dir(Class_Folder);
    No_Files_In_Class_Folder(Class_Count) = length(CF_Tensor)-2;
    %     strr = sprintf('Reading Test Images...!, # of Classes = %d, Now Reading %d ',No_Folders_In_Training_Set_Folder-2,Class_Count);
    %     set(handles.edit3,'String',strr);
    drawnow;
    for p = 3:No_Files_In_Class_Folder(Class_Count)+2
        Tmp_Image_Path = Class_Folder;
        Tmp_Image_Name = CF_Tensor(p).name;
        Tmp_Image_Path_Name = [Tmp_Image_Path,Tmp_Image_Name];
        if strcmp(Tmp_Image_Name,'Thumbs.db')
            break
        end
        test = imread(Tmp_Image_Path_Name);
        if length(size(test))==3
            Tmp_Image = rgb2gray(test);
        else
            Tmp_Image = test;
        end
        Tmp_Image_Down_Sampled = double(imresize(Tmp_Image,[m1 n1]));
        Image_Data_Matrix(:,File_Count) = Tmp_Image_Down_Sampled(:);
        File_Count = File_Count+1;
        
    end
    Class_Count = Class_Count+1;
    
end
close(h)
A = Image_Data_Matrix;
A = A/(diag(sqrt(diag(A'*A))));


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global A m1 n1 No_Files_In_Class_Folder Class_Count Training_Set_Folder
set(handles.togglebutton3,'visible','off')
set(handles.togglebutton4,'visible','off');
set(handles.text3,'visible','off');
set(handles.edit2,'visible','off');
set(handles.text4,'visible','off');
FullPath=uigetdir('');
IsTrue=0;
TotImg=0;
TestFiles=dir(FullPath);
for k=1:length(TestFiles)
    if ~strcmp(TestFiles(k,1).name(1),'.')
        Imgfiles=dir([FullPath '\' TestFiles(k).name]);
        for m=1:length(Imgfiles)
            if ~strcmp(Imgfiles(m,1).name(1),'.')
                axes(handles.axes3)
                Test_File = [FullPath '\' TestFiles(k,1).name '\' Imgfiles(m,1).name];
                set(handles.edit1,'string',[TestFiles(k,1).name '\' Imgfiles(m,1).name]);
                imshow(Test_File)
                drawnow;
                test = imread(Test_File);
                if length(size(test))==3
                    Test_Image = rgb2gray(test);
                else
                    Test_Image = test;
                end
                Test_Image_Down_Sampled = double(imresize(Test_Image,[m1 n1]));
                y = Test_Image_Down_Sampled(:);
                n = size(A,2);
                %                 cvx_quiet true
                %                 cvx_begin
                %                 variable x1(n)
                %                 minimize norm(x1,1)
                %                 subject to
                %                 A*x1 == y;
                %                 cvx_end
                % figure,plot(x1);
                f=ones(2*n,1);
                Aeq=[A -A];
                lb=zeros(2*n,1);
                x1 = linprog(f,[],[],Aeq,y,lb,[],[],[]);
                x1 = x1(1:n)-x1(n+1:2*n);
                nn = No_Files_In_Class_Folder;
                nn = cumsum(nn);
                tmp_var = 0;
                k1 = Class_Count-1;
                for i = 1:k1
                    delta_xi = zeros(length(x1),1);
                    if i == 1
                        delta_xi(1:nn(i)) = x1(1:nn(i));
                    else
                        tmp_var = tmp_var + nn(i-1);
                        begs = nn(i-1)+1;
                        ends = nn(i);
                        delta_xi(begs:ends) = x1(begs:ends);
                    end
                    tmp(i) = norm(y-A*delta_xi,2);
                    tmp1(i) = norm(delta_xi,1)/norm(x1,1);
                end
                TotImg=TotImg+1;
                Sparse_Conc_Index(TotImg) = (k1*max(tmp1)-1)/(k1-1);
                clss = find(tmp==min(tmp));
                % figure,plot(tmp)
                ssttrr = sprintf('The Test Image Corresponds to Class: %d',clss);
                cccc = dir([Training_Set_Folder]);
                Which_Folder = dir([Training_Set_Folder,cccc(clss+2).name,'\']);
                Which_Image = randsample(3:length(Which_Folder),1);
                Image_Path = [Training_Set_Folder,cccc(clss+2).name,'\',Which_Folder(Which_Image).name];
                Class_Image = (Image_Path);
                axes(handles.axes4);
                imshow(Class_Image)
                %                 title('Detected Image','Color','black','FontSize',25)
                
                set(handles.togglebutton3,'visible','on')
                set(handles.togglebutton4,'visible','on');
                set(handles.text3,'visible','on');
                
                                while 1
                                    pause(eps)
                                    if get(handles.togglebutton3,'value')==1
                                        IsTrue=IsTrue+1;
                                        set(handles.togglebutton3,'value',0)
                                        break;
                                    elseif get(handles.togglebutton4,'value')==1
                                        set(handles.togglebutton4,'value',0)
                                        break;
                                    end
                                end
                set(handles.togglebutton3,'visible','off')
                set(handles.togglebutton4,'visible','off');
                set(handles.text3,'visible','off');
                axes(handles.axes4)
                %                 cla
                
            end
        end
    end
end
eta = (IsTrue/TotImg)*100;
set(handles.edit2,'visible','on');
set(handles.text4,'visible','on');
set(handles.edit2,'String',[num2str(eta) '%']);
drawnow;
set(handles.togglebutton3,'visible','off')
set(handles.togglebutton4,'visible','off');
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global A m1 n1 No_Files_In_Class_Folder Class_Count Training_Set_Folder
set(handles.togglebutton3,'visible','off')
set(handles.togglebutton4,'visible','off');
set(handles.text3,'visible','off');
[Test_File Test_File_Path] = uigetfile('*.jpg;*.pgm;*.png;*.tif','Select a Test Image');
test_image_path = [Test_File_Path Test_File];
axes(handles.axes3)
cla
axes(handles.axes4)
cla
axes(handles.axes3)
imshow(test_image_path);
title('Test Image','Color','red','FontSize',15);
drawnow;
% set(handles.edit2,'string',test_image_path);
% set(handles.text5,'Visible','Off');
Test_File = [Test_File_Path Test_File];
test = imread(Test_File);
if length(size(test))==3
    Test_Image = rgb2gray(test);
else
    Test_Image = test;
end
Test_Image_Down_Sampled = double(imresize(Test_Image,[m1 n1]));
y = Test_Image_Down_Sampled(:);
n = size(A,2);
% fprintf('Processing .... \n')
% set(handles.edit3,'String','Processing ... !')
% drawnow;
% cvx_quiet true
% cvx_begin
% variable x1(n)
% minimize norm(x1,1)
% subject to
% A*x1 == y;
% cvx_end
% figure,plot(x1);
f=ones(2*n,1);
Aeq=[A -A];
lb=zeros(2*n,1);
x1 = linprog(f,[],[],Aeq,y,lb,[],[],[]);
x1 = x1(1:n)-x1(n+1:2*n);
nn = No_Files_In_Class_Folder;
nn = cumsum(nn);
tmp_var = 0;
k1 = Class_Count-1;
for i = 1:k1
    delta_xi = zeros(length(x1),1);
    if i == 1
        delta_xi(1:nn(i)) = x1(1:nn(i));
    else
        tmp_var = tmp_var + nn(i-1);
        begs = nn(i-1)+1;
        ends = nn(i);
        delta_xi(begs:ends) = x1(begs:ends);
    end
    tmp(i) = norm(y-A*delta_xi,2);
    tmp1(i) = norm(delta_xi,1)/norm(x1,1);
end
Sparse_Conc_Index = (k1*max(tmp1)-1)/(k1-1);
clss = find(tmp==min(tmp));
cccc = dir([Training_Set_Folder]);
Which_Folder = dir([Training_Set_Folder,cccc(clss+2).name,'\']);
Which_Image = randsample(3:length(Which_Folder),1);
Image_Path = [Training_Set_Folder,cccc(clss+2).name,'\',Which_Folder(Which_Image).name];
Class_Image = (Image_Path);
axes(handles.axes4);
imshow(Class_Image)
title('Detected Image','Color','black','FontSize',15)

% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton3
set(handles.togglebutton3,'value',1)

% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton4
set(handles.togglebutton4,'value',1);

function edit1_Callback(hObject, eventdata, handles)


function edit1_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% function pushbutton7_Callback(hObject, eventdata, handles)
% error('');


function edit2_Callback(hObject, eventdata, handles)


function edit2_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
