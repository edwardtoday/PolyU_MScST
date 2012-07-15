function varargout = sphitmain(varargin)
% SPHITMAIN M-file for sphitmain.fig
%      SPHITMAIN, by itself, creates a new SPHITMAIN or raises the existing
%      singleton*.
%
%      H = SPHITMAIN returns the handle to a new SPHITMAIN or the handle to
%      the existing singleton*.
%
%      SPHITMAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPHITMAIN.M with the given input arguments.
%
%      SPHITMAIN('Property','Value',...) creates a new SPHITMAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sphitmain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sphitmain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sphitmain

% Last Modified by GUIDE v2.5 09-Jan-2010 23:55:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sphitmain_OpeningFcn, ...
                   'gui_OutputFcn',  @sphitmain_OutputFcn, ...
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


% --- Executes just before sphitmain is made visible.
function sphitmain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sphitmain (see VARARGIN)

% Choose default command line output for sphitmain
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sphitmain wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sphitmain_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function TInputImgSize_Callback(hObject, eventdata, handles)
% hObject    handle to TInputImgSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TInputImgSize as text
%        str2double(get(hObject,'String')) returns contents of TInputImgSize as a double


% --- Executes during object creation, after setting all properties.
function TInputImgSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TInputImgSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TEncodedImgSize_Callback(hObject, eventdata, handles)
% hObject    handle to TEncodedImgSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TEncodedImgSize as text
%        str2double(get(hObject,'String')) returns contents of TEncodedImgSize as a double


% --- Executes during object creation, after setting all properties.
function TEncodedImgSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TEncodedImgSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TCompressionRatio_Callback(hObject, eventdata, handles)
% hObject    handle to TCompressionRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TCompressionRatio as text
%        str2double(get(hObject,'String')) returns contents of TCompressionRatio as a double


% --- Executes during object creation, after setting all properties.
function TCompressionRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TCompressionRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TPSNR_Callback(hObject, eventdata, handles)
% hObject    handle to TPSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TPSNR as text
%        str2double(get(hObject,'String')) returns contents of TPSNR as a double


% --- Executes during object creation, after setting all properties.
function TPSNR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TPSNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TImgPath_Callback(hObject, eventdata, handles)
% hObject    handle to TImgPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TImgPath as text
%        str2double(get(hObject,'String')) returns contents of TImgPath as a double
%image_path = get(hObject, 'String');


% --- Executes during object creation, after setting all properties.
function TImgPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TImgPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TBitRate_Callback(hObject, eventdata, handles)
% hObject    handle to TBitRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TBitRate as text
%        str2double(get(hObject,'String')) returns contents of TBitRate as a double


% --- Executes during object creation, after setting all properties.
function TBitRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TBitRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BOK.
function BOK_Callback(hObject, eventdata, handles)
% hObject    handle to BOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%image_path  = get(handles.TImgPath, 'String');
image_path =handles.img_path;
rate    = get(handles.TBitRate, 'String');
%imview(image_path);
rate=str2double(rate);
Orig_I = double(imread(image_path));
OrigSize = size(Orig_I, 1);
max_bits = floor(rate * OrigSize^2);
OutSize = OrigSize;
image_spiht = zeros(size(Orig_I));
[nRow, nColumn] = size(Orig_I);
%Wavelet Decomposition
n = size(Orig_I,1);
n_log = log2(n); 
level = n_log;
type = 'bior4.4';
[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(type);

[I_W, S] = func_DWT(Orig_I, level, Lo_D, Hi_D);

%fprintf('%Encoding');
img_enc = func_SPIHT_Enc(I_W, max_bits, nRow*nColumn, level);
%Computing File name for the encoded Image

new_path = strcat('\', image_path);
path = new_path(find(new_path == '\', 1, 'last')+1:length(new_path));
enc_path1 = strcat('enc_', path);
    
imwrite(img_enc, enc_path1);
%fprintf('decoding');
%Decoding
img_dec = func_SPIHT_Dec(img_enc);

%Wavelet Reconstruction
img_spiht = func_InvDWT(img_dec, S, Lo_R, Hi_R, level);

%PSNR analysis
new_path = strcat('\', image_path);
path = new_path(find(new_path == '\', 1, 'last')+1:length(new_path));
enc_path = strcat('rec_', path);
    
imwrite(img_spiht,gray(256), enc_path);
%okkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
%fprintf('middle');
Q = 255;
MSE = sum(sum((img_spiht-Orig_I).^2))/nRow / nColumn;
PSNR_dB      = 10*log10(Q*Q/MSE);
%input file size
inp_fInfo    = imfinfo(image_path);
inp_fSize    = inp_fInfo.FileSize;

opt_fInfo    = imfinfo(enc_path1);
opt_fSize    = opt_fInfo.FileSize;
comprn_ratio = 100 - ((inp_fSize - opt_fSize)/inp_fSize)*100;
inp_fSize   = uint32(inp_fSize);
inp_SfSize  = int2str(inp_fSize); 
opt_fSize   = uint32(opt_fSize);
 opt_SfSize  = int2str(opt_fSize); 
%PSNRrnded   = uint8(PSNR);
SPSNRrnded  = num2str(PSNR_dB);
%comprn_ratio1=unit8(comprn_ratio);
cop          =num2str(comprn_ratio);
%fprintf('last');
set(handles.TInputImgSize, 'String', inp_SfSize);
set(handles.TEncodedImgSize, 'String', opt_SfSize);
set(handles.TCompressionRatio, 'String',cop );
set(handles.TPSNR, 'String', SPSNRrnded);
axes(handles.axes3)
imshow(enc_path)
% --- Executes on button press in pushbutton3elect_Image.
function pushbutton3elect_Image_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3elect_Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%[FileName,PathName] = uigetfile('*.bmp','Select any image to embed text files into it');
%if(PathName~=0)
%y= [PathName,FileName];
y='lena512.bmp';
img=imread(y);
%img;
handles.img_path=y;
guidata(hObject, handles);
%%%image show in first axes
axes(handles.axes1)
imshow(img)
%end


% --- Executes on button press in clear_Data.
function clear_Data_Callback(hObject, eventdata, handles)
% hObject    handle to clear_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.TBitRate, 'String',' ');
set(handles.TInputImgSize, 'String', ' ');
set(handles.TEncodedImgSize, 'String', ' ');
set(handles.TCompressionRatio, 'String',' ' );
set(handles.TPSNR, 'String','');