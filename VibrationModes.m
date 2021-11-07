function varargout = Interfaz22(varargin)
% VIBRATIONMODES MATLAB code for VibrationModes.fig
%      VIBRATIONMODES, by itself, creates a new VIBRATIONMODES or raises the existing
%      singleton*.
%
%      H = VIBRATIONMODES returns the handle to a new VIBRATIONMODES or the handle to
%      the existing singleton*.
%
%      VIBRATIONMODES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONMODES.M with the given input arguments.
%
%      VIBRATIONMODES('Property','Value',...) creates a new VIBRATIONMODES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VibrationModes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VibrationModes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VibrationModes

% Last Modified by GUIDE v2.5 06-Nov-2021 19:40:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VibrationModes_OpeningFcn, ...
                   'gui_OutputFcn',  @VibrationModes_OutputFcn, ...
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


% --- Executes just before VibrationModes is made visible.
function VibrationModes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VibrationModes (see VARARGIN)

colorbar(handles.MODOS)
colormap jet;
rotate3d on;
a = colorbar(handles.MODOS);
a.Label.Position(1) = 3.3;
ylabel(a,'SPL (dB)','FontSize',12,'Rotation',270);

title(handles.MODOS,'Modos de Vibración de un Paralelepipedo');

title(handles.PA_VS_HZ,' SPL [dB] Vs Frecuencia [Hz] ');
ylabel(handles.PA_VS_HZ,' SPL [dB]');
xlabel(handles.PA_VS_HZ,' Frecuencia [Hz]');

title(handles.CURVA_D,'Curva D');
ylabel(handles.CURVA_D,' Dencidad Espectral ');
xlabel(handles.CURVA_D,' Tercios de Octava ');

% Choose default command line output for VibrationModes
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VibrationModes wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VibrationModes_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Graficar.
function Graficar_Callback(hObject, eventdata, handles)

Lx=get(handles.Lx,'string');
Lx=str2double(Lx);
Ly=get(handles.Ly,'string');
Ly=str2double(Ly);
Lz=get(handles.Lz,'string');
Lz=str2double(Lz);
Temp=get(handles.Temp,'string');
Temp=str2double(Temp);
K=get(handles.K,'string');
K=str2double(K);

if K > Lz
    disp("Corte en Z No puede ser mayor a Lz");
end

VS = (331.3)*sqrt(1+(Temp/273.15)); NN = 1;
nx = 0:1:10; ny = 0:1:10; nz = 0:1:10;
n =  0.01; x = 0:n:Lx; y = 0:n:Ly; h = 1;

Uno=0; Dos=0; Tres=0; Cuatro=0; Cinco=0; Seis=0; Siete=0; Ocho=0;
Nueve=0; Diez=0; Once=0; Doce=0; Trece=0; Catorce=0; Quince=0;
Dieciseis=0; Diecisiete=0; Dieciocho=0; Diecinueve=0; Veinte=0;
Veintiuno=0; Veintidos=0; Veintitres=0; Veinticuatro=0; Veinticinco=0;
Veintiseis=0; Veintisiete=0; Veintiocho=0; Nomatters=0;

S   = (2*(Lx*Ly))+(2*(Lz*Ly))+(2*(Lx*Lz));  % Superficie Total
Sp  = (2.40*0.93);                          % superficie de la puerta
spv = (0.58*0.30);                          % superficie de la ventana de la puerta
st  = (1.19*2.40);                          % superficie del tablero
Sv  = (1.85*1.40);                          % superficie de la ventana del muro
ST  = (S-(Sp+spv+st+Sv));                   % superficie total del lugar menos las otras superficies 
Cv  = 0.12;                                 % Coeficiente ventana De Vidrio Simple
Cp  = 0.09;                                 % Coeficiente De Absorcion De la Puerta
Cm  = 0.05;                                 % Coeficiente De La Pared
Ca  = 0.02;                                 % Coeficiente De Absorcion del aire
V   = Lx*Ly*Lz;                             % Volumen 

TR = 0.161*(V/((Cm*ST)+(Sp*Cp)+(spv*Cv)+(st*Cv)+(Sv*Cv)+(Ca*V))); % Calculo de sabine
sch =  (2000*(sqrt(TR/V))); % Frecuencia de schroeder

% freq = zeros(1,1331);

for i = 1:length(nx)
    for j = 1:length(ny)
        for k = 1:length(nz)
            freq(NN) = (VS/2)*sqrt(((nx(i)/Lx)^2)+((ny(j)/Ly)^2)+((nz(k)/Lz)^2));
            if freq(NN)<sch
               F(h)= freq(NN);
               Nx(h)= nx(i);
               Ny(h)= nx(j);
               Nz(h)= nz(k);
               h = h+1; 
            end 
            NN = NN + 1;     
        end
    end
end
   
PT = zeros(length(y),length(x));

 for I = 1:1:length(x)
     for J = 1:1:length(y)
         for u = 2:length(F)
             W =(2*pi)*F(u);
             P(J,I) = (W/sqrt(4*(W^2)))*((cos((Nx(u)*pi/Lx)*x(I)))*(cos((Ny(u)*pi/Ly)*y(J)))*(cos((Nz(u)*pi/Lz)*K)));    
         if P(J,I)<0
            P(J,I) = P(J,I)*(-1);
         end
             PT(J,I) = (PT(J,I)) + ((P(J,I))^2); 
         end
     end
 end
 
 w  = 0:2*pi*max(F);
 PP = zeros(1,length(F));
 PE = zeros(1,length(w));
 for qk = 2:length(F)
    Wn  = 2*pi*F(qk);
    for kq = 1:length(w)
        PP(kq) = (w(kq)/sqrt(4*(Wn^2)+(w(kq)^2-Wn^2)^2));
        PE(kq)= PE(kq)+PP(kq)^2;
    end
  

 end
 
BONELLO = sort(F);

for mod = 1:1:length(BONELLO)
    
    %%20
    if (0<=mod) && (mod<22.2976) && (mod<sch)
        
        Uno=Uno+1;
    
    %%25    
    elseif (22.2976<=mod) && (mod< 28.0933) && (mod<sch)
        
        Dos=Dos+1;
    
    %%31.5
    elseif (28.0933<=mod) && (mod<35.3953) && (mod<sch)
            
        Tres=Tres+1;
        
        
    %%40    
    elseif (35.3953<=mod) && (mod<44.5953) && (mod<sch)
        
        Cuatro=Cuatro+1;
        
        
    %%50   
    elseif (44.5953<=mod) && (mod<56.1866) && (mod<sch)
            
        Cinco=Cinco+1;
        
    %%63    
    elseif (56.1866<=mod) && (mod<70.7907) && (mod<sch)
        
        Seis=Seis+1;
        
    %%80    
    elseif (70.7907<=mod) && (mod<89.1907) && (mod<sch)
        
        Siete=Siete+1;
        
    %%100    
    elseif (89.1907<=mod) && (mod<112.3732) && (mod<sch)
        
        Ocho=Ocho+1;
        
    %%125    
    elseif (112.3732<=mod) && (mod<141.5814) && (mod<sch)
        
        Nueve=Nueve+1;
        
    %%160    
    elseif (141.5814<=mod) && (mod<178.3814) && (mod<sch)
        
        Diez=Diez+1;
    
    %200
    elseif (178.3814<=mod) && (mod<224.7465) && (mod<sch)
        
        Once=Once+1;
        
    %250
    elseif (224.7465<=mod) && (mod<283.1629) && (mod<sch)
        
        Doce=Doce+1;
            
    %315
    elseif (283.1629<=mod) && (mod<356.7629) && (mod<sch)
        
        Trece=Trece+1;
        
    %400
    elseif (356.7629<=mod) && (mod<449.4930) && (mod<sch)
        
        Catorce=Catorce+1;
        
    %500
    elseif (449.4930<=mod) && (mod<566.3258) && (mod<sch)
        
        Quince=Quince+1;
        
    %630
    elseif (566.3258<=mod) && (mod<713.5258) && (mod<sch)
        
        Dieciseis=Dieciseis+1;
        
    %800
    elseif (713.5258<=mod) && (mod<898.9861) && (mod<sch)
        
        Diecisiete=Diecisiete+1;
        
    %1k
    elseif (898.9861<=mod) && (mod<1132.6516) && (mod<sch)
        
        Dieciocho=Dieciocho+1;
        
    %1.25k
    elseif (1132.6516<=mod) && (mod<1427.0516) && (mod<sch)
        
        Diecinueve=Diecinueve+1;
        
    %1.6k
    elseif (1427.0516<=mod) && (mod<1797.9723) && (mod<sch)
        
        Veinte=Veinte+1;
        
    %2k
    elseif (1797.9723<=mod) && (mod<2265.3032) && (mod<sch)
        
        Veintiuno=Veintiuno+1;
        
    %2.5k
    elseif (2265.3032<=mod) && (mod<2854.1032) && (mod<sch)
        
        Veintidos=Veintidos+1;
    
    %3.15k
    elseif (2854.1032<=mod) && (mod<3595.9447) && (mod<sch)
        
        Veintitres=Veintitres+1;
    
    %4k
    elseif (3595.9447<=mod) && (mod<4530.6065) && (mod<sch)
        
        Veinticuatro=Veinticuatro+1;
    
    %5k
    elseif (4530.6065<=mod) && (mod<5708.2065) && (mod<sch)
        
        Veinticinco=Veinticinco+1;
    
    %6.3k
    elseif (5708.2065<=mod) && (mod<7191.8895) && (mod<sch)
        
        Veintiseis=Veintiseis+1;
     
    %8k
    elseif (7191.8895<=mod) && (mod<9061.2130) && (mod<sch)
        
        Veintisiete=Veintisiete+1;
    
    %10k
    elseif (9061.2130<=mod) && (mod<11416.4130) && (mod<sch)
        
        Veintiocho=Veintiocho+1;
        
    else
        
        Nomatters=Nomatters+1;
        
    end
        
    
end


surf(handles.MODOS,x,y,PT)
title(handles.MODOS,'Modos de Vibración de un Paralelepipedo');
ylabel(handles.MODOS,' Eje Y ');
xlabel(handles.MODOS,' Eje X ');
zlabel(handles.MODOS,' Eje Z ');
shading(handles.MODOS,'interp')
a = colorbar(handles.MODOS);
a.Label.Position(1) = 3.3;
ylabel(a,'SPL (dB)','FontSize',12,'Rotation',270);

colormap jet;
rotate3d on;
axis(handles.MODOS,'tight')








plot(handles.PA_VS_HZ,w/(2*pi),20*log10(PE./(2*10^-5)),'linewidth',1.6)
title(handles.PA_VS_HZ,' SPL [dB] Vs Frecuencia [Hz] ');
ylabel(handles.PA_VS_HZ,' SPL [dB]');
xlabel(handles.PA_VS_HZ,' Frecuencia [Hz]');
grid(handles.PA_VS_HZ)
axis(handles.PA_VS_HZ,'tight')

Final =[Uno Dos Tres Cuatro Cinco Seis Siete Ocho Nueve Diez Once Doce Trece];
%Catorce Quince Dieciseis Diecisiete Dieciocho Diecinueve Veinte Veintiuno Veintidos Veintitres Veinticuatro Veinticinco Veintiseis Veintisiete Veintiocho Nomatters];
TERCIOS = [20 25 31.5 40 50 63 80 100 125 160 200 250 315]; 
% 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000 20000]; 

plot(handles.CURVA_D,TERCIOS,Final,'linewidth',1.6)
title(handles.CURVA_D,'Curva D');
ylabel(handles.CURVA_D,' Dencidad Espectral ');
xlabel(handles.CURVA_D,' Tercios de Octava ');
grid(handles.CURVA_D)
axis(handles.CURVA_D,'tight')

% hObject    handle to Graficar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)

% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Lx_Callback(hObject, eventdata, handles)
% hObject    handle to Lx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Lx as text
%        str2double(get(hObject,'String')) returns contents of Lx as a double


% --- Executes during object creation, after setting all properties.
function Lx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Lx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ly_Callback(hObject, eventdata, handles)
% hObject    handle to Ly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ly as text
%        str2double(get(hObject,'String')) returns contents of Ly as a double


% --- Executes during object creation, after setting all properties.
function Ly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Lz_Callback(hObject, eventdata, handles)
% hObject    handle to Lz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Lz as text
%        str2double(get(hObject,'String')) returns contents of Lz as a double


% --- Executes during object creation, after setting all properties.
function Lz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Lz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function K_Callback(hObject, eventdata, handles)
% hObject    handle to K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of K as text
%        str2double(get(hObject,'String')) returns contents of K as a double


% --- Executes during object creation, after setting all properties.
function K_CreateFcn(hObject, eventdata, handles)
% hObject    handle to K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Temp_Callback(hObject, eventdata, handles)
% hObject    handle to Temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Temp as text
%        str2double(get(hObject,'String')) returns contents of Temp as a double


% --- Executes during object creation, after setting all properties.
function Temp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MDatos.
function MDatos_Callback(hObject, eventdata, handles)

Lx=get(handles.Lx,'string');
Lx=str2double(Lx);
Ly=get(handles.Ly,'string');
Ly=str2double(Ly);
Lz=get(handles.Lz,'string');
Lz=str2double(Lz);
Temp=get(handles.Temp,'string');
Temp=str2double(Temp);
K=get(handles.K,'string');
K=str2double(K);

VS = (331.3)*sqrt(1+(Temp/273.15));         % Velocidad Del Sonido 
S   = (2*(Lx*Ly))+(2*(Lz*Ly))+(2*(Lx*Lz));  % Superficie Total
Sp  = (2.40*0.93);                          % superficie de la puerta
spv = (0.58*0.30);                          % superficie de la ventanita de la puerta
st  = (1.19*2.40);                          % superficie del tablero
Sv  = (1.85*1.40);                          % superficie de la ventana
ST  = (S-(Sp+spv+st+Sv));                   % superficie total del lugar menos las otras superficies 
Cv  = 0.12;                                 % Coeficiente ventana De Vidrio Simple
Cp  = 0.09;                                 % Coeficiente De Absorcion De la Puerta
Cm  = 0.05;                                 % Coeficiente De La Pared
Ca  = 0.02;                                 % Coeficiente De Absorcion del aire
V   = Lx*Ly*Lz;                             % Volumen 

TR = 0.161*(V/((Cm*ST)+(Sp*Cp)+(spv*Cv)+(st*Cv)+(Sv*Cv)+(Ca*V))); % Calculo de sabine
sch =  (2000*(sqrt(TR/V))); % Frecuencia de schroeder

A = {'T60 [s]' 'Volumen [m^3]' 'Superficie [m^2]' 'sch [Hz]' 'V.Sonido [m/s]'};
B = {TR V S sch VS}; 
C = [A' B'];
set(handles.TABLA,'data',C);

% hObject    handle to MDatos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function TABLA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TABLA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
