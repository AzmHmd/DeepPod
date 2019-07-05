% This toolbox is written to annotate various parts of plants to be used in
% the concept of Deep Learning.
% To run it, just press the run button and the window will open for you.
%
%%  ** Please go to line 51 to change the default path to your desired path.
%% EDITABLE section: If you need to change or add or delete plant parts,
% edit the section starting on line 109.
%
% written by Azam Hamidinekoo, Aberystwyth University, 2017
% *************************************************************************
%% -------------------------------------------------------------------------

function varargout = PlantAnnotationToolbox(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @PlantAnnotationToolbox_OpeningFcn, ...
    'gui_OutputFcn',  @PlantAnnotationToolbox_OutputFcn, ...
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


% --- Executes just before PlantAnnotationToolbox is made visible.
function PlantAnnotationToolbox_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for PlantAnnotationToolbox
handles.output = hObject;
handles.label = 'Choose';
handles.imgnum = 1;
% Update handles structure
guidata(hObject, handles);
% --- Outputs from this function are returned to the command line.
function varargout = PlantAnnotationToolbox_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1: responsible for loading the
% image files you want to do annotation on.
function pushbutton1_Callback(hObject, eventdata, handles)
[handles.file handles.pathname] = uigetfile({'*.*'},...
   'C:\Users\gig7\Documents\MATLAB\Annotation-Toolbox-master');
images = dir([handles.pathname,'*.png']);
handles.images = images;
x = struct2cell(images);
handles.imgnum = find(ismember(x(1,:),handles.file));% find the index of the file in the selected folder
fullpath = strcat(handles.pathname,handles.images(handles.imgnum).name);
if handles.imgnum <= length(handles.images)
    ppp = uipanel('Units','Pixels');
    %set(ppp,'position',[100 100 1250 650]);
    %set(ppp,'position',[1 1 256 256]);
    handles.axes1 = axes('parent',ppp,'position',[0 0 1 1],'Units','normalized');
    img = imread(fullpath);
    hIm = imshow(img,'Parent',handles.axes1);hold on;
%     hSP = imscrollpanel(ppp,hIm);
%     set(hSP,'Units','normalized',...
%         'Position',[0 .1 1 .9])
%     hMagBox = immagbox(ppp,hIm);
%     pos = get(hMagBox,'Position');
%     set(hMagBox,'Position',[0 0 pos(3) pos(4)])
%     imoverview(hIm)
%     apiSP = iptgetapi(hSP);
%     apiSP.setMagnification(4)
else
    errordlg('No images found!')
end
guidata( hObject, handles );

% --- Executes on button press in pushbutton2: responsible for saving
function pushbutton2_Callback(hObject, eventdata, handles)
if strcmp(handles.label,'Choose')
    errordlg('Please define a proper label for your annotation!')
end
handles.stop_now = 1;
guidata( hObject, handles );

% --- Executes on button press in pushbutton3: responsible for going to the
% next image file
function pushbutton3_Callback(hObject, eventdata, handles)
handles.imgnum = handles.imgnum +1;

if handles.imgnum <= length(handles.images)
    img_name = handles.images(handles.imgnum).name;
    fullpath = strcat(handles.pathname,img_name);
    ppp = uipanel('Units','Pixels');
    set(ppp,'position',[100 100 1250 650]);
    handles.axes1 = axes('parent',ppp,'position',[0 0 1 1],'Units','normalized');
    img = imread(fullpath);
    hIm = imshow(img,'Parent',handles.axes1);hold on;
    hSP = imscrollpanel(ppp,hIm);
    set(hSP,'Units','normalized',...
        'Position',[0 .1 1 .9])
    imoverview(hIm)
    apiSP = iptgetapi(hSP);
    apiSP.setMagnification(2)
else
    errordlg('No images left.. You are done!')
end
guidata( hObject, handles );

%% EDITABLE section: Executes on selection change in popupmenu1:
% which contains the parts you want to annotate.
%  If you need to change or add or delete plant parts, edit this section.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
items = get(hObject,'String');
index_selected = get(hObject,'Value');
item_selected = items{index_selected};
display(item_selected);
handles.label = item_selected;
display(handles.label)

% go for tips:
if strcmp(handles.label,'Tip')
    img_name = handles.images(handles.imgnum).name;
    fidtip = fopen([handles.pathname,img_name(1:end-4),'_',handles.label,'.txt'],'w');
    [x,y] = getpts(handles.axes1);
    plot(x,y,'r*')
    for i = 1:length(x)
        fprintf(fidtip,[num2str(x(i)),',',num2str(y(i)),'\n']);
    end
    
% go for Base:
elseif strcmp(handles.label,'Base')
    img_name = handles.images(handles.imgnum).name;
    fidbase = fopen([handles.pathname,img_name(1:end-4),'_',handles.label,'.txt'],'w');
    [x,y] = getpts(handles.axes1);
    plot(x,y,'yo')
    for i = 1:length(x)
        fprintf(fidbase,[num2str(x(i)),',',num2str(y(i)),'\n']);
    end
    
% go for Stem:
elseif strcmp(handles.label,'Stem')
    img_name = handles.images(handles.imgnum).name;
    fidstem = fopen([handles.pathname,img_name(1:end-4),'_',handles.label,'.txt'],'w');
    [x,y] = getpts(handles.axes1);
    plot(x,y,'gx')
    for i = 1:length(x)
        fprintf(fidstem,[num2str(x(i)),',',num2str(y(i)),'\n']);
    end
    
% go for body parts:
elseif strcmp(handles.label,'Body')
    img_name = handles.images(handles.imgnum).name;
    fidbody = fopen([handles.pathname,img_name(1:end-4),'_',handles.label,'.txt'],'w');
    [x,y] = getpts(handles.axes1);
    plot(x,y,'c+')
    for i = 1:length(x)
        fprintf(fidbody,[num2str(x(i)),',',num2str(y(i)),'\n']);
    end
end

guidata( hObject, handles );
% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%
% --- Executes on button press in pushbutton4: contains documentary for th
% help section
function pushbutton4_Callback(hObject, eventdata, handles)
msgbox(sprintf(['This ToolBox is created to label a plant different compartments.\n\n',...
    'To use it:\n 1- Run this m.file, then load an image you want to annotate.\n', ...
    '2- Select the annotation compartment from popup menue:\n',...
    '* Use normal button clicks to add points.\n',...
    '* A shift-, right-, or double-click adds a final point and ends the selection.\n',...
    '* Pressing Return or Enter ends the selection without adding a final point.\n',...
    '* Pressing Backspace or Delete removes the previously selected point.\n',...
    '3- When you finish annotating, the points are saved atomatically in a text file',...
    ' with the name of the image file+compartment label.\n',...
    '4- Use Next to go to other images on the folder you currently are.\n\n',...
    'Hope you find the toolbox easy to use.\n\n\n',...
    'Department of Computer Science,\n Aberystwyth University, UK']))
%% END
