function varargout = newface(varargin)
% NEWFACE M-file for newface.fig
%      NEWFACE, by itself, creates a new NEWFACE or raises the existing
%      singleton*.
%
%      H = NEWFACE returns the handle to a new NEWFACE or the handle to
%      the existing singleton*.
%
%      NEWFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEWFACE.M with the given input arguments.
%
%      NEWFACE('Property','Value',...) creates a new NEWFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before newface_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to newface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help newface

% Last Modified by GUIDE v2.5 01-Oct-2010 12:19:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @newface_OpeningFcn, ...
                   'gui_OutputFcn',  @newface_OutputFcn, ...
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


% --- Executes just before newface is made visible.
function newface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to newface (see VARARGIN)

% Choose default command line output for newface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes newface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = newface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in input.
function input_Callback(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.pgm','Select any image ');
if(PathName~=0)
y= [PathName,FileName];
img=imread(y);
%img=imread('C:\SUGEEV (H)\naveen project\Pgm\database\s1\1.pgm');
%a=img;
axes(handles.axes1)
imshow(img)
% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in processing.
function processing_Callback(hObject, eventdata, handles)
% hObject    handle to processing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


