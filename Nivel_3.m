function varargout = Nivel_3(varargin)
% NIVEL_3 MATLAB code for Nivel_3.fig
%      NIVEL_3, by itself, creates a new NIVEL_3 or raises the existing
%      singleton*.
%
%      H = NIVEL_3 returns the handle to a new NIVEL_3 or the handle to
%      the existing singleton*.
%
%      NIVEL_3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NIVEL_3.M with the given input arguments.
%
%      NIVEL_3('Property','Value',...) creates a new NIVEL_3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Nivel_3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Nivel_3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
 
% Edit the above text to modify the response to help Nivel_3
 
% Last Modified by GUIDE v2.5 23-Jul-2019 09:39:44
 
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Nivel_3_OpeningFcn, ...
                   'gui_OutputFcn',  @Nivel_3_OutputFcn, ...
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
 
 
% --- Executes just before Nivel_3 is made visible.
function Nivel_3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Nivel_3 (see VARARGIN)
 
% Choose default command line output for Nivel_3
handles.output = hObject;
 
% Update handles structure
guidata(hObject, handles);
 
%--------------------------------------------------------------------------
%-- 1. VISUALIZACIÓN DEL JUEGO AL EMPEZAR ---------------------------------
%--------------------------------------------------------------------------
 
% Fondo de introducción del juego------------------------------------------
axes(handles.ImaFondo)
imshow('./Imagenes/LevelUp.jpg')
 
% Volvemos visible o invisible las componentes del axis al iniciar al programa ------------------
set(handles.Nivel_3,'visible', 'on');        %Ponemos visible el boton de iniciar nivel 3
set(handles.Dilatacion ,'visible', 'off');   %Ponemos invisible el axis de la dilatacion y erosion
set(handles.text1 ,'visible', 'off');        %Ponemos invisible el texto que dice "Puntaje"
set(handles.puntajeview ,'visible', 'off');  %Ponemos invisible el cuadro que lleva el puntaje
set(handles.Camara ,'visible', 'off'); %Ponemos invisible el axis de la cámara
%--------------------------------------------------------------------------
 
 
% --- Outputs from this function are returned to the command line.
function varargout = Nivel_3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Get default command line output from handles structure
varargout{1} = handles.output;
 
% --- Executes on button press in Nivel_3.
function Nivel_3_Callback(hObject, eventdata, handles)
% hObject    handle to Nivel_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
%---------------------------------------------------------------------------
%-- 2. VISUALIZACIÓN DEL JUEGO AL PRESIONAR EL BOTÓN DE INICIAR NIVEL 3 ---
%---------------------------------------------------------------------------
 
% Volvemos visible o invisible las componentes del axis -----------------------------
set(handles.Nivel_3,'visible', 'off');       %Ponemos invisible el boton de iniciar nivel 3
set(handles.Dilatacion ,'visible', 'on');    %Ponemos visible el axis de la dilatacion y erosion
set(handles.text1 ,'visible', 'on');         %Ponemos visible el texto que dice "Puntaje"
set(handles.puntajeview ,'visible', 'on');   %Ponemos visible el cuadro que lleva el puntaje
set(handles.Camara ,'visible', 'on'); %Ponemos visible el axis de la cámara
%--------------------------------------------------------------------------
 
%--------------------------------------------------------------------------
%-- 3. DEFINICIÓN DE VARIABLES --------------------------------------------
%--------------------------------------------------------------------------
 
% Declaracion de sonidos---------------------------------------------------
[yComer,FsComer] = audioread('./Sonidos/Comer.mp3');
[yPlay,FsPlay] = audioread('./Sonidos/Pacman_Jugando.mp3');
[yInicio,FsInicio] = audioread('./Sonidos/Pacman_inicio.mp3');
[yChoque,FsChoque] = audioread('./Sonidos/Pierde_vida.mp3');
 
% Reproducimos un sonido al presionar el boton de IniciarJuego-------------
sound(yInicio,FsInicio);
 
global ValorSensibilidad;   % Declaramos esta variable global para calibrar la sensibilidad del juego
global puntaje;             % Declaramos esta variable global para llevar el puntaje acumulado
global puntaje_vidas;       % Declaramos esta variable global para llevar el conteo de las vidas

% ------------- VARIABLES PARA PINTAR EL CUADRO ROJO ------------------
global xCent;           % Coordenada en x del centroide de los objetos verdes
global yCent;           % Coordenada en y del centroide de los objetos verdes
global Xcuadrado;       % Coordenada en x que determina la ubicacion del cuadrado rojo
global Ycuadrado;       % Coordenada en y que determina la ubicacion del cuadrado rojo
global WidthCuadrado;   % Ancho del cuadrado rojo
global HighCuadrado;    % Alto del cuadrado rojo
%--------------------------------------------------------------------

% Se inicializan variables-------------------------------------------------
WidthCuadrado = 30;
HighCuadrado = 30;
Xcuadrado = 65;
Ycuadrado = 80;
disparo=0;          % Variable que se utiliza para indicar cuando hubo un disparo
flagBocaAbierta=0;  % Bandera que me indica si la boca del pacman está abierta o cerrada
musica_fondo=400;   % Constante que indica la duracion de la musica de fondo
p=0;                % variable utilizada para el movimiento del hongo malo 
p2=0;               % variable utilizada para el movimiento del segundo hongo malo
k=0;                % variable utilizada para el movimiento del hongo bueno
flag=0;             % Bandera utilizada para arrancar con el movimiento del primer hongo malo
flag2=0;            % Bandera utilizada para arrancar con el movimiento del segundo hongo malo
flag_aux=0;         % Banderas auxiliares que me indicará si el primer hongo malo fue destruido
flag_aux2=0;        % Banderas auxiliares que me indicará si el segundo hongo malo fue destruido 

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
 
% Imagen del hongo malo----------------------------------------------------
hongo_malo=imread('./Imagenes/malo.jpg'); % Leemos la imagen
HongoMalo=imresize(hongo_malo, [60,60]); % Reducimos la imagen a 60px por 60px
 
% Imagen que muestra el nivel del juego------------------------------------
nivel1=imread('./Imagenes/nivel3.jpg');   % Leemos la imagen
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
    
    imagen1 = getsnapshot(a);   % Tomamos capturas con la cámara
    
    %--------------------------------------------------------------------------
    %-- 8. FUNCIONES PARA RECONOCER EL COLOR VERDE EN LA IMAGEN ---------------
    %--------------------------------------------------------------------------
    
    if(p>150 || p2>150)
        imagen = flip(imagen1,2);   % Creamos efecto espejo
        [fil,col,cap]=size(imagen); % Tamaño de fila, columna y capas

        % Debemos extraer el color verde de la imagen en escala de grises de la imagen adquirida en 'imagen'
        diff_im = imsubtract(imagen(:,:,2), rgb2gray(imagen)); % La función 'imsubstract' resta las matrices, sirve para sacar algun valor constante 
        % de una imagen, usamos como argumento el array de imagen y el array de la imagen en grises

        % Se usa medfilt2 para filtrar la senial del ruido 
        diff_im = medfilt2(diff_im, [3 3]); % 'medfilt2(A, [m n])' realiza el filtrado mediana, donde cada pixel de salida contiene el valor de la 
        % mediana en el m-por- n barrio alrededor del píxel correspondiente en la imagen de entrada.

        % Convertir la imagen de escala de grises a una imagen binaria.
        diff_im = im2bw(diff_im,0.12); % 'im2bw(I, level)' convierte la imagen de escala de grises I  en una imagen binaria. La imagen de salida BW 
        %reemplaza todos los píxeles de la imagen de entrada con la luminancia mayor que en level con el valor de 1 (blanco) y reemplaza a todas las 
        %demás pixeles con el valor 0 (negro). Especificar level en el intervalo [0,1]. 

        diff_im = bwareaopen(diff_im,300); % Determina el tamaño a reconocer, se usa 'bwareopen' para descartar objetos verdes de menos de 300 pixels

        binaria = bwlabel(diff_im, 8); % Etiquetamos los elementos conectados en la imagen

        objetos = regionprops(binaria, 'BoundingBox', 'Centroid'); % Calculamos las medidas del centroide y del 'BoundingBox' (rectángulo más pequeño 
        %que contiene la región, devuelto como un vector) 

        axes(handles.Camara)
        imshow(imagen)
        hold on

        % Pintamos el cuadrado de color rojo con los siguientes argumentos ----
        rectangle('Position',[Xcuadrado,Ycuadrado,WidthCuadrado,HighCuadrado],...
                'Curvature',[0,0],...
                'EdgeColor', 'r',...
                'LineWidth', 1,...
                'FaceColor', 'r',...
                'LineStyle','-')
        % ---------------------------------------------------------------------

        % Dibujamos un rectangulo rojo alrededor de los objetos verdes que la
        % camara reconozca
         for object = 1:length(objetos)
            bb = objetos(object).BoundingBox;%rectángulo alrededor del objeto
            bc = objetos(object).Centroid;%coordenadas del centro del objeto
            rectangle('Position',bb,'EdgeColor','r','LineWidth',3)
            plot(bc(1),bc(2), '-m+')

            xCent=(round(bc(1))); % coordenada en x centroide del objeto
            yCent=(round(bc(2))); % coordenada en y centroide del objeto

            % Si el centroide del objeto verde está dentro del cuadrado rojo
            % entonces se realizará un disparo
            if (xCent>Xcuadrado && xCent<Xcuadrado+WidthCuadrado && yCent>Ycuadrado && yCent<Ycuadrado+HighCuadrado)
                disparo=1;
                Xcuadrado=round(4*rand)*WidthCuadrado; % Genera números enteros aleatorios entre 0 y 7 y lo multiplica por el numero de pixeles de columnas
                Ycuadrado=round(3*rand)*HighCuadrado; % Genera números enteros aleatorios entre 0 y 7 y lo multiplica por el numero de pixeles de filas
            end
         end
    end
    %----------------------------------------------------------------------
    
    c=rgb2gray(imagen1);        % Pasamos la captura a escala de grises
    recuadro=imagen1;
    recuadro=flip(recuadro,2);  % Se invierte la imagen para que parezca espejo
    
    % Dibujamos un cuadro rojo en donde se debe realizar la apertura o cierrde de la boca del jugador
    recuadro(71:72,60:100,1)=255;
    recuadro(71:100,60:61,1)=255;
    recuadro(71:100,99:100,1)=255;
    recuadro(100:101,60:100,1)=255;
    
    if(k>180 && k<300)
        axes(handles.Camara)
        imshow(recuadro)
    end
    
    if(k<180 && p<150 && p2<150)
        axes(handles.Camara)
        imshow(recuadro)
    end
    % ---------------------------------------------------------------------
    
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
    %-- 9. APERTURA BINARIA -----------------------------------------------
    %----------------------------------------------------------------------
    
    % La apertura consiste en realizar una erosion y posteriormente una dilatacion
    seErosion = strel('diamond',2);     % Tomamos la figura de diamante como elemento estructura para la erosión porque nos pareció la más adecuada para esta situación
    seDilatacion = strel('octagon',6);  % Tomamos la figura octágono como elemento estructura para la dilatación porque nos pareció la más adecuada para esta situación
    
    % Realizamos la Erosión------------------------------------------------
    erosion=imerode(negativo,seErosion); 
    
    % Realizamos la dilatación---------------------------------------------
    dilatacion = imdilate(erosion,seDilatacion);
    
    %----------------------------------------------------------------------
    %-- 10. DIBUJAMOS LAS IMAGENES DEL JUEGO -------------------------------
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
 
    % Dibujamos dibujamos las vidas que tiene el jugador ----------------------
        for i=1:1:30
            for j=1:1:30
                if(vidas(i,j,1)<150 && vidas(i,j,2)<150 && vidas(i,j,3)>150)  % Aquí elimino el fondo azul de la imagen para que solo aparezca la figura
                else
                    fondojuego(20+i,300+j,1:3)=vidas(i,j,1:3); % Dibujo pixel a pixel la imagen sobre el fondo del juego
                    fondojuego(20+i,340+j,1:3)=vidas(i,j,1:3); % Dibujo pixel a pixel la imagen sobre el fondo del juego
                    fondojuego(20+i,380+j,1:3)=vidas(i,j,1:3); % Dibujo pixel a pixel la imagen sobre el fondo del juego
                end
                if(puntaje_vidas==1)
                    fondojuego(20+i,300+j,1:3)=FondoOriginal(20+i,300+j,1:3); % Se elimina una vida cuando el hongo malo alcanza al pacman
                elseif(puntaje_vidas==2)
                    fondojuego(20+i,300+j,1:3)=FondoOriginal(20+i,300+j,1:3); % Se elimina una vida cuando el hongo malo alcanza al pacman
                    fondojuego(20+i,340+j,1:3)=FondoOriginal(20+i,340+j,1:3); % Se elimina una vida cuando el hongo malo alcanza al pacman
                elseif(puntaje_vidas==3)
                    fondojuego(20+i,300+j,1:3)=FondoOriginal(20+i,300+j,1:3); % Se elimina una vida cuando el hongo malo alcanza al pacman
                    fondojuego(20+i,340+j,1:3)=FondoOriginal(20+i,340+j,1:3); % Se elimina una vida cuando el hongo malo alcanza al pacman
                    fondojuego(20+i,380+j,1:3)=FondoOriginal(20+i,380+j,1:3); % Se elimina una vida cuando el hongo malo alcanza al pacman
                end
            end
        end
    % -------------------------------------------------------------------------
 
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
    % ------------------- HONGO EN MOVIMIENTO -----------------------------
 
    % ------------------- HONGO MOVIMIENTO --------------------------------  
            if(flag==1) % Hongo malo
                if disparo==0
                    if(HongoMalo(i,j,1)<150 && HongoMalo(i,j,2)<150 && HongoMalo(i,j,3)>150) % Aquí elimino el fondo azul de la imagen para que solo aparezca la figura
                    else
                        fondojuego(125+i,320+j-p,1:3)=HongoMalo(i,j,1:3); % Dibujamos Hongo Malo en la posicion y=125, x=320 y a partir de ahí se moverá
                        fondojuego(125+i,320+j-p+30,1:3)=FondoOriginal(125+i,320+j-p+30,1:3); % Dibujamos el fondo en la posición anterior del hongo malo para ver el efecto del movimiento
                    end
                else 
                    fondojuego(125+i,320+j-p+30,1:3)=FondoOriginal(125+i,320+j-p+30,1:3); % Se dibuja el fondo del juego en la última posición del hongo malo para dar el efecto de eliminado
                    flag_aux=1;
                end
            end
    % ------------------- HONGO MOVIMIENTO ------------------------------------
 
    % ------------------- HONGO MOVIMIENTO --------------------------------  
            if(flag2==1) % Hongo malo
                if disparo==0
                    if(HongoMalo(i,j,1)<150 && HongoMalo(i,j,2)<150 && HongoMalo(i,j,3)>150) % Aquí elimino el fondo azul de la imagen para que solo aparezca la figura
                    else
                        fondojuego(125+i,320+j-p2,1:3)=HongoMalo(i,j,1:3); % Dibujamos Hongo Malo en la posicion y=125, x=320 y a partir de ahí se moverá
                        fondojuego(125+i,320+j-p2+30,1:3)=FondoOriginal(125+i,320+j-p2+30,1:3); % Dibujamos el fondo en la posición anterior del hongo malo para ver el efecto del movimiento
                    end
                else 
                    fondojuego(125+i,320+j-p2+30,1:3)=FondoOriginal(125+i,320+j-p2+30,1:3); % Se dibuja el fondo del juego en la última posición del hongo malo para dar el efecto de eliminado
                    flag_aux2=1;
                end
            end
    % ------------------- HONGO MOVIMIENTO ------------------------------------
 
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
    
    % ---------------------------------------------------------------------    
    %-- 11. CONDICIÓN DE DISPARO ------------------------------------------
    % --------------------------------------------------------------------- 
    if disparo==1
        display('DISPARÉ');
        disparo=0;
        if(flag==1 && flag_aux==1) % Si el primer hongo malo estaba en la pista
            p=0;
            flag=0;
            flag_aux=0;
        elseif(flag2==1 && flag_aux2==1) % Si el segundo hongo malo estaba en la pista
            p2=0;
            flag2=0;
            flag_aux2=0;
        end
    end
    % ------------------------------------------------------------------------ 
    
    % Cuando k=300 el hongo desaparecerá -------------------------------------
 
    if (k>300) % Si k (el contador del hongo bueno) es mayor a 300 se reinicia
       k=0;
    end 
 
    if k<300  % Si k (el contador del hongo bueno) es menor a 300 va aumentando de 30 en 30
        k=k+30;
    else
        k=k+1;
    end 
    % ------------------------------------------------------------------------
 
 
    %--------- Condiciones para el hongo malo ------------------
    if (k==150) % Cuando k (el contador del hongo bueno) sea igual a 150 se activa la bandera flag
        flag=1;
    end
 
    if(flag==1) % Si la bandera flag es igual a 1 el contador p del primer hongo malo empieza a aumentar de 30 en 30
        p=p+30;
    end
    
    if (p>=300) % Reiniciamos el contador p cuando sea igual o mayor a 300 junto con su respectiva bandera
        p=0;
        flag=0;
    end 
    % -----------------------------------------------------------  
    
    if (k==270) % Cuando k (el contador del hongo bueno) sea igual a 270 se activa la bandera flag2
        flag2=1;
    end
 
    if(flag2==1) % Si la bandera flag2 es igual a 1 el contador p2 del segundo hongo malo empieza a aumentar de 30 en 30
        p2=p2+30;
    end
    
    if (p2>=300) % Reiniciamos el contador p cuando sea igual o mayor a 300 junto con su respectiva bandera
        p2=0;
        flag2=0;
    end 
 
    % ---------------------------------------------------------------------    
    %-- 12. PIERDES VIDAS -------------------------------------------------
    % --------------------------------------------------------------------- 
    if(p==270 || p2==270) % Cuando el hongo malo 1 o el hongo malo 2 tocan el pacman, se pierde una vida
        puntaje_vidas=puntaje_vidas+1;
        sound(yChoque,FsChoque); % Se activa el sonido de perder vida
    end
    %------------------------------------------------------------------------- 
    
    % ---------------------------------------------------------------------    
    %-- 13. PUNTAJE DEL JUEGO ---------------------------------------------
    % --------------------------------------------------------------------- 
    if (k==300)
        if flagBocaAbierta==1
            sound(yComer,FsComer);      % Sonido que se activa cuando el pacman se come un hongo
            puntaje = puntaje+1;        % Aumentamos el puntaje
            puntajefinal=num2str(puntaje); % Convertimos una matriz numérica en una matriz de caracteres que representa los números
            set(handles.puntajeview, 'string', puntajefinal);   % Enviamos el puntaje actual al cuadro que muestra el puntaje en el juego
        end
    end
    % -------------------------------------------------------------------------
    
    % ---------------------------------------------------------------------
    %-- 14. GANASTE EL JUEGO ----------------------------------------------
    % --------------------------------------------------------------------- 
 
    if(puntaje==8)          % Cuando acumulas 9 puntos ganas 
        clear sound;        % Paramos el sonido del juego
        close(Nivel_3)      % Cerramos el archivo actual
        Ganaste             % Abrimos el archivo de Ganaste
    end
 
    %-------------------------------------------------------------------------
 
    % ---------------------------------------------------------------------
    %-- 15. FIN DEL JUEGO ------------------------------------------------
    % --------------------------------------------------------------------- 
 
    if(puntaje_vidas==3)    % Cuando pierdes las 3 vidas 
        clear sound;        % Paramos el sonido del juego
        close(Nivel_3)      % Cerramos el archivo actual
        GameOver            % Abrimos el archivo de Game Over
    end
    %----------------------------------------------------------------------
    
    % Enviamos la imagen de fondo al axis "ImaFondo"
    axes(handles.ImaFondo) 
    imshow(fondojuego)
    
    % Enviamos la imagen de la dilatacion al axis "Dilatacion"
    axes(handles.Dilatacion)
    imshow(dilatacion)     
    
end
 
% --- Executes during object creation, after setting all properties.
function ImaFondo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImaFondo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: place code in OpeningFcn to populate ImaFondo
 
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
