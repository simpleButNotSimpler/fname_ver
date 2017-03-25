function varargout = rep(varargin)
% REP MATLAB code for rep.fig
%      REP, by itself, creates a new REP or raises the existing
%      singleton*.
%
%      H = REP returns the handle to a new REP or the handle to
%      the existing singleton*.
%
%      REP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REP.M with the given input arguments.
%
%      REP('Property','Value',...) creates a new REP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rep_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rep_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rep

% Last Modified by GUIDE v2.5 25-Mar-2017 23:26:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rep_OpeningFcn, ...
                   'gui_OutputFcn',  @rep_OutputFcn, ...
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


% --- Executes just before rep is made visible.
function rep_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rep (see VARARGIN)

% Choose default command line output for rep
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rep wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rep_OutputFcn(hObject, eventdata, handles) 
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
%read the index file
[path, name] = uigetfile('*.txt');
fileid = fopen(strcat(name, path), 'r');
indexfile = textscan(fileid, '%s');
fclose(fileid);

%get the output folder
set(handles.pushbutton1,'Enable','off');
folderpath = 'C:\Users\kkmlover\Documents\DJIMY\WORK\fname_ver\testim\';

%display the first image
im = imread(strcat(folderpath, indexfile{1}{1}));
imshow(im, 'Parent', handles.fullim);
set(handles.fnametbox,'string', indexfile{1}{1});

%update guidata
handles.lim = length(indexfile{:});
handles.indexfile = indexfile;
handles.counter = 1;
handles.folderpath = folderpath;
guidata(hObject, handles);


function fnametbox_Callback(hObject, eventdata, handles)
% hObject    handle to fnametbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fnametbox as text
%        str2double(get(hObject,'String')) returns contents of fnametbox as a double


% --- Executes during object creation, after setting all properties.
function fnametbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fnametbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%pushbutton2 the current file name
oldname = handles.indexfile{1}{handles.counter};
newname = get(handles.fnametbox,'string');
oldName_path = fullfile(handles.folderpath, oldname);
newName_path = fullfile(handles.folderpath, newname);
movefile(oldName_path, newName_path);

%display the next image
handles.counter = handles.counter + 1;
if handles.counter > handles.lim
    set(handles.pushbutton2,'Enable','off');
    set(handles.fnametbox,'Enable','off');
    return;
end

%display the next image
im = imread(strcat(handles.folderpath, handles.indexfile{1}{handles.counter}));
imshow(im, 'Parent', handles.fullim);
set(handles.fnametbox,'string', handles.indexfile{1}{handles.counter});
