function [varargout,contents_box]= make(varargin)


% MAKE M-file for make.fig
%      MAKE, by itself, creates a new MAKE or raises the existing
%      singleton*.
%
%      H = MAKE returns the handle to a new MAKE or the handle to
%      the existing singleton*.
%
%      MAKE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAKE.M with the given input arguments.
%
%      MAKE('Property','Value',...) creates a new MAKE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before make_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to make_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help make 

% Last Modified by GUIDE v2.5 16-Oct-2006 22:21:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @make_OpeningFcn, ...
                   'gui_OutputFcn',  @make_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before make is made visible.
function make_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to make (see VARARGIN)

% Choose default command line output for make
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes make wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%-----------------------------------------------------------------------

% --- Outputs from this function are returned to the command line.
function varargout = make_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%-----------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
%-----------------------------------------------------------------------
% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
if strcmp(get(handles.figure1,'SelectionType'),'open')
index_selected = get(handles.listbox1,'Value');
contents = get(hObject,'String');
sys=[];
for i=1:length(contents)
    if(i~=index_selected)
    sys=[sys;contents(i)];
    end
end
sorted_index=1:length(sys);
handles.file_names = sys;
handles.sorted_index = [sorted_index];
guidata(handles.figure1,handles)
set(handles.listbox1,'String',handles.file_names,...
	'Value',1)
contents = get(handles.listbox1,'String');
total_char_possible=text_length_num(contents)*7;
set(handles.text_a,'String',total_char_possible)
end
%-----------------------------------------------------------------------
% --- Executes on button press in add_file.
function add_file_Callback(hObject, eventdata, handles)

[FileName,PathName]=uigetfile( ...
{'*.m;*.txt','MATLAB Files (*.m,*.txt)';
'*.*', 'All Files (*.*)'}, 'Choose a File');
if(PathName~=0)
y= [PathName,FileName];
path_cell={y};
contents = get(handles.listbox1,'String');
contents_char=[char(path_cell) '-->' text_length_char(path_cell)];
path_cell={contents_char};
full_list=[path_cell;contents];
total_char_possible=text_length_num(full_list)*7;
set(handles.text_a,'String',total_char_possible/7)
handles.file_names=full_list;
set(handles.listbox1,'String',handles.file_names,...
	'Value',1)
end
%-----------------------------------------------------------------------
% --- Executes on button press in hide.
function hide_Callback(hObject, eventdata, handles)
contents = get(handles.listbox1,'String');
coded_matrix=hide_operation(handles.img_path,contents);
axes(handles.axes2)
imshow(coded_matrix)

[FileName,PathName] = uiputfile('*.bmp','Save the embedded bitmap image');
FileName=[FileName '.bmp'];
y2=[PathName,FileName];
imwrite(coded_matrix,y2);
%-----------------------------------------------------------------------
% --- Executes on button press in add_image.
function y=add_image_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.bmp','Select any image to embed text files into it');
if(PathName~=0)
y= [PathName,FileName];
img=imread(y);
[m n r]=size(img);
set(handles.text_b,'String',floor((m*n*r-7)/7))
handles.img_path=y;
guidata(hObject, handles);

axes(handles.axes1)
imshow(img)
end
%-----------------------------------------------------------------------
% --- Executes on button press in getback.
function getback_Callback(hObject, eventdata, handles)

getbackfiles
%-----------------------------------------------------------------------
% --- Executes when figure1 window is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)



