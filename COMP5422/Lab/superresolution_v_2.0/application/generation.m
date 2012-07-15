function varargout = generation(varargin)
% GENERATION - GUI for creating low resolution images from an input image
%    varargout = generation(varargin)
%    graphical user interface used to create a number of shifted and
%    rotated low resolution images from a single high resolution input
%    image

%% -----------------------------------------------------------------------
% SUPERRESOLUTION - Graphical User Interface for Super-Resolution Imaging
% Copyright (C) 2005-2007 Laboratory of Audiovisual Communications (LCAV), 
% Ecole Polytechnique Federale de Lausanne (EPFL), 
% CH-1015 Lausanne, Switzerland 
% 
% This program is free software; you can redistribute it and/or modify it 
% under the terms of the GNU General Public License as published by the 
% Free Software Foundation; either version 2 of the License, or (at your 
% option) any later version. This software is distributed in the hope that 
% it will be useful, but without any warranty; without even the implied 
% warranty of merchantability or fitness for a particular purpose. 
% See the GNU General Public License for more details 
% (enclosed in the file GPL). 
%
% Latest modifications: August, 2005, by Patrick Zbinden
%                       January 12, 2006, by Patrick Vandewalle
%                       November 6, 2006 by Karim Krichane

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @generation_OpeningFcn, ...
    'gui_OutputFcn',  @generation_OutputFcn, ...
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


% --- Executes just before generation is made visible.
function generation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to generation (see VARARGIN)

global PARAMSGIVEN;
global PARAMSGIVENBYUSER;
global DESTGIVEN;
global NAME;

NAME = [];
DESTGIVEN = false;
PARAMSGIVEN = false;
PARAMSGIVENBYUSER = {};

% Choose default command line output for generation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes generation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = generation_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate input images %
%%%%%%%%%%%%%%%%%%%%%%%%%

function generateInputImages(handles)
global INPUTIMAGE;
global PARAMSGIVEN;
global PARAMSGIVENBYUSER;
global DESTGIVEN;
global NAME;

im = INPUTIMAGE;

% multiply the image with a Tukey window to make it circularly symmetric
% and add zeros at the borders

autoSave = get(handles.autoSaveCheckbox,'Value');
tempPath = get(handles.text9,'String');

if (get(handles.checkbox1, 'Value') == 1)
    s_im=size(im);
    w1=window(@tukeywin,s_im(1),0.25);
    w2=window(@tukeywin,s_im(2),0.25)';
    w=w1*w2;
    if(size(im,3) == 3)
        % color image
        for i=1:3
            im2(:,:,i) = [zeros(32,s_im(2)+64); zeros(s_im(1),32) im(:,:,i).*w zeros(s_im(1),32); zeros(32,s_im(2)+64)];
        end
        im = im2;
    else
        % black image
        im = [zeros(32,s_im(2)+64); zeros(s_im(1),32) im.*w zeros(s_im(1),32); zeros(32,s_im(2)+64)];
    end
    clear w w1 w2;
end

% set shift and rotation parameters to fixed numbers
strings = get(handles.popupmenu1,'String');
selected = str2double(strings{get(handles.popupmenu1,'Value')});
if (PARAMSGIVEN == true)
    delta = [PARAMSGIVENBYUSER{2} PARAMSGIVENBYUSER{3}];
    phi = PARAMSGIVENBYUSER{1};
else
    delta = rand(selected,2);    %[0 0; 3.125 -1.875; 0.875 2.25; -1.5 0.5];
    phi = rand(1,selected);      %[0 5 -3 2];
end

% construct the low resolution shifted and rotated images from the original
% image

IMAGESCREATED = false;

if(size(im,3) == 3)
    % color image
    for i=1:3
        [s{i}, im_target] = create_images(im(:,:,i),delta,phi,4,selected);
    end
    close;

    for i=1:selected
        for j=1:3
            titi(:,:,j) =  s{j}{i};
        end
        % Save images in files if corresponding option is checked
        if (autoSave)
            imageName = [NAME '_LR_' num2str(i) '.tif'];
            if(DESTGIVEN)
                imwrite(titi, [tempPath '/' imageName]);
                CIPATH = tempPath;
                CINAMES{i} = imageName;
                IMAGESCREATED = true;
            else
                imwrite(titi, imageName);
                CIPATH = pwd;
                CINAMES{i} = imageName;
                IMAGESCREATED = true;
            end
        else
            figure;
            imshow(titi);
        end
    end
else
    % black image
    [s, im_target] = create_images(im,delta,phi,4,selected);
    close;
    for i=1:selected
        if (autoSave)
            imageName = [NAME '_LR_' num2str(i) '.tif'];
            if(DESTGIVEN)
                imwrite(s{i}, [tempPath '/' imageName]);
                CIPATH = tempPath;
                CINAMES{i} = imageName;
                IMAGESCREATED = true;
            else
                imwrite(s{i}, imageName);
                CIPATH = pwd;
                CINAMES{i} = imageName;
                IMAGESCREATED = true;
            end
        else
            figure;
            imshow(s{i});
        end
    end
end

if IMAGESCREATED
    save CIPATH;
    save CINAMES;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter the motion parameters %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function parametersGivenByUser = enterParameters(handles, imagesNumber)
global PARAMSGIVEN;
parametersGivenByUser = {};
tempTest = true;
tempRotations = {};
tempTranslationx = {};
tempTranslationy = {};
canceled = false;
% getting the rotation parameters
for i=1:imagesNumber
    prompt(i) = {strcat('Rotation image', int2str(i))};
end
title = 'Please, enter the rotation parameters';
lines = 1;
tempRotations = inputdlg(prompt,title,lines);
% test rotation parameters
if size(tempRotations,1) > 0
    for i=1:size(tempRotations,1)
        if(size(tempRotations{i},1) == 0 | str2num(tempRotations{i}) > 10 | str2num(tempRotations{i}) < -10)
            tempTest = false;
        end
    end
    if(tempTest)
        parametersGivenByUser{1} = tempRotations;
    end
else
    tempTest = false;
    canceled = true;
end

% getting the x translation parameters
if(tempTest)
    for i=1:imagesNumber
        prompt(i) = {strcat('Translation x of image', int2str(i))};
    end
    title = 'Please, enter the translation x parameters';
    lines = 1;
    tempTranslationx = inputdlg(prompt,title,lines);
    % test rotation parameters
    if size(tempTranslationx,1) > 0
        for i=1:size(tempTranslationx,1)
            if(size(tempTranslationx{i},1) == 0 | str2num(tempTranslationx{i}) > 10 | str2num(tempTranslationx{i}) < -10)
                tempTest = false;
            end
        end
        if(tempTest)
            parametersGivenByUser{2} = tempTranslationx;
        end
    else
        tempTest = false;
        canceled = true;
    end
end

% getting the y translation parameters
if(tempTest)
    for i=1:imagesNumber
        prompt(i) = {strcat('Translation y of image', int2str(i))};
    end
    title = 'Please, enter the translation y parameters';
    lines = 1;
    tempTranslationy = inputdlg(prompt,title,lines);
    % test translation y parameters
    if size(tempTranslationy,1) > 0
        for i=1:size(tempTranslationy,1)
            if(size(tempTranslationy{i},1) == 0 | str2num(tempTranslationy{i}) > 10 | str2num(tempTranslationy{i}) < -10)
                tempTest = false;
            end
        end
        if(tempTest)
            parametersGivenByUser{3} = tempTranslationy;
        end
    else
        tempTest = false;
        canceled = true;
    end
end

if(tempTest)
    set(handles.listbox3, 'String', parametersGivenByUser{1});
    set(handles.listbox1, 'String', parametersGivenByUser{2});
    set(handles.listbox2, 'String', parametersGivenByUser{3});
    for i=1:imagesNumber
        phi(i) = str2num(parametersGivenByUser{1}{i});
        deltax(i,1) = str2num(parametersGivenByUser{2}{i});
        deltay(i,1) = str2num(parametersGivenByUser{3}{i});
    end
    parametersGivenByUser{1} = phi;
    parametersGivenByUser{2} = deltax;
    parametersGivenByUser{3} = deltay;
    parametersGivenByUser;
    PARAMSGIVEN = true;
else
    if (size(tempRotations,1) > 0 & (canceled == false))
        errordlg('One parameter in not correct');
        parametersGivenByUser = {};
    end
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
generateInputImages(handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume();
close;


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PARAMSGIVENBYUSER;
strings = get(handles.popupmenu1,'String');
selected = str2double(strings{get(handles.popupmenu1,'Value')});
PARAMSGIVENBYUSER = enterParameters(handles, selected);


% Random radio
% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
set(handles.text6, 'Enable', 'on');
set(handles.text3, 'Enable', 'off');
set(handles.text5, 'Enable', 'off');
set(handles.text4, 'Enable', 'off');
set(handles.listbox3, 'Enable', 'off');
set(handles.listbox2, 'Enable', 'off');
set(handles.listbox1, 'Enable', 'off');
set(handles.pushbutton3, 'Enable', 'off');



% Perdonal radio
% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
set(handles.text6, 'Enable', 'off');
set(handles.text3, 'Enable', 'on');
set(handles.text5, 'Enable', 'on');
set(handles.text4, 'Enable', 'on');
set(handles.listbox3, 'Enable', 'on');
set(handles.listbox2, 'Enable', 'on');
set(handles.listbox1, 'Enable', 'on');
set(handles.pushbutton3, 'Enable', 'on');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% read image from file
global INPUTIMAGE;
global NAME;

[fileName,pathName] = uigetfile({'*.tif'; '*.jpg'; '*.bmp'}, 'Choose the source image');
NAME = fileName(1:end-4);
if(size(fileName,2)>3)
    im = double(imread(strcat(pathName, fileName)));
    info = imfinfo([pathName fileName]);
    im = double(im)/(2^(info.BitDepth/size(im, 3)));
    INPUTIMAGE = im;
    set(handles.text8, 'String', [pathName fileName]);
    set(handles.radiobutton2, 'Enable', 'on');
    set(handles.radiobutton1, 'Enable', 'on');
    set(handles.text6, 'Enable', 'on');
    set(handles.pushbutton1, 'Enable', 'on');
else
    set(handles.text8, 'String', 'No image');
    set(handles.radiobutton2, 'Enable', 'off');
    set(handles.radiobutton1, 'Enable', 'off');
    set(handles.text6, 'Enable', 'off');
    set(handles.pushbutton1, 'Enable', 'off');
end



% --- Executes on button press in autoSaveCheckbox.
function autoSaveCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to autoSaveCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of autoSaveCheckbox




% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DESTGIVEN;
dest_temp = uigetdir('Choose the destination directory');
if length(dest_temp)>2
    set(handles.text9, 'String', dest_temp);
    DESTGIVEN = true;
end
