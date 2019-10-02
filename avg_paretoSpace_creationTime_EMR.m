clear all;
close all;
clc;

load('lamdaDataset/hashCodes/filenames.mat');
load('lamdaDataset/hashCodes/hashCodes_512.mat');
load('lamdaDataset/hashCodes/targets.mat');

    N = 2000;   % Number of samples in the Lamda Dataset
    data = hashCodes_512; % Binary features (Hash codes) N x NumberHasBits
    
    queryIndex = xlsread('qLabels.xls');  % Reads randomly choosen query pairs from excell file
    queryIndex = transpose( queryIndex ); 
    queryIndex1 = queryIndex(1,:); % First element of Query Pair
    queryIndex2 = queryIndex(2,:); % Second element of Qury Pair
    
  tic  
  for l = 1:1000  % Number of Query Pairs
        
        q1 = data(queryIndex1,:);  % q1 & q2 are query pairs in the loop
        q2 = data(queryIndex2,:);   
                 
        [H A landmarks Z] = EMRcomputeModel(data); % Compute EMR
        y1 = zeros(N,1);
        y1(queryIndex1) = 1; % Ranking  of query1 = 1
        y2 = zeros(N,1);
        y2(queryIndex2) = 1; % Ranking  of query2 = 1
        
        simEMR1{l,:} = EMRscore(H ,A, y1);  % EMR Ranking
        simEMR2{l,:} = EMRscore(H ,A, y2);  % EMR Ranking
        dist1{l,:}   = 1-simEMR1{l,:};      % Dissimilarity 
        dist2{l,:}   = 1-simEMR2{l,:};      % Dissimilarity 
            
        
        
        X = zeros(2,N);
        X(1,:) = dist1{l,:};
        X(2,:) = dist2{l,:};
    
        X = (X)';
  end
  toc/1000
