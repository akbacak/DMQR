clear all;
close all;
clc;

load('lamdaDataset/hashCodes/filenames.mat');
load('lamdaDataset/hashCodes/hashCodes_512.mat');
load('lamdaDataset/hashCodes/targets.mat');

N = 2000;           % Number of samples in the Lamda Dataset
data = hashCodes_512; % Binary features (Hash codes) N x NumberHasBits

system('/usr/bin/convert Python/q1.jpg -resize 256x256! Python/q1.jpg ');
system('/usr/bin/convert Python/q2.jpg -resize 256x256! Python/q2.jpg ');
system('/usr/bin/convert Python/q3.jpg -resize 256x256! Python/q3.jpg ');

system('gnome-terminal  -- python Python/run_python_on_matlab_512.py'); % generate 512 bits hash codes of the queries
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

system('gnome-terminal  -- python Python/predict_labels.py'); % Predict label vector of the queries
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



q1 = q1';
q2 = q2';
q3 = q3';
q1_label = (q1_label)';
q2_label = (q2_label)';
q3_label = (q3_label)';


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
%X = zeros(2,N);
X = zeros(3,N);

%X(1,:) = n_hamming_dist1;
%X(2,:) = n_hamming_dist2;
X(1,:) = hamming_dist1;
X(2,:) = hamming_dist2;
X(3,:) = hamming_dist3;
    
X = (X)';


maxFront = 10;
[pf_idx] = pareto_fronts(X, maxFront);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
b = or(q1_label , q2_label); % beta in the equation 7
absolute_b = nnz(b);         % Number of non-zero elements in the beta, nnz is a Matlab Func.
b = or(b,q3_label);
  
for j  =1:maxFront
    R=0;
    C=0;
    Labels = targets(pf_idx{j,1}(:,4),:);     
    [R , C] = size(Labels);                
                           
    for e = 1:R              
        MQUR_ALL(j,e) =  nnz( and(Labels(e,:) , b ) ) /  absolute_b;
                                           
    end
end
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for l = 1:2
    for n = 1:3   
        fname = [filenames{rtr2_idx{l,1}(n,4)}];
        figure;imshow(imread(fname));
    end
end








































