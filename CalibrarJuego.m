function varargout = CalibrarJuego(varargin)
% CALIBRARJUEGO MATLAB code for CalibrarJuego.fig
%      CALIBRARJUEGO, by itself, creates a new CALIBRARJUEGO or raises the existing
%      singleton*.
%
%      H = CALIBRARJUEGO returns the handle to a new CALIBRARJUEGO or the handle to
%      the existing singleton*.
%
%      CALIBRARJUEGO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALIBRARJUEGO.M with the given input arguments.
%
%      CALIBRARJUEGO('Property','Value',...) creates a new CALIBRARJUEGO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CalibrarJuego_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CalibrarJuego_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CalibrarJuego

% Last Modified by GUIDE v2.5 23-Jul-2019 17:44:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CalibrarJuego_OpeningFcn, ...
                   'gui_OutputFcn',  @CalibrarJuego_OutputFcn, ...
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


% --- Executes just before CalibrarJuego is made visible.
function CalibrarJuego_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CalibrarJuego (see VARARGIN)

% Choose default command line output for CalibrarJuego
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%--------------------------------------------------------------------------
%-- 1. VISUALIZACIÓN DEL JUEGO ANTES DE EMPEZAR A CALIBAR -----------------
%--------------------------------------------------------------------------

% Fondo de introduccion de la calibración del juego------------------------
axes(handles.Fondo_Calibracion)
imshow('./Imagenes/pacman.jpg')

% Volvemos visible o invisible las componentes del axis al iniciar el programa
set(handles.Calibrar,'visible', 'on');            %Ponemos visible el boton de calibrar
set(handles.TextInstrucciones,'visible', 'on');   %Ponemos visible el cuadro de texto de las instrucciones
set(handles.SensiActual,'visible', 'off');        %Ponemos invisible el cuadro de texto que recomienda una sensibilidad optima
set(handles.sensibilidadview,'visible', 'off');   %Ponemos invisible la sensibilidad actual
set(handles.SubirSensibilidad,'visible', 'off');  %Ponemos invisible el boton que sube la sensibilidad del juego
set(handles.BajarSensibilidad,'visible', 'off');  %Ponemos invisible el boton que baja la sensibilidad del juego
set(handles.Dilatacion,'visible', 'off');         %Ponemos invisible el axis que muestra la dilatacion y erosion
set(handles.FinalCalibracion,'visible', 'off');   %Ponemos invisible el boton que finaliza la calibracion

% --- Outputs from this function are returned to the command line.
function varargout = CalibrarJuego_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Calibrar.
function Calibrar_Callback(hObject, eventdata, handles)
% hObject    handle to Calibrar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%---------------------------------------------------------------------------
%-- 2. VISUALIZACIÓN DEL JUEGO AL PRESIONAR EL BOTÓN DE CALIBRAR ----------
%---------------------------------------------------------------------------

% Volvemos visible o invisible las componentes del axis
set(handles.Calibrar,'visible', 'off');            %Ponemos invisible el boton de calibrar
set(handles.TextInstrucciones,'visible', 'off');   %Ponemos invisible el cuadro de texto de las instrucciones
set(handles.SensiActual,'visible', 'on');          %Ponemos visible el cuadro de texto que recomienda una sensibilidad optima
set(handles.sensibilidadview,'visible', 'on');     %Ponemos visible la sensibilidad actual
set(handles.SubirSensibilidad,'visible', 'on');    %Ponemos visible el boton que sube la sensibilidad del juego
set(handles.BajarSensibilidad,'visible', 'on');    %Ponemos visible el boton que baja la sensibilidad del juego
set(handles.Dilatacion,'visible', 'on');           %Ponemos visible el axis que muestra la dilatacion y erosion
set(handles.FinalCalibracion,'visible', 'on');     %Ponemos visible el boton que finaliza la calibracion
set(handles.Fondo_Calibracion ,'visible', 'off');  %Ponemos invisible la imagen de fondo

%--------------------------------------------------------------------------
%-- 3. DEFINICIÓN DE VARIABLES --------------------------------------------
%--------------------------------------------------------------------------

global ValorSensibilidad; % Declaramos una variable global para calibrar la sensibilidad del juego
global Final_Calibracion; % Declaramos una variable global para finalizar la calibracion del juego

% Se inicializan variables
Final_Calibracion = 0;
ValorSensibilidad = 8;

ValorSensibilidadPrint=num2str(ValorSensibilidad);  % Convertimos una matriz numérica en una matriz de caracteres que representa los números
set(handles.sensibilidadview, 'string', ValorSensibilidadPrint); % Enviamos la calibracion actual al cuadro que muestra la calibracion

%--------------------------------------------------------------------------
%-- 4. CONFIGURACIÓN DE LA CAPTURA DEL VIDEO ------------------------------
%--------------------------------------------------------------------------
a=videoinput('winvideo',4,'YUY2_160x120'); % Se captura un stream de video usando videoinput.
set(a, 'returnedcolorspace', 'rgb'); % %la imagen del video se van a tomar en modo RGB.

%--------------------------------------------------------------------------
%-- Leo unas imágenes de interés ------------------------------------------

% Esto delimita la zona donde esta la boca --------------------------------
regionBoca=imread('./Imagenes/region.png');   % Leemos la imagen
regionBoca=rgb2gray(regionBoca); % Se pasa la imagen a escala de grises
 
% Carga una region negra de 50X160 ----------------------------------------
regionNegra=imread('./Imagenes/regionNegra.png');   % Leemos la imagen
regionNegra=rgb2gray(regionNegra); % Se pasa la imagen a escala de grises

%--------------------------------------------------------------------------
%-- 5. INICIO DE FUNCIONES ------------------------------------------------
%--------------------------------------------------------------------------

while(1) % Ciclo infinito donde se calibrará la sensibilidad del juego

    if(Final_Calibracion==1) % Condición para romper el ciclo infinito del while
        break;
    end
    
    %----------------------------------------------------------------------
    %-- 6. CAPTURA DE IMAGEN DEL VIDEO ------------------------------------
    %----------------------------------------------------------------------
    
    b=getsnapshot(a);           % Tomamos capturas con la cámara
    c=rgb2gray(b);              % Pasamos la captura a escala de grises
    recuadro1=b;
    recuadro=flip(recuadro1,2); %Se invierte la imagen para que parezca espejo
    
    % Dibujamos un cuadro rojo en donde se debe realizar la apertura o cierrde de la boca del jugador
    recuadro(71:72,60:100,1)=255;
    recuadro(71:100,60:61,1)=255;
    recuadro(71:100,99:100,1)=255;
    recuadro(100:101,60:100,1)=255;
    
     % Aqui calibramos el umbral del juego con la variable global
    u=c;
    u(u<ValorSensibilidad)=0;
    u(u>ValorSensibilidad)=255;
 
    % Resultado despues de realizar la operacion lógica AND entre el umbral y la imagen que delimita la zona de la boca
    resultado = and(regionBoca,u);
    
    % Se saca el negativo del resultado de la AND--------------------------
    negativo=imcomplement(resultado);
    negativo=negativo(71:100,61:100);
    
    %----------------------------------------------------------------------
    %-- 7. APERTURA BINARIA -----------------------------------------------
    %----------------------------------------------------------------------
    
    % La apertura consiste en realizar una erosion y posteriormente una dilatacion
    seErosion = strel('diamond',2);     % Tomamos la figura de diamante como elemento estructura para la erosión porque nos pareció la más adecuada para esta situación
    seDilatacion = strel('octagon',6);  % Tomamos la figura octágono como elemento estructura para la dilatación porque nos pareció la más adecuada para esta situación
    
    % Realizamos la Erosión------------------------------------------------
    erosion=imerode(negativo,seErosion); 
    
    % Realizamos la dilatación---------------------------------------------
    dilatacion = imdilate(erosion,seDilatacion);
    
    %----------------------------------------------------------------------
    %-- 8. ASIGNACIÓN PARA LOS AXES ---------------------------------------
    %----------------------------------------------------------------------
    
    % Enviamos imagen que muestra la camara al axis "Fondo_Calibracion"
    axes(handles.Fondo_Calibracion)
    imshow(recuadro)
    
    % Enviamos la imagen de la dilatacion al axis "Dilatacion"
    axes(handles.Dilatacion)
    imshow(dilatacion) 
end

% --- Executes during object creation, after setting all properties.
function Dilatacion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dilatacion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Dilatacion

% --- Executes during object creation, after setting all properties.
function Fondo_Calibracion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fondo_Calibracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Fondo_Calibracion


% --- Executes on button press in SubirSensibilidad.
function SubirSensibilidad_Callback(hObject, eventdata, handles)
% hObject    handle to SubirSensibilidad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global ValorSensibilidad;

ValorSensibilidad = ValorSensibilidad+2; % Aumentamos de 2 en 2 cada vez que se presione el boton de subir calibracion
ValorSensibilidadPrint=num2str(ValorSensibilidad); % Convertimos una matriz numérica en una matriz de caracteres que representa los números
set(handles.sensibilidadview, 'string', ValorSensibilidadPrint); % Enviamos la calibracion actual al cuadro que muestra la calibracion


% --- Executes on button press in BajarSensibilidad.
function BajarSensibilidad_Callback(hObject, eventdata, handles)
% hObject    handle to BajarSensibilidad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global ValorSensibilidad;

ValorSensibilidad = ValorSensibilidad-2; % Disminuimos de 2 en 2 cada vez que se presione el boton de subir calibracion
ValorSensibilidadPrint=num2str(ValorSensibilidad); % Convertimos una matriz numérica en una matriz de caracteres que representa los números
set(handles.sensibilidadview, 'string', ValorSensibilidadPrint); % Enviamos la calibracion actual al cuadro que muestra la calibracion


% --- Executes on button press in FinalCalibracion.
function FinalCalibracion_Callback(hObject, eventdata, handles)
% hObject    handle to FinalCalibracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Final_Calibracion;
Final_Calibracion = 1; % Le enviamos 1 a esta variable global para qie cuando se presiona el boton de finalizar calibracion se rompa el ciclo infinito del while

close(CalibrarJuego) % Cuando se presiona el boton de finalizar calibracion se cierra la funcion
Nivel_1


% --- Executes during object creation, after setting all properties.
function SensiActual_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SensiActual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function sensibilidadview_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sensibilidadview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function TextInstrucciones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TextInstrucciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
