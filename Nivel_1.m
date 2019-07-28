function varargout = Nivel_1(varargin)
% NIVEL_1 MATLAB code for Nivel_1.fig
%      NIVEL_1, by itself, creates a new NIVEL_1 or raises the existing
%      singleton*.
%
%      H = NIVEL_1 returns the handle to a new NIVEL_1 or the handle to
%      the existing singleton*.
%
%      NIVEL_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIVEL_1.M with the given input arguments.
%
%      NIVEL_1('Property','Value',...) creates a new NIVEL_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Nivel_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Nivel_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Nivel_1

% Last Modified by GUIDE v2.5 23-Jul-2019 17:03:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Nivel_1_OpeningFcn, ...
                   'gui_OutputFcn',  @Nivel_1_OutputFcn, ...
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


% --- Executes just before Nivel_1 is made visible.
function Nivel_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Nivel_1 (see VARARGIN)

% Choose default command line output for Nivel_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%--------------------------------------------------------------------------
%-- 1. VISUALIZACIÓN DEL JUEGO AL EMPEZAR ---------------------------------
%--------------------------------------------------------------------------

% Fondo de introduccion del juego------------------------------------------
axes(handles.ImaFondo)
imshow('./Imagenes/bgintro.jpg')
 
% Volvemos visible o invisible las componentes del axis al iniciar el programa
set(handles.Nivel_1,'visible', 'on');   %Ponemos visible el boton de iniciar nivel 1
set(handles.Dilatacion ,'visible', 'off');    %Ponemos invisible el axis de la dilatacion y erosion
set(handles.Camara ,'visible', 'off');        %Ponemos invisible el axis de la cámara
set(handles.text1 ,'visible', 'off');         %Ponemos invisible el texto que dice "Puntaje"
set(handles.puntajeview ,'visible', 'off');   %Ponemos invisible el cuadro que lleva el puntaje
% -------------------------------------------------------------------------

% --- Outputs from this function are returned to the command line.
function varargout = Nivel_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Nivel_1.
function Nivel_1_Callback(hObject, eventdata, handles)
% hObject    handle to Nivel_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%---------------------------------------------------------------------------
%-- 2. VISUALIZACIÓN DEL JUEGO AL PRESIONAR EL BOTÓN DE INICIAR JUEGO -----
%---------------------------------------------------------------------------
 
% Volvemos visible o invisible las componentes del axis -------------------------------
set(handles.Nivel_1,'visible', 'off');  %Ponemos invisible el boton de iniciar nivel 1
set(handles.Dilatacion ,'visible', 'on');    %Ponemos visible el axis de la dilatacion y erosion
set(handles.Camara ,'visible', 'on');        %Ponemos visible el axis de la cámara
set(handles.text1 ,'visible', 'on');         %Ponemos visible el texto que dice "Puntaje"
set(handles.puntajeview ,'visible', 'on');   %Ponemos visible el cuadro que lleva el puntaje
%---------------------------------------------------------------------------------------

%--------------------------------------------------------------------------
%-- 3. DEFINICIÓN DE VARIABLES --------------------------------------------
%--------------------------------------------------------------------------

% Declaracion de sonidos---------------------------------------------------
[yComer,FsComer] = audioread('./Sonidos/Comer.mp3');
[yInicio,FsInicio] = audioread('./Sonidos/Pacman_inicio.mp3');
[yPlay,FsPlay] = audioread('./Sonidos/Pacman_Jugando.mp3');
 
% Reproducimos un sonido al presionar el boton de Iniciar Juego-------------
sound(yInicio,FsInicio);
 
global ValorSensibilidad;   % Declaramos esta variable global para calibrar la sensibilidad del juego
global puntaje;             % Declaramos esta variable global para llevar el puntaje acumulado
 
% Se inicializan variables-------------------------------------------------
flagBocaAbierta=0;  % Bandera que me indica si la boca está abierta o cerrada
musica_fondo=400;   % Constante que indica la duracion de la musica de fondo
k=0;                % variable utilizada para el movimiento del hongo
puntaje=0;          % variable que se utiliza para llevar el puntaje del juego

%--------------------------------------------------------------------------
%-- 4. DECLARACIÓN DE LAS IMÁGENES UTILIZADAS EN EL JUEGO -----------------
%--------------------------------------------------------------------------
 
% Fondo del juego----------------------------------------------------------
fondojuego=imread('./Imagenes/bgjuego.png');   % Leemos la imagen 
FondoOriginal=fondojuego; % La imagen es de 428px por 239px
 
% Imagen del hongo---------------------------------------------------------
hongo=imread('./Imagenes/hongo.png');   % Leemos la imagen
hongo=imresize(hongo, [60,60]);   % Reducimos la imagen a 60px por 60px
 
% Fragmento del hongo------------------------------------------------------
fraccionHongo=hongo(1:60,11:60,1:3);   % Recortamos la imagen del hongo
 
% Imagen que muestra el nivel del juego------------------------------------
nivel1=imread('./Imagenes/nivel1.jpg');   % Leemos la imagen
nivel1=imresize(nivel1, [60,60]);   % Reducimos la imagen a 60px por 60px
 
% Imagen del pacman con la boca abierta------------------------------------
pacmanAbierto=imread('./Imagenes/pacmanabierto.png');   % Leemos la imagen
pacmanAbierto=imresize(pacmanAbierto, [60,60]);   % Reducimos la imagen a 60px por 60px
 
% Imagen del pacman con la boca cerrada------------------------------------
pacmanCerrado=imread('./Imagenes/pacmancerrado.png');   % Leemos la imagen
pacmanCerrado=imresize(pacmanCerrado, [60,60]);   % Reducimos la imagen a 60px por 60px
 
% Imagen de los corazones de las vidas
vidas=imread('./Imagenes/corazones.png');   % Leemos la imagen
vidas=imresize(vidas, [30,30]);   % Reducimos la imagen a 60px por 60px

% Con estas líneas de comando puedes averiguar las caracteristicas de la
% cámara instalada en tu pc
%  imaqhwinfo
%  imaqhwinfo('winvideo')
%  imaqhwinfo('winvideo',1)
%  imaqtool para ver un preview en las camaras que tengamos

%--------------------------------------------------------------------------
%-- 5. CONFIGURACIÓN DE LA CAPTURA DEL VIDEO ------------------------------
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
%-- 6. INICIO DE FUNCIONES ------------------------------------------------
%--------------------------------------------------------------------------
 
while(1) % Ciclo infinito donde se encuentra gran parte del desarrollo del juego
    
    % Control repetitivo de la musica de fondo-----------------------------
    if musica_fondo == 400
        sound(yPlay,FsPlay); % Se actvida el sonido del juego
        musica_fondo = 0;
    end
    musica_fondo = musica_fondo+1;
    %----------------------------------------------------------------------
    
    %----------------------------------------------------------------------
    %-- 7. CAPTURA DE IMAGEN DEL VIDEO ------------------------------------
    %----------------------------------------------------------------------
    
    b=getsnapshot(a);           % Tomamos capturas con la cámara
    c=rgb2gray(b);              % Pasamos la captura a escala de grises
    recuadro=b;
    recuadro=flip(recuadro,2); % Se invierte la imagen para que parezca espejo
    
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
    %-- 8. APERTURA BINARIA -----------------------------------------------
    %----------------------------------------------------------------------
    
    % La apertura consiste en realizar una erosion y posteriormente una dilatacion
    seErosion = strel('diamond',2);     % Tomamos la figura de diamante como elemento estructura para la erosión porque nos pareció la más adecuada para esta situación
    seDilatacion = strel('octagon',6);  % Tomamos la figura octágono como elemento estructura para la dilatación porque nos pareció la más adecuada para esta situación
    
    % Realizamos la Erosión------------------------------------------------
    erosion=imerode(negativo,seErosion); 
    
    % Realizamos la dilatación---------------------------------------------
    dilatacion = imdilate(erosion,seDilatacion);
    
    %----------------------------------------------------------------------
    %-- 9. DIBUJAMOS LAS IMAGENES DEL JUEGO -------------------------------
    %----------------------------------------------------------------------
    
    % Dibujamos la imagen que indica el nivel actual del juego-------------
    for i=1:1:60
        for j=1:1:60
            if(nivel1(i,j,1)<150 && nivel1(i,j,2)<150 && nivel1(i,j,3)>150) % Aquí elimino el fondo azul de la imagen para que solo aparezca la figura
            else
                fondojuego(15+i,30+j,1:3)=nivel1(i,j,1:3); % Dibujo pixel a pixel la imagen sobre el fondo del juego
            end
        end
    end
    % ---------------------------------------------------------------------
 
    % Dibujamos las vidas que tiene el jugador ----------------------------
    for i=1:1:30
        for j=1:1:30
            if(vidas(i,j,1)<150 && vidas(i,j,2)<150 && vidas(i,j,3)>150) % Aquí elimino el fondo azul de la imagen para que solo aparezca la figura
            else
                fondojuego(20+i,300+j,1:3)=vidas(i,j,1:3); % Dibujo pixel a pixel la imagen sobre el fondo del juego
                fondojuego(20+i,340+j,1:3)=vidas(i,j,1:3); % Dibujo pixel a pixel la imagen sobre el fondo del juego
                fondojuego(20+i,380+j,1:3)=vidas(i,j,1:3); % Dibujo pixel a pixel la imagen sobre el fondo del juego
            end
        end
    end
    % ---------------------------------------------------------------------
 
    % Las figuras las vemos como una matriz de 60x60---------------------------
    for i=1:1:60
        for j=1:1:60
            
    % ------------------- HONGO EN MOVIMIENTO ---------------------------------
    % -------------------------------------------------------------------------
    % El desplazamiento solo será en el eje x y se moverá de 30px en 30px  ----
    % Recordemos que en matlab las coordenadas son del orden (y,x)         ----
    % -------------------------------------------------------------------------
            if(hongo(i,j,1)<150 && hongo(i,j,2)<150 && hongo(i,j,3)>150) % Aquí elimino el fondo azul de la imagen para que solo aparezca la figura
            else
                if k>270 % Cuando k sea mayor a 270 no grafica el hongo completo sino el hongo fraccion
                else
                    fondojuego(125+i,320+j-k,1:3)=hongo(i,j,1:3); % Dibujamos Hongo en la posicion y=125, x=320 y a partir de ahí se moverá
                    fondojuego(125+i,320+j-k+30,1:3)=FondoOriginal(125+i,320+j-k+30,1:3); % Dibujamos el fondo en la posición anterior del hongo para ver el efecto del movimiento                 
                end   
            end
    % ------------------- HONGO EN MOVIMIENTO ---------------------------------
 
    % 240 es la posicion en x, en donde la mitad del hongo esta dentro del pacman
    % 270 es la posicion en x, en donde el hongo esta sobre el pacman

    %---------------- DIBUJO DE LOS PACMAN Y HONGO ----------------------------
            if(dilatacion==regionNegra)  % Si no hay apertura de boca (Pacman cerrado)
                
                flagBocaAbierta=0; % Bandera que indica que no hay apertura de boca
                
                if (k<240 || k>270) % Limpia lo que está dentro del pacman
                    fondojuego(125+i,50+j,1:3)=FondoOriginal(125+i,50+j,1:3); % Limpiamos el fondo
                end
                
                if (pacmanCerrado(i,j,1)<150 && pacmanCerrado(i,j,2)<150 && pacmanCerrado(i,j,3)>150) % Aquí elimino el fondo azul de la imagen para que solo aparezca la figura
                else
                    if (k==240 || k==270) % El hongo sobre el pacman
                        fondojuego(125+i,320+j-k,1:3)=hongo(i,j,1:3);
                    else
                        fondojuego(125+i,50+j,1:3)=pacmanCerrado(i,j,1:3); % Dibujamos Pacman cerrado
 
                        if (k==300 && j<51) % El j menor a 51 es porque la imagen fraccion hongo tiene 50px de ancho
                            if(fraccionHongo(i,j,1)<150 && fraccionHongo(i,j,2)<150 && fraccionHongo(i,j,3)>150)
                            else
                                fondojuego(125+i,j,1:3)=fraccionHongo(i,j,1:3); % Fraccion de hongo saliendo de la pantalla
                            end
                        end
 
                        if (k>300 && j<51) % Cuando k sea mayor a 300 limpia la fraccion de hongo puesta anteriormente
                            fondojuego(125+i,j,1:3)=FondoOriginal(125+i,j,1:3); % Limpiamos el fondo
                        end
                    end   
                end
                
            else
                flagBocaAbierta=1; % Bandera que indica que hay apertura de boca (Pacman abierto)
                if (k<240 || k>270) % Limpia lo que está dentro del pacman
                    fondojuego(125+i,50+j,1:3)=FondoOriginal(125+i,50+j,1:3); % Limpiamos el fondo
                end
                
                if (k>300 && j<51) % Para la limpiar la fraccion de hongo que pudo haber quedado cuando el pacman tenía la boca cerrada                   
                    fondojuego(125+i,j,1:3)=FondoOriginal(125+i,j,1:3);  % Limpiar el fondo
                end
 
                if (pacmanAbierto(i,j,1)<150 && pacmanAbierto(i,j,2)<150 && pacmanAbierto(i,j,3)>150) % Aquí elimino el fondo azul de la imagen para que solo aparezca la figura
                else
                    fondojuego(125+i,50+j,1:3)=pacmanAbierto(i,j,1:3); % Dibujamos Pacaman abierto
                end
            end
    %---------------- DIBUJO DE LOS PACMAN Y HONGO ----------------------------            
        end    
    end          
    
% Cuando k>300 el hongo desaparecerá --------------------------------------
 
    if (k>300)
       k=0;
    end 
 
    if k<300
        k=k+30;
    else
        k=k+1;
    end 
% ------------------------------------------------------------------------

% -------------------------------------------------------------------------    
%-- 10. PUNTAJE DEL JUEGO -------------------------------------------------
% ------------------------------------------------------------------------- 
    if (k==300)                         % Cuando el hongo bueno está encima del pacman y se lo traga
        if flagBocaAbierta==1
            sound(yComer,FsComer);      % Sonido que se activa cuando el pacman se come un hongo
            puntaje = puntaje+1;        % Aumentamos el puntaje
            puntajefinal=num2str(puntaje); % Convertimos una matriz numérica en una matriz de caracteres que representa los números
            set(handles.puntajeview, 'string', puntajefinal);   % Enviamos el puntaje actual al cuadro que muestra el puntaje en el juego
        end
    end
% -------------------------------------------------------------------------
 
% -------------------------------------------------------------------------    
%-- 11. PASAR AL SIGUIENTE NIVEL ------------------------------------------
% ------------------------------------------------------------------------- 
 
if(puntaje==2)              % Si acumulas 3 puntos pasas al siguiente nivel
    clear sound;            % Paramos el sonido del juego
    close(Nivel_1)    % Cerramos el archivo actual
    Nivel_2                 % Abrimos el archivo del siguiente nivel
end
 
%-------------------------------------------------------------------------
    
    % Enviamos la imagen de fondo al axis "ImaFondo"
    axes(handles.ImaFondo) 
    imshow(fondojuego)
 
    % Enviamos los captures de la camara al axis "Camara"
    axes(handles.Camara)
    imshow(recuadro)
    
    % Enviamos la imagen de la dilatacion al axis "Dilatacion"
    axes(handles.Dilatacion)
    imshow(dilatacion)     
    
end
 
% --- Executes during object creation, after setting all properties.
function Camara_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Camara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Camara


% --- Executes during object creation, after setting all properties.
function Dilatacion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dilatacion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Dilatacion

% --- Executes during object creation, after setting all properties.
function ImaFondo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImaFondo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate ImaFondo
