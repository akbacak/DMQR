function varargout = dmqRetrieval_final_v3_3d_R(varargin)
% DMQRETRIEVAL_FINAL_V3_3D_R MATLAB code for dmqRetrieval_final_v3_3d_R.fig
%      DMQRETRIEVAL_FINAL_V3_3D_R, by itself, creates a new DMQRETRIEVAL_FINAL_V3_3D_R or raises the existing
%      singleton*.
%
%      H = DMQRETRIEVAL_FINAL_V3_3D_R returns the handle to a new DMQRETRIEVAL_FINAL_V3_3D_R or the handle to
%      the existing singleton*.
%
%      DMQRETRIEVAL_FINAL_V3_3D_R('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DMQRETRIEVAL_FINAL_V3_3D_R.M with the given input arguments.
%
%      DMQRETRIEVAL_FINAL_V3_3D_R('Property','Value',...) creates a new DMQRETRIEVAL_FINAL_V3_3D_R or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dmqRetrieval_final_v3_3d_R_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dmqRetrieval_final_v3_3d_R_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dmqRetrieval_final_v3_3d_R

% Last Modified by GUIDE v2.5 27-Apr-2020 18:42:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dmqRetrieval_final_v3_3d_R_OpeningFcn, ...
                   'gui_OutputFcn',  @dmqRetrieval_final_v3_3d_R_OutputFcn, ...
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


% --- Executes just before dmqRetrieval_final_v3_3d_R is made visible.
function dmqRetrieval_final_v3_3d_R_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dmqRetrieval_final_v3_3d_R (see VARARGIN)

% Choose default command line output for dmqRetrieval_final_v3_3d_R
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dmqRetrieval_final_v3_3d_R wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dmqRetrieval_final_v3_3d_R_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Dataset.
function Dataset_Callback(hObject, eventdata, handles)
% hObject    handle to Dataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Dataset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Dataset


% --- Executes during object creation, after setting all properties.
function Dataset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  maxFront = handles.maxFront;  
  data = handles.data;
 

    fileID = fopen('Python/q1.txt','r');
    formatSpec = '%d';
    q1 = fscanf(fileID,formatSpec);
    fclose(fileID);

    fileID2 = fopen('Python/q2.txt','r');
    formatSpec = '%d';
    q2 = fscanf(fileID2,formatSpec);
    fclose(fileID2);
    
    fileID3 = fopen('Python/q3.txt','r');
    formatSpec = '%d';
    q3 = fscanf(fileID3,formatSpec);
    fclose(fileID3);
    
    
        
    q1 = q1';
    q2 = q2';
    q3 = q3';
         
    %N = length(handles.filenames);  % 
     N = 2000;
           
tic
    q1new = repmat(q1,N,1);
    q2new = repmat(q2,N,1);
    q3new = repmat(q3,N,1);
    dist_1 = xor(data, q1new);
    dist_2 = xor(data, q2new);
    dist_3 = xor(data, q3new);
    hamming_dist1 = sum(dist_1,2);
    hamming_dist2 = sum(dist_2,2);
    hamming_dist3 = sum(dist_3,2);
    %n_hamming_dist1 = mat2gray(hamming_dist1);
    %n_hamming_dist2 = mat2gray(hamming_dist2);
           
t = toc;
set(handles.tictoc,'String',num2str(t))

    X = zeros(3,N);
    %X(1,:) = n_hamming_dist1;
    %X(2,:) = n_hamming_dist2;
    X(1,:) = hamming_dist1;
    X(2,:) = hamming_dist2;
    X(3,:) = hamming_dist3;
    
    X = (X)';
    
    [K,L] = size(unique(X,'rows'));  %% Number of unique pareto points 
    set(handles.num_pp_fv3,'String',num2str(K))
    
    axes(handles.axes3);
    hold off; 
    scatter3(X(:,1),X(:,2),X(:,3),'k.');
    %plot3(X(:,1),X(:,2),X(:,3),'.');
    view(3);
    rotate3d on;
    hold on; 
    
     
 
    [pf_idx] = pareto_fronts(X, maxFront);
    
    %for k=1:maxFront
    %    scatter3(pf_idx{k,1}(:,1), pf_idx{k,1}(:,2) , pf_idx{k,1}(:,3));
    %   %plot(pf_idx{k,1}(:,1), pf_idx{k,1}(:,2) , 'y-');
    %end
    %xlabel('c1');
    %ylabel('c2'); 

   
    handles.pf_idx = pf_idx;
    handles.X = X;
       
    
       
    
    guidata(hObject, handles);



% --- Executes on slider movement.
function FrontSelector_Callback(hObject, eventdata, handles)
% hObject    handle to FrontSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
 maxFront = handles.maxFront; 
filenames = handles.filenames;
targets = handles.targets;
X = handles.X;
pf_idx = handles.pf_idx;


currentFront = ((round(1+(maxFront-1)*get(hObject,'Value'))));

set(handles.FrontNum,'String',num2str(currentFront));
 

handles.currentFront = currentFront;    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    
    
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fileID = fopen('Python/prd_q1.txt','r');
    formatSpec = '%d';
    q1_label = fscanf(fileID,formatSpec);
    fclose(fileID);

    fileID2 = fopen('Python/prd_q2.txt','r');
    formatSpec = '%d';
    q2_label = fscanf(fileID2,formatSpec);
    fclose(fileID2);
     
    fileID3 = fopen('Python/prd_q3.txt','r');
    formatSpec = '%d';
    q3_label = fscanf(fileID3,formatSpec);
    fclose(fileID3);

    q1_label = (q1_label)';
    q2_label = (q2_label)';
    q3_label = (q3_label)';  
     
    
handles.q1_label = q1_label;
handles.q2_label = q2_label;
handles.q3_label = q3_label;

    
    b = or(q1_label , q2_label); % beta in the equation 7
    b = or(b,q3_label);
    absolute_b = nnz(b);         % Number of non-zero elements in the beta, nnz is a Matlab Func.
    
    
      for j  =1:maxFront
            R=0;
            C=0;
            Labels = targets(pf_idx{j,1}(:,4),:);     
            [R , C] = size(Labels); 
            
            
              switch (mod(R ,2) == 1)
                case 1
                     e_left(j) = (round(R / 2) - 1) ;  
                     e_rigth(j)= (round(R / 2)    ) ;
                case 0
                     e_left(j)  =  R / 2 ;
                     e_rigth(j) =  R / 2 ;
              end
            
              
               
                     
            for e = 1:R              
                MQUR_ALL(j,e) =  nnz( and(Labels(e,:) , b ) ) /  absolute_b;
                                           
            end                   
            %MQUR score of the first retrieved items in each front
            MQUR_1(j) = MQUR_ALL(j,1);
              
            G{j} = 0;
            rigth_G{j} = 0;
            left_G{j}  = 0;
            i_G{j} = 0;
            i_rigth_G{j} = 0;
            i_left_G{j}  = 0;
            
            rigth_DG{j} = 0;
            left_DG{j}  = 0;
            i_DG{j} = 0;
            i_rigth_DG{j} = 0;
            i_left_DG{j}  = 0;
            
            rigth_DCG{j} = 0;
            left_DCG{j}  = 0;
            i_rigth_DCG{j} = 0;
            i_left_DCG{j}  = 0;        
              
            
            
              for s = 1:R     
               G{j}(:,s) = MQUR_ALL(j,s);
               i_G{j}(:,s) = 1;
              end
             
              
            if R <= 2
                    e_left(j) = 2;
                    e_rigth(j)= 2;
            end
            
            
             switch (mod(R ,2) == 1)
                case 1                    
                    rigth_G{j}   =   G{j}(: , (e_rigth(j)   )  : R);
                    i_rigth_G{j} = i_G{j}(: , (e_rigth(j)   )  : R);
                    
                    left_G{j}    =   G{j}(: , 1 : e_left(j) ); 
                    left_G{j}    =   fliplr(left_G{j});
                    i_left_G{j}   = i_G{j}(: , 1 : e_left(j) );
             
                    rigth_DG{j}(:,1)   =   rigth_G{j}(:,1);
                    i_rigth_DG{j}(:,1) = i_rigth_G{j}(:,1);
                    
             
             
                    left_DG{j}(:,1)   =   left_G{j}(:,1);
                    i_left_DG{j}(:,1) = i_left_G{j}(:,1);
             
                    for d = 2 : e_rigth(j)
                         rigth_DG{j}(:,d)   =   rigth_G{j}(:,d) / log2(d);
                         i_rigth_DG{j}(:,d) = i_rigth_G{j}(:,d) / log2(d); 
                    end                    
                    for  f = 2 : e_left(j)   
                         left_DG{j}(:,f)   =   left_G{j}(:,f) / log2(f);
                         i_left_DG{j}(:,f) = i_left_G{j}(:,f) / log2(f);
                    end
                    
                    case 0
                    rigth_G{j}   =   G{j}(: , (e_rigth(j) +1)  : R);
                    i_rigth_G{j} = i_G{j}(: , (e_rigth(j) +1)  : R);
                    
                    left_G{j}    =   G{j}(: , 1 : e_left(j) ); 
                    left_G{j}    =   fliplr(left_G{j});
                    i_left_G{j}   = i_G{j}(: , 1 : e_left(j) );
             
                    rigth_DG{j}(:,1)   =   rigth_G{j}(:,1);
                    i_rigth_DG{j}(:,1) = i_rigth_G{j}(:,1);
                    %rigth_DG{l,j}(:,e_rigth(l,j)) =  MQUR_ALL{l,:}(j,e_rigth(l,j));
             
             
                    left_DG{j}(:,1)   =   left_G{j}(:,1);
                    i_left_DG{j}(:,1) = i_left_G{j}(:,1);
             
             
                    for h = 2 : e_rigth(j)
                         rigth_DG{j}(:,h)   =   rigth_G{j}(:,h) / log2(h);
                         i_rigth_DG{j}(:,h) = i_rigth_G{j}(:,h) / log2(h); 
                    end
                    for m = 2 : e_left(j)
                         left_DG{j}(:,m)   =   left_G{j}(:,m) / log2(m);
                         i_left_DG{j}(:,m) = i_left_G{j}(:,m) / log2(m);
                    end
             end
             
             rigth_DCG{j} = cumsum(rigth_DG{j}); 
             i_rigth_DCG{j} = cumsum( i_rigth_DG{j});
             n_rigth_DCG{j} = rigth_DCG{j} ./ i_rigth_DCG{j};
                                  
           
             left_DCG{j} = cumsum(left_DG{j}); 
             i_left_DCG{j} = cumsum( i_left_DG{j});
             n_left_DCG{j} = left_DCG{j} ./ i_left_DCG{j};
             
             flip_n_left_DCG{j} = fliplr(n_left_DCG{j});
             n_DCG{j} = horzcat(flip_n_left_DCG{j}, n_rigth_DCG{j});
      end
             
        
       
      j = currentFront;
      axes(handles.axes11);
      hold off;
      plot(n_DCG{j});
      ylim([0 1])
      xlabel('Number of Images');
      ylabel('nDCG');
      hold on;
      
      handles.currentFront = currentFront;
      
      handles.MQUR_ALL = MQUR_ALL;
        
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%SHOW S TOP IMAGES IN EACH FRONT WHERE THEIR MQUR SCORE IS 1%%%%%%%%%%%%%   
axes(handles.axes3);
hold off; scatter3(handles.X(:,1),handles.X(:,2),handles.X(:,3),'.');
view(3);
rotate3d on;
hold on;



  %l = currentFront;  
  %scatter3(pf_idx{l,1}(:,1), pf_idx{l,1}(:,2) , pf_idx{l,1}(:,3), 'o'); 
  %view(3);
  %rotate3d on;
 
 
for ll = 1:maxFront
    
    rtr_idx{ll,1} = [];
    rtr2_idx{ll,1} = [];

    
    [v(ll) , k(ll)] = size(MQUR_ALL(ll,:)); % k(ll) is the size of column vector of ll th front
    
    for ff = 1:k(ll)
        if  MQUR_ALL(ll,ff) == 1    
            
            rtr_idx{1,1}(end+1,:) = pf_idx{ll,1}( ff , 4);
            %rtr_idx{ll,:}(end+1,:) = pf_idx{ll,1}( ff , 3);
            rtr2_idx{ll,:}(end+1,:) = pf_idx{ll,1}( ff , :);
           
                      
        end
         
    end
[g(ll),h(ll)] = size( rtr2_idx{ll,1}(:,:) );    % How  many imagees in each front where MQUR ==1     
end
g = g';   %                                     % How  many imagees in each front where MQUR ==1 

        
ll = currentFront; 


plot3(rtr2_idx{ll,1}(:,1), rtr2_idx{ll,1}(:,2) , rtr2_idx{ll,1}(:,3), 's'); 
view(3);
rotate3d on;

v=13;

% This code show images in each front where MQUR == 1

for n = (g(ll)+v):36 
        cla(handles.(['axes' num2str(n)]) ,'reset');
end


for k =1:g(ll)
            
         %cla(handles.(['axes' num2str(v + k-1)]) ,'reset');
         axes( handles.(['axes' num2str(v + k-1)]) );
         fname = [handles.image_dir handles.filenames{rtr2_idx{ll,1}(k,4)}];
         imshow(imread(fname)); 
         set( handles.(['edit' num2str(19 +k-1)]) ,'string' , num2str( handles.filenames{rtr2_idx{ll,1}(k,4)})  );
         %set(handles.edit19,'string',num2str( handles.filenames{rtr_idx{1,1}(1,1)}));
         axis image

end
   
      
     
 handles.currentFront = currentFront;       
     
    
    
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function FrontSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FrontSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function ImageSelector_Callback(hObject, eventdata, handles)
% hObject    handle to ImageSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

 maxFront = handles.maxFront; 


pf_idx = handles.pf_idx;
X = handles.X;
currentFront = handles.currentFront ;

[frontSize, e] = size(pf_idx{currentFront,1}(:,3));
currentImage = ((round(1+(frontSize-1)*get(hObject,'Value'))));

set(handles.ImageNum,'String',num2str(currentImage));

%set(handles.PicIdx1,'String',num2str(max(currentImage-2,1)));
%set(handles.PicIdx2,'String',num2str(max(currentImage-1,1)));
%set(handles.PicIdx3,'String',num2str(currentImage));
%set(handles.PicIdx4,'String',num2str(min(currentImage+1,frontSize)));
%set(handles.PicIdx5,'String',num2str(min(currentImage+2,frontSize)));

L3 = max(1,currentImage - 3);
L2 = max(1,currentImage - 2);
L1 = max(1,currentImage - 1);
R1 = min(frontSize,currentImage+1);
R2 = min(frontSize,currentImage+2);
R3 = min(frontSize,currentImage+3);



axes(handles.axes3);
hold off; plot3(handles.X(:,1),handles.X(:,2),handles.X(:,3), 'k.');
view(3)
rotate3d on;
hold on;


[pf_idx] = pareto_fronts(X, maxFront);
 %for k=1:maxFront
 %       plot3(pf_idx{k,1}(:,1), pf_idx{k,1}(:,2) ,pf_idx{k,1}(:,3), 'y-');
 %end


l = currentFront;

plot3(pf_idx{l,1}(:,1), pf_idx{l,1}(:,2) , pf_idx{l,1}(:,3) , 's');
view(3);
rotate3d on;

%xlabel('Dissimilarity to Query1');
%ylabel('Dissimilarity to Query2');
%zlabel('Dissimilarity to Query3');

currentfrontLoc = (pf_idx{l,1}(:,1:3))';

plot3(currentfrontLoc(1,currentImage),currentfrontLoc(2,currentImage),currentfrontLoc(3,currentImage),'O','Linewidth',3,'MarkerSize',10);
%plot3(currentfrontLoc(1,L1),currentfrontLoc(2,L1),currentfrontLoc(3,L1),'o','Linewidth',3,'MarkerSize',5);
%plot3(currentfrontLoc(1,L1),currentfrontLoc(2,L1),currentfrontLoc(3,L1),'o','Linewidth',3,'MarkerSize',5);
%plot3(currentfrontLoc(1,L2),currentfrontLoc(2,L2),currentfrontLoc(3,L1),'o','Linewidth',3,'MarkerSize',5);
%plot3(currentfrontLoc(1,L3),currentfrontLoc(2,L3),currentfrontLoc(3,L1),'o','Linewidth',3,'MarkerSize',5);
%plot3(currentfrontLoc(1,R1),currentfrontLoc(2,R1),currentfrontLoc(3,L1),'o','Linewidth',3,'MarkerSize',5);
%plot3(currentfrontLoc(1,R2),currentfrontLoc(2,R2),currentfrontLoc(3,L1),'o','Linewidth',3,'MarkerSize',5);
%plot3(currentfrontLoc(1,R3),currentfrontLoc(2,R3),currentfrontLoc(3,L1),'o','Linewidth',3,'MarkerSize',5);

    
currentfrontId = pf_idx{l,:}(:,4);
currentfrontId =(currentfrontId)';


  
axes(handles.axes4);
fname = [handles.image_dir handles.filenames{currentfrontId(1,currentImage)}];
imshow(imread(fname)); 
set(handles.main,'string',num2str(handles.filenames{currentfrontId(1,currentImage)}));
axis image;

axes(handles.axes5);
fname = [handles.image_dir handles.filenames{currentfrontId(1,R1)}];
imshow(imread(fname));
set(handles.mainR1,'string',num2str(handles.filenames{currentfrontId(1,R1)}));
axis image;

axes(handles.axes6);
fname = [handles.image_dir handles.filenames{currentfrontId(1,R2)}];
imshow(imread(fname));
set(handles.mainR2,'string',num2str(handles.filenames{currentfrontId(1,R2)}));
axis image;

axes(handles.axes7);
fname = [handles.image_dir handles.filenames{currentfrontId(1,R3)}];
imshow(imread(fname)); 
set(handles.mainR3,'string',num2str(handles.filenames{currentfrontId(1,R3)}));
axis image;

axes(handles.axes8);
fname = [handles.image_dir handles.filenames{currentfrontId(1,L1)}];
imshow(imread(fname)); 
set(handles.mainL1,'string',num2str(handles.filenames{currentfrontId(1,L1)}));
axis image;

axes(handles.axes9);
fname = [handles.image_dir handles.filenames{currentfrontId(1,L2)}];
imshow(imread(fname)); 
set(handles.mainL2,'string',num2str(handles.filenames{currentfrontId(1,L2)}));
axis image;

axes(handles.axes10);
fname = [handles.image_dir handles.filenames{currentfrontId(1,L3)}];
imshow(imread(fname)); 
set(handles.mainL3,'string',num2str(handles.filenames{currentfrontId(1,L3)}));
axis image;



guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ImageSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImageSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function FrontNum_Callback(hObject, eventdata, handles)
% hObject    handle to FrontNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FrontNum as text
%        str2double(get(hObject,'String')) returns contents of FrontNum as a double


% --- Executes during object creation, after setting all properties.
function FrontNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FrontNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ImageNum_Callback(hObject, eventdata, handles)
% hObject    handle to ImageNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ImageNum as text
%        str2double(get(hObject,'String')) returns contents of ImageNum as a double


% --- Executes during object creation, after setting all properties.
function ImageNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImageNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tictoc_Callback(hObject, eventdata, handles)
% hObject    handle to tictoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tictoc as text
%        str2double(get(hObject,'String')) returns contents of tictoc as a double


% --- Executes during object creation, after setting all properties.
function tictoc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tictoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function main_Callback(hObject, eventdata, handles)
% hObject    handle to main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of main as text
%        str2double(get(hObject,'String')) returns contents of main as a double


% --- Executes during object creation, after setting all properties.
function main_CreateFcn(hObject, eventdata, handles)
% hObject    handle to main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mainR1_Callback(hObject, eventdata, handles)
% hObject    handle to mainR1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mainR1 as text
%        str2double(get(hObject,'String')) returns contents of mainR1 as a double


% --- Executes during object creation, after setting all properties.
function mainR1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mainR1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mainR2_Callback(hObject, eventdata, handles)
% hObject    handle to mainR2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mainR2 as text
%        str2double(get(hObject,'String')) returns contents of mainR2 as a double


% --- Executes during object creation, after setting all properties.
function mainR2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mainR2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mainR3_Callback(hObject, eventdata, handles)
% hObject    handle to mainR3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mainR3 as text
%        str2double(get(hObject,'String')) returns contents of mainR3 as a double


% --- Executes during object creation, after setting all properties.
function mainR3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mainR3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mainL1_Callback(hObject, eventdata, handles)
% hObject    handle to mainL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mainL1 as text
%        str2double(get(hObject,'String')) returns contents of mainL1 as a double


% --- Executes during object creation, after setting all properties.
function mainL1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mainL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mainL2_Callback(hObject, eventdata, handles)
% hObject    handle to mainL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mainL2 as text
%        str2double(get(hObject,'String')) returns contents of mainL2 as a double


% --- Executes during object creation, after setting all properties.
function mainL2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mainL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mainL3_Callback(hObject, eventdata, handles)
% hObject    handle to mainL3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mainL3 as text
%        str2double(get(hObject,'String')) returns contents of mainL3 as a double


% --- Executes during object creation, after setting all properties.
function mainL3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mainL3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nDCG_Value_Callback(hObject, eventdata, handles)
% hObject    handle to nDCG_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nDCG_Value as text
%        str2double(get(hObject,'String')) returns contents of nDCG_Value as a double


% --- Executes during object creation, after setting all properties.
function nDCG_Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nDCG_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 maxFront = handles.maxFront; 
  data = handles.data;
 

    fileID = fopen('Python/q1.txt','r');
    formatSpec = '%d';
    q1 = fscanf(fileID,formatSpec);
    fclose(fileID);

    fileID2 = fopen('Python/q2.txt','r');
    formatSpec = '%d';
    q2 = fscanf(fileID2,formatSpec);
    fclose(fileID2);
    
      
    
        
    q1 = q1';
    q2 = q2';
    
    % NOTE : put q1 and q2 to inside data and give indexes of 2001 and 2002
   
    
    
    
    %     Ranking with EMR
    N = length(handles.filenames);
tic    
    [H A landmarks Z] = EMRcomputeModel(handles.data);
    y1 = zeros(N,1);
    y1(queryIndex1) = 1;
    y2 = zeros(N,1);
    y2(queryIndex2) = 1;
    
    simEMR1 = EMRscore(H ,A, y1);
    simEMR2 = EMRscore(H ,A, y2);
    dist1 = 1-simEMR1;
    dist2 = 1-simEMR2;
       
t = toc;
set(handles.tictoc2,'String',num2str(t))

    X = zeros(2,N);
    X(1,:) = dist1;
    X(2,:) = dist2;
    
    X = (X)';
    
    [K,L] = size(unique(X,'rows'));  %% Number of unique pareto points 
    set(handles.num_pp_fv3,'String',num2str(K))
    
    

    axes(handles.axes3);
    hold off; plot(X(:,1),X(:,2),'.');
    hold on; 
    
     
   
    [pf_idx] = pareto_fronts(X, maxFront);
    for k=1:maxFront
        plot(pf_idx{k,1}(:,1), pf_idx{k,1}(:,2) , 'y-');
    end
    xlabel('c1');
    ylabel('c2'); 

   
    handles.pf_idx = pf_idx;
    handles.X = X;
       
    
    guidata(hObject, handles);


function tictoc2_Callback(hObject, eventdata, handles)
% hObject    handle to tictoc2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tictoc2 as text
%        str2double(get(hObject,'String')) returns contents of tictoc2 as a double


% --- Executes during object creation, after setting all properties.
function tictoc2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tictoc2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




 

function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit27 as text
%        str2double(get(hObject,'String')) returns contents of edit27 as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit29 as text
%        str2double(get(hObject,'String')) returns contents of edit29 as a double


% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit30_Callback(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit30 as text
%        str2double(get(hObject,'String')) returns contents of edit30 as a double


% --- Executes during object creation, after setting all properties.
function edit30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit31_Callback(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit31 as text
%        str2double(get(hObject,'String')) returns contents of edit31 as a double


% --- Executes during object creation, after setting all properties.
function edit31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit32_Callback(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit32 as text
%        str2double(get(hObject,'String')) returns contents of edit32 as a double


% --- Executes during object creation, after setting all properties.
function edit32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit33_Callback(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit33 as text
%        str2double(get(hObject,'String')) returns contents of edit33 as a double


% --- Executes during object creation, after setting all properties.
function edit33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit34_Callback(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit34 as text
%        str2double(get(hObject,'String')) returns contents of edit34 as a double


% --- Executes during object creation, after setting all properties.
function edit34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit35_Callback(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit35 as text
%        str2double(get(hObject,'String')) returns contents of edit35 as a double


% --- Executes during object creation, after setting all properties.
function edit35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit36_Callback(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit36 as text
%        str2double(get(hObject,'String')) returns contents of edit36 as a double


% --- Executes during object creation, after setting all properties.
function edit36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit37_Callback(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit37 as text
%        str2double(get(hObject,'String')) returns contents of edit37 as a double


% --- Executes during object creation, after setting all properties.
function edit37_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit38_Callback(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit38 as text
%        str2double(get(hObject,'String')) returns contents of edit38 as a double


% --- Executes during object creation, after setting all properties.
function edit38_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit39_Callback(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit39 as text
%        str2double(get(hObject,'String')) returns contents of edit39 as a double


% --- Executes during object creation, after setting all properties.
function edit39_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit40_Callback(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit40 as text
%        str2double(get(hObject,'String')) returns contents of edit40 as a double


% --- Executes during object creation, after setting all properties.
function edit40_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit41_Callback(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit41 as text
%        str2double(get(hObject,'String')) returns contents of edit41 as a double


% --- Executes during object creation, after setting all properties.
function edit41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit42_Callback(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit42 as text
%        str2double(get(hObject,'String')) returns contents of edit42 as a double


% --- Executes during object creation, after setting all properties.
function edit42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





    


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

maxFront = handles.maxFront;
features = handles.features;

filenames = handles.filenames;
pf_idx = handles.pf_idx;
%MQUR_ALL  = handles.MQUR_ALL; 
targets = handles.targets;
X = handles.X;

       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
  

    fileID = fopen('Python/prd_q1.txt','r');
    formatSpec = '%d';
    q1_label = fscanf(fileID,formatSpec);
    fclose(fileID);

    fileID2 = fopen('Python/prd_q2.txt','r');
    formatSpec = '%d';
    q2_label = fscanf(fileID2,formatSpec);
    fclose(fileID2);
     
    fileID3 = fopen('Python/prd_q3.txt','r');
    formatSpec = '%d';
    q3_label = fscanf(fileID3,formatSpec);
    fclose(fileID3);

    q1_label = (q1_label)';
    q2_label = (q2_label)';
    q3_label = (q3_label)';


handles.q1_label = q1_label;
handles.q2_label = q2_label;
handles.q3_label = q3_label;


          
    b = or(q1_label , q2_label); % beta in the equation 7
    b = or(b,q3_label);
  
    absolute_b = nnz(b);         % Number of non-zero elements in the beta, nnz is a Matlab Func.
    
    
      for j  =1:maxFront
            R=0;
            C=0;
            Labels = targets(pf_idx{j,1}(:,4),:);     
            [R , C] = size(Labels);                
               
                     
            for e = 1:R              
                MQUR_ALL(j,e) =  nnz( and(Labels(e,:) , b ) ) /  absolute_b;
                                           
            end
      end



%%%%%%%%%%%%%%%%%%%%%%%
axes(handles.axes3);
hold off; 
scatter3(handles.X(:,1), handles.X(:,2), handles.X(:,3), 'k.');
view(3);
rotate3d on;
hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   

for ll = 1:maxFront
    
    rtr_idx{ll,1} = [];
    rtr2_idx{ll,1} = [];

    
    [v(ll) , k(ll)] = size(MQUR_ALL(ll,:)); % k(ll) is the size of column vector of ll th front
    
    for ff = 1:k(ll)
        if  MQUR_ALL(ll,ff) == 1    
            
            rtr_idx{1,1}(end+1,:) = pf_idx{ll,1}( ff , 4);
            %rtr_idx{ll,:}(end+1,:) = pf_idx{ll,1}( ff , 3);
            rtr2_idx{ll,:}(end+1,:) = pf_idx{ll,1}( ff , :);
            scatter3(rtr2_idx{ll,1}(:,1) , rtr2_idx{ll,1}(:,2),  rtr2_idx{ll,1}(:,3),  's' )
            view(3);
            rotate3d on;
        end
         
    end
end
    


[M,C] = size(rtr_idx{1,1}(:,1));

f = features(rtr_idx{1,1}(:,1),:); 

f1 = importdata('/home/ubuntu/Desktop/Thesis_Follow_Up_2/dmqRetrieval/Python/f1.txt');    
f2 = importdata('/home/ubuntu/Desktop/Thesis_Follow_Up_2/dmqRetrieval/Python/f2.txt');
f3 = importdata('/home/ubuntu/Desktop/Thesis_Follow_Up_2/dmqRetrieval/Python/f3.txt');
f1 = f1';
f2 = f2';
f3 = f3';

f1_new = repmat(f1,M,1);
f2_new = repmat(f2,M,1);
f3_new = repmat(f3,M,1);

dist_f1 = pdist2(f1 , f , 'euclid' );
dist_f2 = pdist2(f2 , f , 'euclid' );
dist_f3 = pdist2(f3 , f , 'euclid' );

Y = zeros(3,M);
Y(1,:) = dist_f1;
Y(2,:) = dist_f2;
Y(3,:) = dist_f3;
Y = (Y)';
Y2 = Y(:,1).^2 + Y(:,2).^2 +  Y(:,3).^2 ;

Result = zeros(M,2);
Result(:,1) = Y2(:);
Result(:,2) = rtr_idx{1,1}(:,1);

final_rtr = unique(Result,'rows');

final_rtr_idx = final_rtr(:,2);

         cla(handles.axes13,'reset');
         cla(handles.axes14,'reset');
         cla(handles.axes15,'reset');
         cla(handles.axes16,'reset');
         cla(handles.axes17,'reset');
         cla(handles.axes18,'reset');         
         cla(handles.axes19,'reset');
         cla(handles.axes20,'reset');
         cla(handles.axes21,'reset');
         cla(handles.axes22,'reset');
         cla(handles.axes23,'reset');
         cla(handles.axes24,'reset');
         cla(handles.axes25,'reset');
         cla(handles.axes26,'reset');
         cla(handles.axes27,'reset');
         cla(handles.axes28,'reset');
         cla(handles.axes29,'reset');
         cla(handles.axes30,'reset');
         cla(handles.axes31,'reset');
         cla(handles.axes32,'reset');
         cla(handles.axes33,'reset');
         cla(handles.axes34,'reset');
         cla(handles.axes35,'reset');
         cla(handles.axes36,'reset');
    
        axes(handles.axes13);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(1,1)}];
        imshow(imread(fname)); 
        set(handles.edit19,'string',num2str( handles.filenames{final_rtr_idx(1,1)}));
        axis image
      
        axes(handles.axes14);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(2,1)}];
        imshow(imread(fname)); 
        set(handles.edit20,'string',num2str( handles.filenames{final_rtr_idx(2,1)}));
        axis image
        
        axes(handles.axes15);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(3,1)}];
        imshow(imread(fname));
        set(handles.edit21,'string',num2str( handles.filenames{final_rtr_idx(3,1)}));
        axis image
        
        axes(handles.axes16);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(4,1)}];
        imshow(imread(fname)); 
        set(handles.edit22,'string',num2str( handles.filenames{final_rtr_idx(4,1)}));
        axis image
        
      
        axes(handles.axes17);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(5,1)}];
        imshow(imread(fname)); 
        set(handles.edit23,'string',num2str( handles.filenames{final_rtr_idx(5,1)}));
        axis image
        
       
        axes(handles.axes18);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(6,1)}];
        imshow(imread(fname)); 
        set(handles.edit24,'string',num2str( handles.filenames{final_rtr_idx(6,1)}));
        axis image
        
       
        axes(handles.axes19);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(7,1)}];
        imshow(imread(fname)); 
        set(handles.edit25,'string',num2str( handles.filenames{final_rtr_idx(7,1)}));
        axis image
        
      
        axes(handles.axes20);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(8,1)}];
        imshow(imread(fname)); 
        set(handles.edit26,'string',num2str( handles.filenames{final_rtr_idx(8,1)}));
        axis image
        
     
        axes(handles.axes21);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(9,1)}];
        imshow(imread(fname)); 
        set(handles.edit27,'string',num2str( handles.filenames{final_rtr_idx(9,1)}));
        axis image
        
     
        axes(handles.axes22);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(10,1)}];
        imshow(imread(fname)); 
        set(handles.edit28,'string',num2str( handles.filenames{final_rtr_idx(10,1)}));
        axis image
        
       
        axes(handles.axes23);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(11,1)}];
        imshow(imread(fname)); 
        set(handles.edit29,'string',num2str( handles.filenames{final_rtr_idx(11,1)}));
        axis image
        
    
        axes(handles.axes24);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(12,1)}];
        imshow(imread(fname)); 
        set(handles.edit30,'string',num2str( handles.filenames{final_rtr_idx(12,1)}));
        axis image
        
     
        axes(handles.axes25);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(13,1)}];
        imshow(imread(fname)); 
        set(handles.edit31,'string',num2str( handles.filenames{final_rtr_idx(13,1)}));
        axis image

        axes(handles.axes26);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(14,1)}];
        imshow(imread(fname)); 
        set(handles.edit32,'string',num2str( handles.filenames{final_rtr_idx(14,1)}));
        axis image
        
       
        axes(handles.axes27);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(15,1)}];
        imshow(imread(fname)); 
        set(handles.edit33,'string',num2str( handles.filenames{final_rtr_idx(15,1)}));
        axis image
       
        axes(handles.axes28);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(16,1)}];
        imshow(imread(fname)); 
        set(handles.edit34,'string',num2str( handles.filenames{final_rtr_idx(16,1)}));
        axis image
        
      
        axes(handles.axes29);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(17,1)}];
        imshow(imread(fname)); 
        set(handles.edit35,'string',num2str( handles.filenames{final_rtr_idx(17,1)}));
        axis image
      
        axes(handles.axes30);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(18,1)}];
        imshow(imread(fname)); 
        set(handles.edit36,'string',num2str( handles.filenames{final_rtr_idx(18,1)}));
        axis image
        
      
        axes(handles.axes31);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(19,1)}];
        imshow(imread(fname)); 
        set(handles.edit37,'string',num2str( handles.filenames{final_rtr_idx(19,1)}));
        axis image
        
        
        axes(handles.axes32);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(20,1)}];
        imshow(imread(fname)); 
        set(handles.edit38,'string',num2str( handles.filenames{final_rtr_idx(20,1)}));
        axis image
      
        axes(handles.axes33);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(21,1)}];
        imshow(imread(fname)); 
        set(handles.edit39,'string',num2str( handles.filenames{final_rtr_idx(21,1)}));
        axis image
        
     
        axes(handles.axes34);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(22,1)}];
        imshow(imread(fname)); 
        set(handles.edit40,'string',num2str( handles.filenames{final_rtr_idx(22,1)}));
        axis image
        
       
        axes(handles.axes35);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(23,1)}];
        imshow(imread(fname)); 
        set(handles.edit41,'string',num2str( handles.filenames{final_rtr_idx(23,1)}));
        axis image
        
        axes(handles.axes36);
        fname = [handles.image_dir handles.filenames{final_rtr_idx(24,1)}];
        imshow(imread(fname)); 
        set(handles.edit42,'string',num2str( handles.filenames{final_rtr_idx(24,1)}));
        axis image

 guidata(hObject, handles);
       


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1);
imshow(imread('Python/q1.jpg')); axis image;
axes(handles.axes2);
imshow(imread('Python/q2.jpg')); axis image;

system('python Python/run_python_on_matlab_48.py');



guidata(hObject, handles);

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
imshow(imread('Python/q1.jpg')); axis image;
axes(handles.axes2);
imshow(imread('Python/q2.jpg')); axis image;

system('python Python/run_python_on_matlab_96.py');



guidata(hObject, handles);



% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
imshow(imread('Python/q1.jpg')); axis image;
axes(handles.axes2);
imshow(imread('Python/q2.jpg')); axis image;

system('python Python/run_python_on_matlab_256.py');



guidata(hObject, handles);



% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
imshow(imread('Python/q1.jpg')); axis image;
axes(handles.axes2);
imshow(imread('Python/q2.jpg')); axis image;

system('gnome-terminal  -- python Python/run_python_on_matlab.py');



guidata(hObject, handles);



% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
imshow(imread('Python/q1.jpg')); axis image;
axes(handles.axes2);
imshow(imread('Python/q2.jpg')); axis image;

system('gnome-terminal  -- python Python/run_python_on_matlab_48_Caffe.py');



guidata(hObject, handles);


% --- Executes on selection change in hashCodeSelection_f2.
function hashCodeSelection_f2_Callback(hObject, eventdata, handles)
% hObject    handle to hashCodeSelection_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns hashCodeSelection_f2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from hashCodeSelection_f2
maxFront = 10;
feature_dir = [pwd '/lamdaDataset/features/'];

system('/usr/bin/convert Python/q1.jpg -resize 256x256! Python/q1.jpg ');
system('/usr/bin/convert Python/q2.jpg -resize 256x256! Python/q2.jpg ');
system('/usr/bin/convert Python/q3.jpg -resize 256x256! Python/q3.jpg ');

image_dir =[pwd '/lamdaDataset/imageFolder/']; 
data_dir = [pwd '/lamdaDataset/hashCodes'];
load([data_dir '/filenames']); % File names
load([data_dir '/targets']);   % Labels

hashCode_index = get(handles.hashCodeSelection_f2, 'Value');

switch hashCode_index
           
    case 1
        load([data_dir '/hashCodes_64']); 
        data = hashCodes_64;
        load([feature_dir '/features_64']); 
        features = features_64;
        %data = features_64 > 0.5;
        axes(handles.axes1);
        imshow(imread('Python/q1.jpg')); axis image;
        axes(handles.axes2);
        imshow(imread('Python/q2.jpg')); axis image;
        axes(handles.axes37);
        imshow(imread('Python/q3.jpg')); axis image;
        
        system('python Python/run_python_on_matlab_64.py');
     
        
                
    case 2
       load([data_dir '/hashCodes_128']); 
       data = hashCodes_128;
       load([feature_dir '/features_128']); 
       features = features_128;
       %data = features_128 > 0.5;
       axes(handles.axes1);
       imshow(imread('Python/q1.jpg')); axis image;
       axes(handles.axes2);
       imshow(imread('Python/q2.jpg')); axis image;
       axes(handles.axes37);
       imshow(imread('Python/q3.jpg')); axis image;
       
       system('python Python/run_python_on_matlab_128.py');
  
      
       
    case 3
        load([data_dir '/hashCodes_256']); 
        data = hashCodes_256;
        load([feature_dir '/features_256']); 
        features = features_256;
        %data = features_256 > 0.5;
        axes(handles.axes1);
        imshow(imread('Python/q1.jpg')); axis image;
        axes(handles.axes2);
        imshow(imread('Python/q2.jpg')); axis image;
        axes(handles.axes37);
        imshow(imread('Python/q3.jpg')); axis image;
        
        system('python Python/run_python_on_matlab_256.py');
      
        
        
    case 4
        load([data_dir '/hashCodes_512']); 
        data = hashCodes_512;
        load([feature_dir '/features_512']); 
        features = features_512;
        %data = features_512 > 0.5;
        axes(handles.axes1);
        imshow(imread('Python/q1.jpg')); axis image;
        axes(handles.axes2);
        imshow(imread('Python/q2.jpg')); axis image;
        axes(handles.axes37);
        imshow(imread('Python/q3.jpg')); axis image;
        
        system('python Python/run_python_on_matlab_512.py');
      
        
end

%set(handles.QueryName1,'String', filenames);
%set(handles.QueryName2,'String', filenames);

handles.filenames = filenames;
handles.targets = targets;
handles.data = data;
handles.image_dir = image_dir;
handles.data_dir = data_dir;
handles.features = features;
handles.maxFront = maxFront;

guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function hashCodeSelection_f2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hashCodeSelection_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


 


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

system('python Python/predict_labels.py');

guidata(hObject, handles);



function num_pp_fv3_Callback(hObject, eventdata, handles)
% hObject    handle to num_pp_fv3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_pp_fv3 as text
%        str2double(get(hObject,'String')) returns contents of num_pp_fv3 as a double


% --- Executes during object creation, after setting all properties.
function num_pp_fv3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_pp_fv3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
