function varargout = Projek_SCPK_FAHP(varargin)
% PROJEK_SCPK_FAHP MATLAB code for Projek_SCPK_FAHP.fig
%      PROJEK_SCPK_FAHP, by itself, creates a new PROJEK_SCPK_FAHP or raises the existing
%      singleton*.
%
%      H = PROJEK_SCPK_FAHP returns the handle to a new PROJEK_SCPK_FAHP or the handle to
%      the existing singleton*.
%
%      PROJEK_SCPK_FAHP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJEK_SCPK_FAHP.M with the given input arguments.
%
%      PROJEK_SCPK_FAHP('Property','Value',...) creates a new PROJEK_SCPK_FAHP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Projek_SCPK_FAHP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Projek_SCPK_FAHP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Projek_SCPK_FAHP

% Last Modified by GUIDE v2.5 05-Jul-2021 01:33:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Projek_SCPK_FAHP_OpeningFcn, ...
                   'gui_OutputFcn',  @Projek_SCPK_FAHP_OutputFcn, ...
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


% --- Executes just before Projek_SCPK_FAHP is made visible.
function Projek_SCPK_FAHP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Projek_SCPK_FAHP (see VARARGIN)

% Choose default command line output for Projek_SCPK_FAHP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Projek_SCPK_FAHP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Projek_SCPK_FAHP_OutputFcn(hObject, eventdata, handles) 
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
opts = detectImportOptions('ListDaftarKriteria.xlsx');
opts.SelectedVariableNames = (1:2);
dataDaftarKriteria = readmatrix('ListDaftarKriteria.xlsx', opts);

opts.SelectedVariableNames = (1:2);
dataBobotKriteria = readmatrix('BobotKriteria.xlsx', opts);

%opts = detectImportOptions('ListDaftarAlternatif.xlsx');
%opts.SelectedVariableNames = "1,3:7";
%dataListAlternatif = readmatrix('ListDaftarAlternatif.xlsx', opts);
%disp(length(dataListAlternatif));

[num, txt, colomA] = xlsread('ListDaftarAlternatif.xlsx','A2:A7');
[num, txt, colomB] = xlsread('ListDaftarAlternatif.xlsx','C2:G7');

global dataDaftarAlternatif;
global dataNamaAlternatif;
dataDaftarAlternatif = [colomA  colomB];

[num, txt, dataNamaAlternatif] = xlsread('ListDaftarAlternatif.xlsx','A2:G7');



%data = [{dataDaftarAlternatif(1, :)} }];

%disp(data{2});

set(handles.uitable4,'data',dataNamaAlternatif); %membaca file dan me
set(handles.uitable3,'data',dataDaftarAlternatif); %membaca file dan menampilkan pada tabel
set(handles.uitable2,'data',dataBobotKriteria); %membaca file dan menampilkan pada tabel
set(handles.uitable1,'data',dataDaftarKriteria); %membaca file dan menampilkan pada tabel


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global dataDaftarAlternatif;


for i=1:size(dataDaftarAlternatif, 1)
    data(i) = {dataDaftarAlternatif(i,:)};
    
    if string(data{i}(2)) == "Sangat Baik";
        PK(i) = 1;
    elseif string(data{i}(2)) == "Baik";
          PK(i) = 0.75;
    elseif string(data{i}(2)) == "Cukup";
          PK(i) = 0.5;
    elseif string(data{i}(2)) == "Kurang";
          PK(i) = 0.25;
    else string(data{i}(2)) == "Sangat Kurang";
          PK(i) = 0;
    end
    
    if string(data{i}(3)) == "Sangat Baik";
        IP(i) = 1;
    elseif string(data{i}(3)) == "Baik";
         IP(i) = 0.75;
    elseif string(data{i}(3)) == "Cukup";
          IP(i) = 0.5;
    elseif string(data{i}(3)) == "Kurang";
          IP(i) = 0.25;
    else string(data{i}(3)) == "Sangat Kurang";
         IP(i) = 0;
    end
    
     if string(data{i}(4)) == "Sangat Baik";
        KH(i) = 1;
    elseif string(data{i}(4)) == "Baik";
         KH(i) = 0.75;
    elseif string(data{i}(4)) == "Cukup";
          KH(i) = 0.5;
    elseif string(data{i}(4)) == "Kurang";
          KH(i) = 0.25;
    else string(data{i}(4)) == "Sangat Kurang";
         KH(i) = 0;
    end
    
    if string(data{i}(5)) == "Sangat Baik";
        TJ(i)  = 1;
    elseif string(data{i}(5)) == "Baik";
         TJ(i)  = 0.75;
    elseif string(data{i}(5)) == "Cukup";
          TJ(i)  = 0.5;
    elseif string(data{i}(5)) == "Kurang";
          TJ(i)  = 0.25;
    else string(data{i}(5)) == "Sangat Kurang";
         TJ(i)  = 0;
    end
    
    if string(data{i}(6)) == "Sangat Baik";
        KS(i) = 1;
    elseif string(data{i}(6)) == "Baik";
         KS(i) = 0.75;
    elseif string(data{i}(6)) == "Cukup";
          KS(i) = 0.5;
    elseif string(data{i}(6)) == "Kurang";
          KS(i) = 0.25;
    else string(data{i}(6)) == "Sangat Kurang";
         KS(i) = 0;
    end

end

global dataNamaAlternatif;
result = [];

namaAlternatif = dataNamaAlternatif(:,2);

data = [ PK.' IP.' KH.' TJ.' KS.' ];
relasiAntarKriteria = [ 1 5 3 5 2
                        0 1 1 4 1
                        0 0 1 5 1
                        0 0 0 1 1
                        0 0 0 0 1];

TFN = {[-100/3 0     100/3] [3/100 0     -3/100]
       [0      100/3 200/3] [3/200 3/100 0     ]
       [100/3  200/3 300/3] [3/300 3/200 3/100 ]
       [200/3  300/3 400/3] [3/400 3/300 3/200 ]
       [300/3  400/3 500/3] [3/500 3/400 3/300 ]
       [400/3  500/3 600/3] [3/600 3/500 3/400 ]
       [500/3  600/3 700/3] [3/700 3/600 3/500 ]
       [600/3  700/3 800/3] [3/800 3/700 3/200 ]};





disp("data = ");
disp( data);


[RasioKonsistensi] = HitungKonsistensiAHP(relasiAntarKriteria);
disp("Rasio Konsitensi : " + RasioKonsistensi);

if RasioKonsistensi < 0.10 
    % Metode Fuzzy AHP 
    [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN); 
    % Hitung nilai skor akhir 
    ahp = data * bobotAntarKriteria'; 
    disp('Hasil Perhitungan dengan metode Fuzzy AHP');
    disp('Nama Alternatif, Skor Akhir, Kesimpulan');
end

for i = 1:size(ahp, 1) 
    if ahp(i) < 0.4
        status = 'Kurang'; 
    elseif ahp(i) < 0.5 
        status = 'Cukup';
    elseif ahp(i) < 0.7 
        status = 'Baik';
    else
        status = 'Sangat Baik';
    end
    disp([char(namaAlternatif(i)), blanks(13 - cellfun('length',namaAlternatif(i))), ', ', ... 
        num2str(ahp(i)), blanks(10 - length(num2str(ahp(i)))), ', ', ... 
        char(status)]);
    
      x = [namaAlternatif(i) ahp(i), status;];
    
      result = [result;x];
      
end

[biggest, index] = sort(ahp, 'descend');
set(handles.uitable9,'data',result(index, :)); %membaca file dan menampilkan pada tabel


%set(handles.uitable5,'data',v); %membaca file dan menampilkan pada tabel

%set(handles.uitable5,'data',char(namaAlternatif(index))); %membaca file dan menampilkan pada tabel

%set(handles.uitable6,'data',biggest); %membaca file dan menampilkan pada tabel


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
