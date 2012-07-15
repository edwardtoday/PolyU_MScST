% SUPERRESOLUTION - Graphical User Interface for Super-Resolution Imaging
% This program allows a user to perform registration of a set of low 
% resolution input images and reconstruct a high resolution image from them.
% Multiple image registration and reconstruction methods have been
% implemented. As input, the user can either select existing images, or 
% generate a set of simulated low resolution images from a high resolution 
% image. 
% More information is available online:
% http://lcavwww.epfl.ch/software/superresolution

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
%                       September 26, 2006, by Karim Krichane

function varargout = superresolution(varargin)

% Begin GUIinitialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @superresolution_OpeningFcn, ...
    'gui_OutputFcn',  @superresolution_OutputFcn, ...
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

%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

% --- Executes just before superresolution is made visible.
function superresolution_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to superresolution (see VARARGIN)

% Global variables of the program
global IMAGESNUMBER; % number of input images
global IMAGESDATA; % name and path of the images
global IMAGESSTRING; % list of images names for the list of images
global IMAGES; % input images
global IMAGESINFO; % informations about the images, like the bit depth, etc...
global PARAMETERSWILLBEGIVEN; % true if the user wants to give the parameters
global ISPARAMETERSGIVENBYUSER; % true if the user has chosen parameters
global PARAMETERSGIVENBYUSER; % parameters given by the user
global TEMPRESULT;
global DESTGIVEN2;
global CLEARLIST;
global IMAGESCREATED;
global CIPATH;
global CINAMES;
global MAINHANDLES;

MAINHANDLES = handles;
CIPATH = [];
CINAMES = {};
IMAGESCREATED = false;
CLEARLIST = false;
DESTGIVEN2 = false;
IMAGESNUMBER = 0;
IMAGESDATA = [];
IMAGESSTRING = {};
IMAGES = {};
IMAGESINFO = {};
PARAMETERSWILLBEGIVEN = false;
ISPARAMETERSGIVENBYUSER = false;
PARAMETERSGIVENBYUSER = {};
TEMPRESULT = [];


% Initialize imagePreview
axes(handles.imagePreview);
set(handles.imagePreview,'Visible', 'off');


% Choose default command line output for superresolution
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Display EPFL logo on the bottom right of the UI
axes(handles.logo_axes);
imshow('logo_epfl_small.tif');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add a new image and save its informations %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function addImageFile(handles)
global IMAGESNUMBER;
global IMAGESDATA;
global IMAGESSTRING;
global PARAMETERSWILLBEGIVEN;
global ISPARAMETERSGIVENBYUSER;
global PARAMETERSGIVENBYUSER;
global CLEARLIST;
% get the image
[fnameMult, pname] = uigetfile('*.tif', 'Choose an image',  'MultiSelect', 'on');
if iscell(fnameMult)
    nbr = size(fnameMult,2);
elseif isnumeric(fnameMult)
    if fnameMult == 0
        nbr = 0;
    end
elseif isstr(fnameMult)
    nbr = 1;
    fnameMult = {fnameMult};
end

if CLEARLIST
    IMAGESDATA = {};
    IMAGESSTRING = {};
    CLEARLIST = false;
end

if nbr > 0
    set(handles.listImages, 'FontAngle', 'normal');
    for i = 1:nbr
        fname = fnameMult{1,i};
        % activation of the list
        set(handles.listImages, 'Max', 1);
        set(handles.listImages, 'Enable', 'on');
        set(handles.listImages, 'Value', 1);
        % save the informations
        IMAGESNUMBER = IMAGESNUMBER + 1;
        IMAGESDATA(IMAGESNUMBER).name = fname;
        IMAGESDATA(IMAGESNUMBER).path = pname;
        IMAGESSTRING{IMAGESNUMBER} = fname;
        set(handles.listImages, 'String', IMAGESSTRING);
        % activate the selection of the image if it is the first image
        if IMAGESNUMBER == 1
            selectImage(handles, fname, pname);
        end
        % earase parameters
        removeParameters(handles);
        % activate the button for removing images
        set(handles.removeButton, 'Enable', 'on');
        set(handles.removeAllButton, 'Enable', 'on');
        set(handles.removeMenu, 'Enable', 'on');
        set(handles.removeAllMenu, 'Enable', 'on');
        % activate the other buttons if enough images
        if IMAGESNUMBER >= 1
            set(handles.radiobutton1, 'Enable', 'on');
            set(handles.radiobutton2, 'Enable', 'on');
            set(handles.popupmenu2, 'Enable', 'on');
            set(handles.radiobutton6, 'Enable', 'on');
            set(handles.radiobutton7, 'Enable', 'on');
            set(handles.checkbox1, 'Enable', 'on');
            set(handles.radio_rec_full, 'Enable', 'on');
            set(handles.radio_rec_part, 'Enable', 'on');
            if get(handles.radio_rec_part, 'Value')
                set(handles.text_rec_part, 'Enable', 'on');
            end
            set(handles.saveHR_checkbox, 'Enable', 'on');
            set(handles.saveInCurrentDir_radiobutton, 'Enable', 'on');
            set(handles.radiobutton9, 'Enable', 'on');
            if get(handles.radiobutton9, 'Value')
                set(handles.text14, 'Enable', 'on');
                set(handles.chooseDest_pushbutton, 'Enable', 'on');
            end
            if(PARAMETERSWILLBEGIVEN)
                set(handles.popupmenu1, 'Enable', 'off');
                if(ISPARAMETERSGIVENBYUSER)
                    set(handles.removeparameters, 'Enable', 'on');
                    set(handles.resultButton, 'Enable', 'on');
                    set(handles.resultMenu, 'Enable', 'on');
                else
                    set(handles.enterparameters, 'Enable', 'on');
                    set(handles.resultButton, 'Enable', 'off');
                    set(handles.resultMenu, 'Enable', 'off');
                end
            else
                set(handles.popupmenu1, 'Enable', 'on');
                set(handles.resultButton, 'Enable', 'on');
                set(handles.resultMenu, 'Enable', 'on');
            end
        end
    end
end






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add the created images to the list        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function addCreatedImages(handles)
global IMAGESNUMBER;
global IMAGESDATA;
global IMAGESSTRING;
global PARAMETERSWILLBEGIVEN;
global ISPARAMETERSGIVENBYUSER;
global PARAMETERSGIVENBYUSER;
global CLEARLIST;
global MAINHANDLES;

handles = MAINHANDLES;
load CINAMES;
load CIPATH;
% get the image
fnameMult = CINAMES;
pname = CIPATH;

if iscell(fnameMult)
    nbr = size(fnameMult,2);
elseif isnumeric(fnameMult)
    if fnameMult == 0
        nbr = 0;
    end
elseif isstr(fnameMult)
    nbr = 1;
    fnameMult = {fnameMult};
end

removeAllImages(handles);
IMAGESDATA = {};
IMAGESSTRING = {};
CLEARLIST = false;

handles = MAINHANDLES;

if nbr > 0
    set(handles.listImages, 'FontAngle', 'normal');
    for i = 1:nbr
        fname = fnameMult{1,i};
        % activation of the list
        set(handles.listImages, 'Max', 1);
        set(handles.listImages, 'Enable', 'on');
        set(handles.listImages, 'Value', 1);
        % save the informations
        IMAGESNUMBER = IMAGESNUMBER + 1;
        IMAGESDATA(IMAGESNUMBER).name = fname;
        IMAGESDATA(IMAGESNUMBER).path = pname;
        IMAGESSTRING{IMAGESNUMBER} = fname;
        set(handles.listImages, 'String', IMAGESSTRING);
        % activate the selection of the image if it is the first image
        if IMAGESNUMBER == 1
            selectImage(handles, fname, pname);
        end
        % earase parameters
        removeParameters(handles);
        % activate the button for removing images
        set(handles.removeButton, 'Enable', 'on');
        set(handles.removeAllButton, 'Enable', 'on');
        set(handles.removeMenu, 'Enable', 'on');
        set(handles.removeAllMenu, 'Enable', 'on');
        % activate the other buttons if enough images
        if IMAGESNUMBER >= 1
            set(handles.radiobutton1, 'Enable', 'on');
            set(handles.radiobutton2, 'Enable', 'on');
            set(handles.popupmenu2, 'Enable', 'on');
            set(handles.radiobutton6, 'Enable', 'on');
            set(handles.radiobutton7, 'Enable', 'on');
            set(handles.checkbox1, 'Enable', 'on');
            set(handles.radio_rec_full, 'Enable', 'on');
            set(handles.radio_rec_part, 'Enable', 'on');
            if get(handles.radio_rec_part, 'Value')
                set(handles.text_rec_part, 'Enable', 'on');
            end
            set(handles.saveHR_checkbox, 'Enable', 'on');
            set(handles.saveInCurrentDir_radiobutton, 'Enable', 'on');
            set(handles.radiobutton9, 'Enable', 'on');
            if get(handles.radiobutton9, 'Value')
                set(handles.text14, 'Enable', 'on');
                set(handles.chooseDest_pushbutton, 'Enable', 'on');
            end
            if(PARAMETERSWILLBEGIVEN)
                set(handles.popupmenu1, 'Enable', 'off');
                if(ISPARAMETERSGIVENBYUSER)
                    set(handles.removeparameters, 'Enable', 'on');
                    set(handles.resultButton, 'Enable', 'on');
                    set(handles.resultMenu, 'Enable', 'on');
                else
                    set(handles.enterparameters, 'Enable', 'on');
                    set(handles.resultButton, 'Enable', 'off');
                    set(handles.resultMenu, 'Enable', 'off');
                end
            else
                set(handles.popupmenu1, 'Enable', 'on');
                set(handles.resultButton, 'Enable', 'on');
                set(handles.resultMenu, 'Enable', 'on');
            end
        end
    end
end






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove an image and its informations %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function removeImageFile(handles, toRemove)
global IMAGESNUMBER;
global IMAGESDATA;
global IMAGESSTRING;
global DESTGIVEN2;
global CLEARLIST;

% earase parameters
removeParameters(handles);

% remove the image from the data list
IMAGESDATA(:,toRemove) = [];

% remove the image from the string list
charString = char(IMAGESSTRING);
charString(toRemove,:) = [];
IMAGESSTRING = cellstr(charString);

IMAGESNUMBER = IMAGESNUMBER - 1;

% activate the selection of the nearest image
if IMAGESNUMBER >= 1
    if toRemove >= IMAGESNUMBER
        toDisplay = IMAGESNUMBER;
    else
        toDisplay = toRemove;
    end
    set(handles.listImages, 'Value', toDisplay);
    set(handles.listImages, 'String', IMAGESSTRING);
    fname = IMAGESDATA(toDisplay).name;
    pname = IMAGESDATA(toDisplay).path;
    selectImage(handles, fname, pname);
else
    
    set(handles.listImages, 'Max', 2);
    IMAGESSTRING = {'Press the "Add" button to', 'add images', '', 'OR', '',...
                'Press the "Create LR images', 'from a HR image" button to',...
                'create your own set of Low', 'Resolution images from a given',...
                'High Resolution image'};
    set(handles.listImages, 'String', IMAGESSTRING);
    set(handles.listImages, 'Value', [4]);
    set(handles.listImages, 'Enable', 'inactive');
    CLEARLIST = true;
    IMAGESNUMBER = 0;
    IMAGESDATA = [];
    IMAGES = [];
    removeParameters(handles);
    set(handles.imageName, 'String', '');
    set(handles.imageSize, 'String', '');
    % displayImage;
    axes(handles.imagePreview);
    image([]);
    set(handles.imagePreview,'Visible', 'off');
    set(handles.resultButton, 'Enable', 'off');
    set(handles.resultMenu, 'Enable', 'off');
    set(handles.enterparameters, 'Enable', 'off');
    set(handles.removeparameters, 'Enable', 'off');
    set(handles.popupmenu1, 'Enable', 'off');
    set(handles.radiobutton1, 'Enable', 'off');
    set(handles.radiobutton2, 'Enable', 'off');
    set(handles.popupmenu2, 'Enable', 'off');
    set(handles.radiobutton6, 'Enable', 'off');
    set(handles.radiobutton7, 'Enable', 'off');
    set(handles.checkbox1, 'Enable', 'off');
    set(handles.radio_rec_full, 'Enable', 'off');
    set(handles.radio_rec_part, 'Enable', 'off');
    set(handles.text_rec_part, 'Enable', 'off');
    set(handles.saveHR_checkbox, 'Enable', 'off');
    set(handles.saveInCurrentDir_radiobutton, 'Enable', 'off');
    set(handles.radiobutton9, 'Enable', 'off');
    set(handles.text14, 'Enable', 'off');
    set(handles.chooseDest_pushbutton, 'Enable', 'off');
    set(handles.removeButton, 'Enable', 'off');
    set(handles.removeAllButton, 'Enable', 'off');
    set(handles.removeMenu, 'Enable', 'off');
    set(handles.removeAllMenu, 'Enable', 'off');
    set(handles.zoomPreview, 'Enable', 'off');
    set(handles.listImages, 'FontAngle', 'italic');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove all images and their informations %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function removeAllImages(handles)
global IMAGESNUMBER;
global IMAGESDATA;
global IMAGESSTRING;
global IMAGES;
global CLEARLIST;
global MAINHANDLES;

CLEARLIST = true;
IMAGESNUMBER = 0;
IMAGESDATA = [];
IMAGESSTRING = {'Press the "Add" button to', 'add images', '', 'OR', '',...
                'Press the "Create LR images', 'from a HR image" button to',...
                'create your own set of Low', 'Resolution images from a given',...
                'High Resolution image'};
IMAGES = [];
removeParameters(handles);

handles = MAINHANDLES;

set(handles.listImages, 'FontAngle', 'italic');
set(handles.resultButton, 'Enable', 'off');
set(handles.resultMenu, 'Enable', 'off');
set(handles.listImages, 'Max', 2);
set(handles.listImages, 'Value', [4]);
set(handles.listImages, 'String', IMAGESSTRING);
set(handles.listImages, 'Enable', 'inactive');
set(handles.imageName, 'String', '');
set(handles.imageSize, 'String', '');
axes(handles.imagePreview);
image([]);
set(handles.imagePreview,'Visible', 'off');
set(handles.removeButton, 'Enable', 'off');
set(handles.removeAllButton, 'Enable', 'off');
set(handles.removeMenu, 'Enable', 'off');
set(handles.enterparameters, 'Enable', 'off');
set(handles.removeparameters, 'Enable', 'off');
set(handles.radiobutton1, 'Enable', 'off');
set(handles.radiobutton2, 'Enable', 'off');
set(handles.popupmenu2, 'Enable', 'off');
set(handles.zoomPreview, 'Enable', 'off');
set(handles.radiobutton6, 'Enable', 'off');
set(handles.radiobutton7, 'Enable', 'off');
set(handles.checkbox1, 'Enable', 'off');
set(handles.radio_rec_full, 'Enable', 'off');
set(handles.radio_rec_part, 'Enable', 'off');
set(handles.text_rec_part, 'Enable', 'off');
set(handles.saveHR_checkbox, 'Enable', 'off');
set(handles.saveInCurrentDir_radiobutton, 'Enable', 'off');
set(handles.radiobutton9, 'Enable', 'off');
set(handles.text14, 'Enable', 'off');
set(handles.chooseDest_pushbutton, 'Enable', 'off');

MAINHANDLES = handles;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display an image in an axe %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function displayImage(handles, filePath, destination)
handles.imSource = imread(filePath);
axes(destination);
imshow(handles.imSource);
set(destination,'Visible', 'off');
set(handles.zoomPreview, 'Enable', 'on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check that the images are correct %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function test = testImages(handles)
global IMAGESNUMBER;
global IMAGESDATA;
global IMAGES;
global IMAGESINFO;
global IMAGESSTRING;

test = true;
IMAGES = {};
IMAGESINFO = {};
IMAGES{1} = imread([IMAGESDATA(1).path '/' IMAGESDATA(1).name]);
IMAGESINFO{1} = imfinfo([IMAGESDATA(1).path '/' IMAGESDATA(1).name]);
for i=2:IMAGESNUMBER
    tempImage = imread([IMAGESDATA(i).path '/' IMAGESDATA(i).name]);
    tempInfo = imfinfo([IMAGESDATA(i).path '/' IMAGESDATA(i).name]);
    if not(size(IMAGES{1}) == size(tempImage))
        errordlg(['Image ' IMAGESSTRING{i} ' has not the same size as image ' IMAGESSTRING{1}], 'Size error');
        test = false;
        break;
    elseif not(IMAGESINFO{1}.BitDepth == tempInfo.BitDepth)
        errordlg(['Image ' IMAGESSTRING{i} ' is not the same type as image ' IMAGESSTRING{1}], 'Size error');
        test = false;
        break;
    else
        IMAGES{i} = tempImage;
        IMAGESINFO{i} = tempInfo;
    end
end
test;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Select an image by clicking on it %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function selectImage(handles, fname, pname)
displayImage(handles, [pname filesep fname], handles.imagePreview);
set(handles.imageName, 'String', fname);
info = imfinfo([pname filesep fname]);
set(handles.imageSize, 'String', [num2str(info.Width) ' x ' num2str(info.Height)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enter the motion parameters %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function enterParameters(handles)
global IMAGESNUMBER;
global ISPARAMETERSGIVENBYUSER
global PARAMETERSGIVENBYUSER
tempTest = true;
tempRotations = {};
tempTranslationx = {};
tempTranslationy = {};
canceled = false;
try
    % getting the rotation parameters
    for i=1:IMAGESNUMBER
        prompt(i) = {strcat('Rotation image', int2str(i))};
    end
    title = 'Please, enter the rotation parameters';
    lines = 1;
    tempRotations = inputdlg(prompt,title,lines);
    % test rotation parameters
    if size(tempRotations,1) > 0
        for i=1:size(tempRotations,1)
            if(size(tempRotations{i},1) == 0 || str2num(tempRotations{i}) > 10 || str2num(tempRotations{i}) < -10)
                tempTest = false;
            end
        end
        if(tempTest)
            PARAMETERSGIVENBYUSER{1} = tempRotations;
        end
    else
        tempTest = false;
        canceled = true;
    end

    % getting the x translation parameters
    if(tempTest)
        for i=1:IMAGESNUMBER
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
                PARAMETERSGIVENBYUSER{2} = tempTranslationx;
            end
        else
            tempTest = false;
            canceled = true;
        end
    end

    % getting the y translation parameters
    if(tempTest)
        for i=1:IMAGESNUMBER
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
                PARAMETERSGIVENBYUSER{3} = tempTranslationy;
            end
        else
            tempTest = false;
            canceled = true;
        end
    end

    if(tempTest)
        set(handles.rotationlist, 'String', PARAMETERSGIVENBYUSER{1});
        set(handles.shiftxlist, 'String', PARAMETERSGIVENBYUSER{2});
        set(handles.shiftylist, 'String', PARAMETERSGIVENBYUSER{3});
        ISPARAMETERSGIVENBYUSER = true;
        set(handles.enterparameters, 'Enable', 'off');
        set(handles.removeparameters, 'Enable', 'on');
        set(handles.popupmenu1, 'Enable', 'off');
        set(handles.resultButton, 'Enable', 'on');
        set(handles.resultMenu, 'Enable', 'on');
        for i=1:IMAGESNUMBER
            phi(i) = str2num(PARAMETERSGIVENBYUSER{1}{i});
            deltax(i,1) = str2num(PARAMETERSGIVENBYUSER{2}{i});
            deltay(i,1) = str2num(PARAMETERSGIVENBYUSER{3}{i});
        end
        PARAMETERSGIVENBYUSER{1} = phi;
        PARAMETERSGIVENBYUSER{2} = deltax;
        PARAMETERSGIVENBYUSER{3} = deltay;
    else
        if (size(tempRotations,1) > 0 & (canceled == false))
            errordlg('One parameter in not correct');
            PARAMETERSGIVENBYUSER = {};
        end
    end
catch
    errordlg('One parameter in not correct');
    PARAMETERSGIVENBYUSER = {};
end

%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove all parameters %
%%%%%%%%%%%%%%%%%%%%%%%%%

function removeParameters(handles)
global ISPARAMETERSGIVENBYUSER;
global PARAMETERSGIVENBYUSER;
global PARAMETERSWILLBEGIVEN;
global MAINHANDLES;

handles = MAINHANDLES;

PARAMETERSGIVENBYUSER = {};
ISPARAMETERSGIVENBYUSER = false;
set(handles.rotationlist, 'String', {});
set(handles.shiftxlist, 'String', {});
set(handles.shiftylist, 'String', {});
set(handles.removeparameters, 'Enable', 'off');
set(handles.resultButton, 'Enable', 'off');
set(handles.resultMenu, 'Enable', 'off');
if (PARAMETERSWILLBEGIVEN)
    set(handles.enterparameters, 'Enable', 'on');
else
    set(handles.enterparameters, 'Enable', 'off');
end

MAINHANDLES = handles;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate the output image %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function generateImage(handles)
global IMAGESNUMBER;
global IMAGESDATA;
global ISPARAMETERSGIVENBYUSER;
global PARAMETERSWILLBEGIVEN;
global PARAMETERSGIVENBYUSER;
global TEMPRESULT;
global IMAGES;
global IMAGESINFO;
global DESTGIVEN2;

% choose the case

if (ISPARAMETERSGIVENBYUSER == true & get(handles.radiobutton1, 'Value') == 0)
    registration = 'manual';
else
    switch get(handles.popupmenu1,'Value')
        case 1
            registration = 'vandewalle';
        case 2
            registration = 'marcel';
        case 3
            registration = 'lucchese';
        case 4
            registration = 'keren';
        otherwise
            disp('Unknown registration method.');
    end %switch
end %if

switch get(handles.popupmenu2,'Value')
    case 1
        reconstruction = 'interpolation';
    case 2
        reconstruction = 'papoulis-gerchberg';
    case 3
        reconstruction = 'iteratedBP'; %iterated back projection
    case 4
        reconstruction = 'robustSR'; %Robust super resolution
    case 5
        reconstruction = 'pocs'; %A kind of POCS technique...
    case 6
        reconstruction = 'normConv';
    otherwise
        disp('Unknown registration method.');
end

h = waitbar(0, 'Preprocessing images');
set(h, 'Name', 'Please wait...');

% preprocessing images
for i=1:IMAGESNUMBER
    waitbar(i/IMAGESNUMBER, h, 'Preprocessing images');
    im{i} = IMAGES{i};
    im{i} = double(im{i})/(2^(IMAGESINFO{i}.BitDepth/IMAGESINFO{i}.SamplesPerPixel));
    imColor{i} = im{i};
    if (size(size(IMAGES{1}), 2) == 3)
        im{i} = rgb2gray(im{i});
    end
    %% select part of the image or full image to reconstruct
    % full image
    if (get(handles.radio_rec_full, 'Value') == 1)
        im_part{i} = imColor{i};
    else
    % only part of the high resolution image will be reconstructed
    % because of memory limitations and to show the details appropriately
        part = get(handles.text_rec_part, 'String');
        part = str2double(part);
        half_rem_size = round(size(im{i})*(1-part/100)/2);
        im_part{i} = ...
            imColor{i}(1+half_rem_size(1):end-half_rem_size(1),...
                1+half_rem_size(2):end-half_rem_size(2),:);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

waitbar(0, h);
if(get(handles.checkbox1, 'Value') == 1)
    % multiply the images with a Tukey window for more accurate registration 
    % (by making them circularly symmetric)
    s_im=size(im{1});
    w1=window(@tukeywin,s_im(1),0.25);
    w2=window(@tukeywin,s_im(2),0.25)';
    w=w1*w2;

    for i=1:IMAGESNUMBER
        waitbar(i/(IMAGESNUMBER), h, 'Multiplying images with Tukey window...');
        im{i} = [zeros(32,s_im(2)+64); ...
            zeros(s_im(1),32) im{i}.*w zeros(s_im(1),32); ...
            zeros(32,s_im(2)+64)];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close(h);

% motion estimation

filename1 = 'xx';
filename2 = 'yy';

if get(handles.radiobutton6, 'Value') == 0 %'estimate shift+rotation' is selected
    switch registration
        case 'manual'
            filename1 = 'Man';
            % user
            for i=1:IMAGESNUMBER
                phi_est = PARAMETERSGIVENBYUSER{1};
                delta_est = [PARAMETERSGIVENBYUSER{2} PARAMETERSGIVENBYUSER{3}];
            end
        case 'vandewalle'
            filename1 = 'VA';
            % patrick
            [delta_est, phi_est] = estimate_motion(im,0.6,25);
        case 'marcel'
            filename1 = 'MA';
            % marcel
            [delta_est, phi_est] = marcel(im,2);
        case 'lucchese'
            filename1 = 'LU';
            % lucchese
            [delta_est, phi_est] = lucchese(im,2);
        case 'keren'
            filename1 = 'KE';
            % keren
            [delta_est, phi_est] = keren(im);
    end

else %if 'estimate shift only' is selected
    switch registration
        case 'manual'
            filename1 = 'Man';
            % user
            for i=1:IMAGESNUMBER
                phi_est = PARAMETERSGIVENBYUSER{1};
                delta_est = [PARAMETERSGIVENBYUSER{2} PARAMETERSGIVENBYUSER{3}];
            end
        case 'vandewalle'
            filename1 = 'VA';
            % patrick
            delta_est = estimate_shift(im,25);
            phi_est = zeros(size(delta_est,1), 1);
        case 'marcel'
            filename1 = 'MA';
            % marcel
            delta_est = marcel_shift(im,2);
            phi_est = zeros(size(delta_est,1), 1);
        case 'lucchese'
            filename1 = 'LU';
            % lucchese
            delta_est = marcel_shift(im,2);
            phi_est = zeros(size(delta_est,1), 1);
        case 'keren'
            filename1 = 'KE';
            % keren
            delta_est = keren_shift(im);
            phi_est = zeros(size(delta_est,1), 1);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% signal reconstruction
% get interpolation factor
factor = get(handles.text_interp_factor, 'String');
factor = str2double(factor);

im_temp = {};
im_color1 = {};
im_color2 = {};
if (size(size(IMAGES{1}), 2) == 3)
    for i=1:IMAGESNUMBER
        im_temp{i} = rgb2ycbcr(im_part{i});
        im_part{i} = im_temp{i}(:,:,1);
    end
    cb_temp = im_temp{1}(:,:,2);    
    cr_temp = im_temp{1}(:,:,3);
    im_color1 = imresize(cb_temp, factor, 'bicubic');
    im_color2 = imresize(cr_temp, factor, 'bicubic');    
end

% reconstruct high resolution image
switch reconstruction
    case 'interpolation'
        filename2 = 'IN';
        im_result = interpolation(im_part,delta_est,phi_est,factor);
    case 'papoulis-gerchberg'
        filename2 = 'PG';
        im_result = papoulisgerchberg(im_part,delta_est,factor);
    case 'iteratedBP'
        filename2 = 'BP';
        im_result = iteratedbackprojection(im_part, delta_est, phi_est, factor);
    case 'robustSR'
        filename2 = 'RS';
        im_result = robustSR(im_part, delta_est, phi_est, factor);
    case 'pocs'
        filename2 = 'PO';
        im_result = pocs(im_part,delta_est,factor);
    case 'normConv'
        correctNoise = get(handles.noise_checkbox, 'Value');
        twoPass = get(handles.twopass_checkbox, 'Value');
        filename2 = ['NC' num2str(correctNoise) num2str(twoPass)];
        im_result = n_conv(im_part,delta_est,phi_est,factor,correctNoise,twoPass);%Last two parameters are booleans for: noiseCorrect and TwoPass
    otherwise
        errordlg('Unknown reconstruction technique');
end


if (size(size(IMAGES{1}), 2) == 3)
    temp_result_ycbcr(:,:,1) = im_result;
    temp_result_ycbcr(:,:,2) = im_color1;
    temp_result_ycbcr(:,:,3) = im_color2;
    im_result = ycbcr2rgb(temp_result_ycbcr);
end

%% Auto Save
autoSave = get(handles.saveHR_checkbox,'Value');
tempPath = get(handles.text14,'String');

if(autoSave)
    if(DESTGIVEN2 && get(handles.radiobutton9, 'Value'))

        for i = 1:99 % Check if file name already exist, and increment...
            if(exist([tempPath '/' 'result_' filename1 '_' filename2 '_' num2str(i) '.tif'], 'file') == 0)
                fileName = ['result_' filename1 '_' filename2 '_' num2str(i) '.tif'];
                break
            end
        end
        imwrite(im_result, [tempPath '/' fileName]);
        
    else
        
        for i = 1:99 % Check if file name already exist, and increment...
            if(exist(['result_' filename1 '_' filename2 '_' num2str(i) '.tif'], 'file') == 0)
                fileName = ['result_' filename1 '_' filename2 '_' num2str(i) '.tif'];
                break
            end
        end
        imwrite(im_result, fileName);
        
    end
end
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure(99);
set(99, 'NumberTitle', 'off')
set(99, 'Name', 'High Resolution Image')
imshow(im_result);


% display parameters
set(handles.rotationlist, 'String', phi_est);
set(handles.shiftxlist, 'String', delta_est(:,1));
set(handles.shiftylist, 'String', delta_est(:,2));
set(handles.rotationlist, 'Enable', 'on');
set(handles.shiftxlist, 'Enable', 'on');
set(handles.shiftylist, 'Enable', 'on');

PARAMETERSGIVENBYUSER{1} = phi_est;
PARAMETERSGIVENBYUSER{2} = delta_est(:,1);
PARAMETERSGIVENBYUSER{3} = delta_est(:,2);
registration = 'manual';

PARAMETERSWILLBEGIVEN = true;
set(handles.popupmenu1, 'Enable', 'off');
ISPARAMETERSGIVENBYUSER = true;
set(handles.removeparameters, 'Enable', 'on');
set(handles.radiobutton2, 'Value', 1.0);


%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate input images %
%%%%%%%%%%%%%%%%%%%%%%%%%

function generateInputImages(handles)
generation();
uiwait();

%%%%%%%%%%%%%%%%%%%%%%
% Callback functions %
%%%%%%%%%%%%%%%%%%%%%%

% --- Outputs from this function are returned to the command line.
function varargout = superresolution_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on button press in addButton.
function addButton_Callback(hObject, eventdata, handles)
% hObject    handle to addButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addImageFile(handles);


% --- Executes on button press in removeButton.
function removeButton_Callback(hObject, eventdata, handles)
% hObject    handle to removeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imageNumber = get((handles.listImages), 'Value');
removeImageFile(handles, imageNumber);


% --- Executes on selection change in listImages.
function listImages_Callback(hObject, eventdata, handles)
% hObject    handle to listImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listImages contents as cell array
%        contents{get(hObject,'Value')} returns selected item from
%        listImages
global IMAGESDATA;
if get(hObject,'Value') >=1
    fname = IMAGESDATA(get(hObject,'Value')).name;
    pname = IMAGESDATA(get(hObject,'Value')).path;
    selectImage(handles, fname, pname);
end

% --- Executes during object creation, after setting all properties.
function listImages_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in resultButton.
function resultButton_Callback(hObject, eventdata, handles)
% hObject    handle to resultButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if testImages(handles)
    generateImage(handles);
end

% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in zoomPreview.
function zoomPreview_Callback(hObject, eventdata, handles)
% hObject    handle to zoomPreview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IMAGESDATA;
if get(handles.listImages,'Value') >=1
    fname = IMAGESDATA(get(handles.listImages,'Value')).name;
    pname = IMAGESDATA(get(handles.listImages,'Value')).path;
    figure;
    imshow([pname '/' fname]);
end

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


% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
if get(handles.popupmenu1, 'Value')==3 && get(handles.radiobutton6, 'Value')
    axes(handles.axes9); imshow('logo_warning.tif');
    set(handles.text17, 'Visible', 'on');
else
    axes(handles.axes9); imshow([]);
    set(handles.text17, 'Visible', 'off');
end


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


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
if get(handles.popupmenu2, 'Value')==6
    set(handles.noise_checkbox, 'Visible', 'on');
    set(handles.twopass_checkbox, 'Visible', 'on');
else
    set(handles.noise_checkbox, 'Visible', 'off');
    set(handles.twopass_checkbox, 'Visible', 'off');
end

if (get(handles.popupmenu2, 'Value')==2 || get(handles.popupmenu2, 'Value')==5) && get(handles.radiobutton7, 'Value')
    axes(handles.axes8); imshow('logo_warning.tif');
    set(handles.text16, 'Visible', 'on');
else
    axes(handles.axes8); imshow([]);
    set(handles.text16, 'Visible', 'off');
end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in removeAllButton.
function removeAllButton_Callback(hObject, eventdata, handles)
% hObject    handle to removeAllButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
removeAllImages(handles);


% --- Executes on button press in enterparameters.
function enterparameters_Callback(hObject, eventdata, handles)
enterParameters(handles);


% --- Executes on button press in removeparameters.
function removeparameters_Callback(hObject, eventdata, handles)
% hObject    handle to removeparameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
removeParameters(handles);

% --- Executes on selection change in rotationlist.
function rotationlist_Callback(hObject, eventdata, handles)
% hObject    handle to rotationlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns rotationlist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rotationlist


% --- Executes during object creation, after setting all properties.
function rotationlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rotationlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in shiftxlist.
function shiftxlist_Callback(hObject, eventdata, handles)
% hObject    handle to shiftxlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns shiftxlist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from shiftxlist


% --- Executes during object creation, after setting all properties.
function shiftxlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shiftxlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes during object creation, after setting all properties.
function imagePreview_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imagePreview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate imagePreview

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
global PARAMETERSWILLBEGIVEN;
set(handles.radiobutton1, 'Value', 1);
PARAMETERSWILLBEGIVEN = false;
set(handles.enterparameters, 'Enable', 'off');
set(handles.removeparameters, 'Enable', 'off');
set(handles.resultButton, 'Enable', 'on');
set(handles.resultMenu, 'Enable', 'on');
set(handles.popupmenu1, 'Enable', 'on');
set(handles.rotationlist, 'Enable', 'off');
set(handles.shiftxlist, 'Enable', 'off');
set(handles.shiftylist, 'Enable', 'off');

if get(handles.popupmenu1, 'Value')==3 && get(handles.radiobutton6, 'Value')
    axes(handles.axes9); imshow('logo_warning.tif');
    set(handles.text17, 'Visible', 'on');
else
    axes(handles.axes9); imshow([]);
    set(handles.text17, 'Visible', 'off');
end


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
global PARAMETERSWILLBEGIVEN;
global ISPARAMETERSGIVENBYUSER;
set(handles.radiobutton2, 'Value', 1);
PARAMETERSWILLBEGIVEN = true;
%disp('were here')
set(handles.popupmenu1, 'Enable', 'off');
set(handles.rotationlist, 'Enable', 'on');
set(handles.shiftxlist, 'Enable', 'on');
set(handles.shiftylist, 'Enable', 'on');
ISPARAMETERSGIVENBYUSER;
if(ISPARAMETERSGIVENBYUSER)
    set(handles.removeparameters, 'Enable', 'on');
    set(handles.resultButton, 'Enable', 'on');
    set(handles.resultMenu, 'Enable', 'on');
else
    set(handles.enterparameters, 'Enable', 'on');
    set(handles.resultButton, 'Enable', 'off');
    set(handles.resultMenu, 'Enable', 'off');
end
axes(handles.axes9); imshow([]);
set(handles.text17, 'Visible', 'off');



%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Menu Callback functions %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --------------------------------------------------------------------
function addMenu_Callback(hObject, eventdata, handles)
% hObject    handle to addMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addImageFile(handles);


% --------------------------------------------------------------------
function removeMenu_Callback(hObject, eventdata, handles)
% hObject    handle to removeMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imageNumber = get((handles.listImages), 'Value');
removeImageFile(handles, imageNumber);


% --------------------------------------------------------------------
function removeAllMenu_Callback(hObject, eventdata, handles)
% hObject    handle to removeAllMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
removeAllImages(handles);


% --------------------------------------------------------------------
function exitMenu_Callback(hObject, eventdata, handles)
% hObject    handle to exitMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;


% --------------------------------------------------------------------
function generateInputMenu_Callback(hObject, eventdata, handles)
% hObject    handle to generateInputMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

generateInputImages(handles);

% --------------------------------------------------------------------
function resultMenu_Callback(hObject, eventdata, handles)
% hObject    handle to resultMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
generateImage(handles);

% --------------------------------------------------------------------
function documentationMenu_Callback(hObject, eventdata, handles)
% hObject    handle to documentationMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open([pwd '/html/SR_documentation.html']);

% --------------------------------------------------------------------
function aboutMenu_Callback(hObject, eventdata, handles)
% hObject    handle to aboutMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open([pwd '/html/SR_about.html']);

% --------------------------------------------------------------------
function processingMenu_Callback(hObject, eventdata, handles)
% hObject    handle to processingMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function helpMenu_Callback(hObject, eventdata, handles)
% hObject    handle to helpMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function fileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to fileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in rotationylist.
function rotationylist_Callback(hObject, eventdata, handles)
% hObject    handle to rotationylist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns rotationylist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rotationylist


% --- Executes during object creation, after setting all properties.
function rotationylist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rotationylist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in shiftylist.
function shiftylist_Callback(hObject, eventdata, handles)
% hObject    handle to shiftylist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns shiftylist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from shiftylist


% --- Executes during object creation, after setting all properties.
function shiftylist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shiftylist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function text_rec_part_Callback(hObject, eventdata, handles)
% hObject    handle to text_rec_part (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text_rec_part as text
%        str2double(get(hObject,'String')) returns contents of text_rec_part as a double


% --- Executes during object creation, after setting all properties.
function text_rec_part_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_rec_part (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function text_interp_factor_Callback(hObject, eventdata, handles)
% hObject    handle to text_interp_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text_interp_factor as text
%        str2double(get(hObject,'String')) returns contents of text_interp_factor as a double


% --- Executes during object creation, after setting all properties.
function text_interp_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_interp_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1




% --- Executes on button press in chooseDest_pushbutton.
function chooseDest_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to chooseDest_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DESTGIVEN2;
destDirName = uigetdir('Choose the destination directory');
if length(destDirName) > 1
    set(handles.text14, 'String', destDirName);
    DESTGIVEN2 = true;
end


% --- Executes on button press in saveHR_checkbox.
function saveHR_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to saveHR_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveHR_checkbox


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MAINHANDLES;

MAINHANDLES = handles;
generateInputImages(handles);
if exist('CINAMES.mat', 'file')==2 && exist('CIPATH.mat', 'file')==2
    addCreatedImages(handles);
    delete CINAMES.mat;
    delete CIPATH.mat;
end


% --- Executes during object creation, after setting all properties.
function uipanel13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on button press in saveInCurrentDir_radiobutton.
function saveInCurrentDir_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to saveInCurrentDir_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveInCurrentDir_radiobutton
set(handles.saveInCurrentDir_radiobutton, 'Value', 1);
set(handles.chooseDest_pushbutton, 'Enable', 'off');
set(handles.text14, 'Enable', 'off');



% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9
set(handles.radiobutton9, 'Value', 1);
set(handles.chooseDest_pushbutton, 'Enable', 'on');
set(handles.text14, 'Enable', 'on');



% --- Executes on button press in radio_rec_full.
function radio_rec_full_Callback(hObject, eventdata, handles)
% hObject    handle to radio_rec_full (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_rec_full
set(handles.radio_rec_full, 'Value', 1);
set(handles.text_rec_part, 'Enable', 'off');


% --- Executes on button press in radio_rec_part.
function radio_rec_part_Callback(hObject, eventdata, handles)
% hObject    handle to radio_rec_part (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_rec_part
set(handles.radio_rec_part, 'Value', 1);
set(handles.text_rec_part, 'Enable', 'on');



% --- Executes on button press in noise_checkbox.
function noise_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to noise_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of noise_checkbox


% --- Executes on button press in twopass_checkbox.
function twopass_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to twopass_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of twopass_checkbox




% --- Executes during object creation, after setting all properties.
function axes8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes8




% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7
set(handles.radiobutton7, 'Value', 1);
if (get(handles.popupmenu2, 'Value')==2 || get(handles.popupmenu2, 'Value')==5) && get(handles.radiobutton7, 'Value')
    axes(handles.axes8); imshow('logo_warning.tif');
    set(handles.text16, 'Visible', 'on');
else
    axes(handles.axes8); imshow([]);
    set(handles.text16, 'Visible', 'off');
end

if get(handles.popupmenu1, 'Value')==3 && get(handles.radiobutton6, 'Value')
    axes(handles.axes9); imshow('logo_warning.tif');
    set(handles.text17, 'Visible', 'on');
else
    axes(handles.axes9); imshow([]);
    set(handles.text17, 'Visible', 'off');
end


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
set(handles.radiobutton6, 'Value', 1);
if (get(handles.popupmenu2, 'Value')==2 || get(handles.popupmenu2, 'Value')==5) && get(handles.radiobutton7, 'Value')
    axes(handles.axes8); imshow('logo_warning.tif');
    set(handles.text16, 'Visible', 'on');
else
    axes(handles.axes8); imshow([]);
    set(handles.text16, 'Visible', 'off');
end

if get(handles.popupmenu1, 'Value')==3 && get(handles.radiobutton6, 'Value')
    axes(handles.axes9); imshow('logo_warning.tif');
    set(handles.text17, 'Visible', 'on');
else
    axes(handles.axes9); imshow([]);
    set(handles.text17, 'Visible', 'off');
end


% --- Executes on button press in reset_pushbutton.
function reset_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to reset_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PARAMETERSWILLBEGIVEN

set(handles.radiobutton7, 'Value', 1);
set(handles.radiobutton1, 'Value', 1);
set(handles.popupmenu1, 'Value', 1);
set(handles.popupmenu2, 'Value', 1);
set(handles.text_interp_factor, 'String', '2');
set(handles.radio_rec_full, 'Value', 1);
set(handles.text_rec_part, 'String', '100');
set(handles.saveInCurrentDir_radiobutton, 'Value', 1);
set(handles.checkbox1, 'Value', 0);
set(handles.saveHR_checkbox, 'Value', 1);
set(handles.noise_checkbox, 'Value', 0);
set(handles.twopass_checkbox, 'Value', 0);

PARAMETERSWILLBEGIVEN = false;
set(handles.enterparameters, 'Enable', 'off');
set(handles.removeparameters, 'Enable', 'off');
set(handles.resultButton, 'Enable', 'on');
set(handles.resultMenu, 'Enable', 'on');
set(handles.popupmenu1, 'Enable', 'on');
set(handles.rotationlist, 'Enable', 'off');
set(handles.shiftxlist, 'Enable', 'off');
set(handles.shiftylist, 'Enable', 'off');

if get(handles.popupmenu1, 'Value')==3 && get(handles.radiobutton6, 'Value')
    axes(handles.axes9); imshow('logo_warning.tif');
    set(handles.text17, 'Visible', 'on');
else
    axes(handles.axes9); imshow([]);
    set(handles.text17, 'Visible', 'off');
end

set(handles.text_rec_part, 'Enable', 'off');

set(handles.chooseDest_pushbutton, 'Enable', 'off');
set(handles.text14, 'Enable', 'off');

if get(handles.popupmenu2, 'Value')==6
    set(handles.noise_checkbox, 'Visible', 'on');
    set(handles.twopass_checkbox, 'Visible', 'on');
else
    set(handles.noise_checkbox, 'Visible', 'off');
    set(handles.twopass_checkbox, 'Visible', 'off');
end

if (get(handles.popupmenu2, 'Value')==2 || get(handles.popupmenu2, 'Value')==5) && get(handles.radiobutton7, 'Value')
    axes(handles.axes8); imshow('logo_warning.tif');
    set(handles.text16, 'Visible', 'on');
else
    axes(handles.axes8); imshow([]);
    set(handles.text16, 'Visible', 'off');
end