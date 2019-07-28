function varargout = Ganaste(varargin)
% GANASTE MATLAB code for Ganaste.fig
%      GANASTE, by itself, creates a new GANASTE or raises the existing
%      singleton*.
%
%      H = GANASTE returns the handle to a new GANASTE or the handle to
%      the existing singleton*.
%
%      GANASTE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GANASTE.M with the given input arguments.
%
%      GANASTE('Property','Value',...) creates a new GANASTE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Ganaste_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Ganaste_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Ganaste

% Last Modified by GUIDE v2.5 20-Jul-2019 16:17:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Ganaste_OpeningFcn, ...
                   'gui_OutputFcn',  @Ganaste_OutputFcn, ...
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


% --- Executes just before Ganaste is made visible.
function Ganaste_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Ganaste (see VARARGIN)

% Choose default command line output for Ganaste
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%--------------------------------------------------------------------------
% Cuando se llame la funcion Ganaste.m aparecerá la imagen correspondiente
%--------------------------------------------------------------------------

% Fondo de ganaste -------------------------------------------
axes(handles.ImaFondo)
imshow('./Imagenes/Ganaste.jpg')
% -------------------------------------------------------------------------

global puntaje; % Obtenemos el puntaje acumulado del jugador

% Declaracion de sonidos---------------------------------------------------
[yWin,FsWin] = audioread('./Sonidos/Ganaste.mp3');

% Reproducimos un sonido de ganaste cuando se llama a la funcion ----------
sound(yWin,FsWin);

puntajefinal=num2str(puntaje); % Convertimos una matriz numérica en una matriz de caracteres que representa los números
set(handles.puntajeFinal, 'string', puntajefinal);   % Enviamos el puntaje actual al cuadro que muestra el puntaje final el juego


% --- Outputs from this function are returned to the command line.
function varargout = Ganaste_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function ImaFondo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImaFondo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate ImaFondo
