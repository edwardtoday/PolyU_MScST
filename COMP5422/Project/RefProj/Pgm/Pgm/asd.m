function varargout = asd(varargin)
% ASD M-file for asd.fig
%      ASD, by itself, creates a new ASD or raises the existing
%      singleton*.
%
%      H = ASD returns the handle to a new ASD or the handle to
%      the existing singleton*.
%
%      ASD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASD.M with the given input arguments.
%
%      ASD('Property','Value',...) creates a new ASD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before asd_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to asd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help asd

% Last Modified by GUIDE v2.5 01-Oct-2010 12:31:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @asd_OpeningFcn, ...
                   'gui_OutputFcn',  @asd_OutputFcn, ...
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


% --- Executes just before asd is made visible.
function asd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to asd (see VARARGIN)

% Choose default command line output for asd
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes asd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = asd_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName] = uigetfile('*.pgm','Select image ');
%if(PathName~=0)
%y= [PathName,FileName];
y=strcat(PathName,FileName);
img=imread(y);
%img=imread('C:\SUGEEV (H)\naveen project\Pgm\database\s1\1.pgm');
%a=img;
handles.img_path=y;
guidata(hObject, handles);

%handles.img_path=y;
axes(handles.axes1)
imshow(img)

% --- Executes on button press in clear.
% function clear_Callback(hObject, eventdata, handles)
% % hObject    handle to clear (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% y1=imread('G:\arjun\Pgm\newabc.png');
%  axes(handles.axes1)
%       imshow(y1);
% axes(handles.axes2)
%       imshow(y1);
%       axes(handles.axes3)
%       imshow(y1);
%       cd ..
%       cd ..
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 %axes(handles.axes1)
  %    imshow('G:\arjun\Pgm\newabc.png');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%handles.img_pat
%cd ..
%cd ..
x1=handles.img_path;
x=imread(x1);
[HLGPP_CRe, HLGPP_CIm, HGGPP_CRe, HGGPP_CIm] = HGPP_image(x);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  load image_database2;
  for i= 1:40
     HLGPP_R = hgpp(i).HLGPP_Re;
      HLGPP_I = hgpp(i).HLGPP_Im;
      HGGPP_R = hgpp(i).HGGPP_Re;
      HGGPP_I = hgpp(i).HGGPP_Im;
      [s(i)] = similarity_image(HLGPP_CRe, HLGPP_R, HLGPP_CIm, HLGPP_I, HGGPP_CRe, HGGPP_R, HGGPP_CIm, HGGPP_I);
      cd(strcat('D:\Pgm\Pgm\database\s',num2str(i)));
      %strcat('G:\arjun\Pgm\database\s',num2str(i)))
      c = imread('1.pgm');
      %axes(handles.axes2)
      axes(handles.axes2)
      imshow(c)
      set(handles.ab,'String',strcat('Processed now --->',num2str(i)))
      %myWait(100);
 cd ..
 cd ..
 myWait(1);
  end
  %cd ..
  %cd ..
  y = max(s(:));
  for i=1:40
   if s(i) == y
           cd(strcat('database\s',num2str(i)));
           c = imread('1.pgm');
         
  axes(handles.axes3)
  imshow(c)
   end
   end
% % 
cd ..
cd ..
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y1=imread('D:\Pgm\Pgm\newabc.png');
 axes(handles.axes1)
      imshow(y1);
axes(handles.axes2)
      imshow(y1);
      axes(handles.axes3)
      imshow(y1);
  set(handles.ab,'String','')    
      
% --- Executes on button press in pushbutton3.