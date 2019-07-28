function varargout = GameOver(varargin)
% GAMEOVER MATLAB code for GameOver.fig
%      GAMEOVER, by itself, creates a new GAMEOVER or raises the existing
%      singleton*.
%
%      H = GAMEOVER returns the handle to a new GAMEOVER or the handle to
%      the existing singleton*.
%
%      GAMEOVER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAMEOVER.M with the given input arguments.
%
%      GAMEOVER('Property','Value',...) creates a new GAMEOVER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GameOver_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GameOver_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GameOver

% Last Modified by GUIDE v2.5 19-Jul-2019 11:08:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GameOver_OpeningFcn, ...
                   'gui_OutputFcn',  @GameOver_OutputFcn, ...
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


% --- Executes just before GameOver is made visible.
function GameOver_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GameOver (see VARARGIN)

% Choose default command line output for GameOver
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%--------------------------------------------------------------------------
% Cuando se llame la funcion GameOver.m aparecerá la imagen correspondiente
%--------------------------------------------------------------------------

% Fondo de Game Over -----------------------------------------------------
axes(handles.GameOver) % Leemos la imagen 
imshow('./Imagenes/game_over.jpg')
%-------------------------------------------------------------------------

global puntaje; % Obtenemos el puntaje acumulado del jugador

% Declaracion de sonidos---------------------------------------------------
[yGameOver,FsGameOver] = audioread('./Sonidos/Pacman_Game_Over.mp3');

% Reproducimos un sonido de perdiste cuando llaman a la funcion------------
sound(yGameOver,FsGameOver);

puntajefinal=num2str(puntaje); % Convertimos una matriz numérica en una matriz de caracteres que representa los números
set(handles.puntajeFinal, 'string', puntajefinal);   % Enviamos el puntaje actual al cuadro que muestra el puntaje final el juego

% --- Outputs from this function are returned to the command line.
function varargout = GameOver_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function GameOver_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GameOver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate GameOver
