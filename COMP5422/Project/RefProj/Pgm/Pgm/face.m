function varargout = face(varargin)
% FACE M-file for face.fig
%      FACE, by itself, creates a new FACE or raises the existing
%      singleton*.
%
%      H = FACE returns the handle to a new FACE or the handle to
%      the existing singleton*.
%
%      FACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FACE.M with the given input arguments.
%
%      FACE('Property','Value',...) creates a new FACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before face_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to face_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help face

% Last Modified by GUIDE v2.5 01-Jan-2002 01:27:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @face_OpeningFcn, ...
                   'gui_OutputFcn',  @face_OutputFcn, ...
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


% --- Executes just before face is made visible.
function face_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to face (see VARARGIN)

% Choose default command line output for face
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes face wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = face_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in clear_data.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to clear_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[HLGPP_CRe, HLGPP_CIm, HGGPP_CRe, HGGPP_CIm] = HGPP_image(a);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load image_database2;
for i= 1:40
    %HLGPP_R = hgpp(i).HLGPP_Re;
    %HLGPP_I = hgpp(i).HLGPP_Im;
    %HGGPP_R = hgpp(i).HGGPP_Re;
    %HGGPP_I = hgpp(i).HGGPP_Im;
    %[s(i)] = similarity_image(HLGPP_CRe, HLGPP_R, HLGPP_CIm, HLGPP_I, HGGPP_CRe, HGGPP_R, HGGPP_CIm, HGGPP_I);
    cd(strcat('C:\SUGEEV (H)\naveen project\Pgm\database\s',num2str(i)));
    c = imread('1.pgm');
    %subplot(222)
    axes(handles.axes3)
    imshow(c);
    set(handles.image_number,'String',strcat('Processed now --->',num2str(i)))
    %title(strcat('Processed now --->',num2str(i)));
    %drawnow;
    %cd('C:\Users\user\Desktop\Face Recognition');    
    %cd ..
    %cd ..
end
%cd ..
%cd ..
% y = max(s(:));
%for i=1:44
%     if s(i) == y
%         cd(strcat('database\s',num2str(i)));
%         c = imread('1.pgm');
%         subplot(222)
%         imshow(c);
img=imread('C:\SUGEEV (H)\naveen project\Pgm\database\s1\1.pgm');
a=img;
axes(handles.axes4)
imshow(img)
%         title(strcat('Identified person --->',num2str(i)));
%     end
% end
% 




% --- Executes on button press in input_Image.
function input_Image_Callback(hObject, eventdata, handles)
% hObject    handle to input_Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%function y=add_image_Callback(hObject, eventdata, handles)
%[FileName,PathName] = uigetfile('*.pgm','Select any image ');
%if(PathName~=0)
%y= [PathName,FileName];
%img=imread(y);
img=imread('C:\SUGEEV (H)\naveen project\Pgm\database\s1\1.pgm');
a=img;
axes(handles.axes1)
imshow(img)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[HLGPP_CRe, HLGPP_CIm, HGGPP_CRe, HGGPP_CIm] = HGPP_image(a);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %load image_database2;
% for i= 1:40
%     %HLGPP_R = hgpp(i).HLGPP_Re;
%     %HLGPP_I = hgpp(i).HLGPP_Im;
%     %HGGPP_R = hgpp(i).HGGPP_Re;
%     %HGGPP_I = hgpp(i).HGGPP_Im;
%     %[s(i)] = similarity_image(HLGPP_CRe, HLGPP_R, HLGPP_CIm, HLGPP_I, HGGPP_CRe, HGGPP_R, HGGPP_CIm, HGGPP_I);
%     cd(strcat('C:\SUGEEV (H)\naveen project\Pgm\database\s',num2str(i)));
%     c = imread('1.pgm');
%     %subplot(222)
%     axes(handles.axes3)
%     imshow(c);
%     set(handles.image_number,'String',strcat('Processed now --->',num2str(i)))
%     %title(strcat('Processed now --->',num2str(i)));
%     %drawnow;
%     %cd('C:\Users\user\Desktop\Face Recognition');    
%     %cd ..
%     %cd ..
% end
% % y = max(s(:));
% % for i=1:44
% %     if s(i) == y
% %         cd(strcat('database\s',num2str(i)));
% %         c = imread('1.pgm');
% %         subplot(222)
% %         imshow(c);
% %         title(strcat('Identified person --->',num2str(i)));
% %     end
% % end
% % 


% --- Executes on button press in pushbutton3.


% --- Executes on button press in msdf.
function msdf_Callback(hObject, eventdata, handles)
% hObject    handle to msdf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%axes(handles.axes1)
%imshow('C:\SUGEEV (H)\naveen project\Pgm\database\s40\9.pgm');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% img=imread('C:\SUGEEV (H)\naveen project\Pgm\database\s1\1.pgm');
% a=img;
% axes(handles.axes3)
% imshow(img)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


a=[1 2 3]
