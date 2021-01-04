function varargout = BrainBloodVessel(varargin)
% BRAINBLOODVESSEL MATLAB code for BrainBloodVessel.fig
%      BRAINBLOODVESSEL, by itself, creates a new BRAINBLOODVESSEL or raises the existing
%      singleton*.
%
%      H = BRAINBLOODVESSEL returns the handle to a new BRAINBLOODVESSEL or the handle to
%      the existing singleton*.
%
%      BRAINBLOODVESSEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BRAINBLOODVESSEL.M with the given input arguments.
%
%      BRAINBLOODVESSEL('Property','Value',...) creates a new BRAINBLOODVESSEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BrainBloodVessel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BrainBloodVessel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BrainBloodVessel

% Last Modified by GUIDE v2.5 21-Mar-2014 20:51:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BrainBloodVessel_OpeningFcn, ...
                   'gui_OutputFcn',  @BrainBloodVessel_OutputFcn, ...
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


% --- Executes just before BrainBloodVessel is made visible.
function BrainBloodVessel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BrainBloodVessel (see VARARGIN)

% Choose default command line output for BrainBloodVessel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BrainBloodVessel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BrainBloodVessel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonLoadImg.
function pushbuttonLoadImg_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonLoadImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fileName = uigetfile('*.jpg');

img = imread(fileName);
imgR = img(:,:,1);
imgR = imresize(imgR, [500 500]);
Trs = 20;
set(handles.textTrsV, 'String', {int2str(Trs)});

axes(handles.axesOrg);
imshow(imgR);

imgTrs = ImgThres( imgR,Trs );

axes(handles.axesTrg);
imshow(imgTrs);

% Choose default command line output for TerrainGenerator
handles.imgR = imgR;
handles.Trs = Trs;
handles.imgTrs = imgTrs;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbuttonTrsP.
function pushbuttonTrsP_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonTrsP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Trs = handles.Trs + 5;
set(handles.textTrsV, 'String', {int2str(handles.Trs)});

handles.imgTrs = ImgThres( handles.imgR,handles.Trs );

axes(handles.axesTrg);
imshow(handles.imgTrs);

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbuttonTrsM.
function pushbuttonTrsM_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonTrsM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Trs = handles.Trs - 5;
set(handles.textTrsV, 'String', {int2str(handles.Trs)});

handles.imgTrs = ImgThres( handles.imgR,handles.Trs );

axes(handles.axesTrg);
imshow(handles.imgTrs);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbuttonSkel.
function pushbuttonSkel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSkel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.imgTrs = ImgSkel( handles.imgTrs );

axes(handles.axesTrg);
imshow(handles.imgTrs);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbuttonInsOrg.
function pushbuttonInsOrg_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonInsOrg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Origin = GetOrigin(  );

axes(handles.axesTrg); % Select the proper axes
hold on;
plot(Origin(1, 1), Origin(1, 2), 'r.');
hold off;

% Choose default command line output for TerrainGenerator
handles.Origin = Origin;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbuttonInsTrg.
function pushbuttonInsTrg_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonInsTrg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Target = GetTarget(  );

axes(handles.axesTrg); % Select the proper axes
hold on;
plot(Target(1, 1), Target(1, 2), 'r.');
hold off;

% Choose default command line output for TerrainGenerator
handles.Target = Target;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbuttonFindPath.
function pushbuttonFindPath_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonFindPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Map = uint8(handles.imgTrs);
Map = Map * 255;

Path = FindPath( handles.Origin,handles.Target,Map );

axes(handles.axesTrg); % Select the proper axes
hold on;
plot(Path(:, 1), Path(:, 2), 'r.');
hold off;

% Choose default command line output for TerrainGenerator
handles.Path = Path;

% Update handles structure
guidata(hObject, handles);
