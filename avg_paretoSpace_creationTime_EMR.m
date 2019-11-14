clear all;
close all;
clc;

load('lamdaDataset/hashCodes/filenames.mat');
load('lamdaDataset/hashCodes/hashCodes_256.mat');
load('lamdaDataset/hashCodes/targets.mat');

    N = 2000;   % Number of samples in the Lamda Dataset
    data = hashCodes_256; % Binary features (Hash codes) N x NumberHasBits
    
    queryIndex = xlsread('qLabels_V2.xls');  % Reads randomly choosen query pairs from excell file
    queryIndex = transpose( queryIndex ); 
    queryIndex1 = queryIndex(1,:); % First element of Query Pair
    queryIndex2 = queryIndex(2,:); % Second element of Qury Pair
    
  tic  
   for l = 1:500  % Number of Query Pairs
        
        queryIndex1(l) = queryIndex(1,l);
        queryIndex2(l) = queryIndex(2,l);
        q1 = data(queryIndex1,:);  % q1 & q2 are query pairs in the loop
        q2 = data(queryIndex2,:);   
                 
     
        y1{l,:} = zeros(N,1);
        y1{l,:}(queryIndex1(l)) = 1; % Ranking  of query1 = 1
        y2{l,:} = zeros(N,1);
        y2{l,:}(queryIndex2(l)) = 1; % Ranking  of query2 = 1
    
    
     [H A landmarks Z] = EMRcomputeModel(data); % Compute EMR
        simEMR1{l,:} = EMRscore(H ,A, y1{l,:});  % EMR Ranking
        simEMR2{l,:} = EMRscore(H ,A, y2{l,:});  % EMR Ranking
        dist1{l,:}   = 1-simEMR1{l,:};      % Dissimilarity 
        dist2{l,:}   = 1-simEMR2{l,:};      % Dissimilarity 
        
        
        X = zeros(2,N);
        X(1,:) = dist1{l,:};
        X(2,:) = dist2{l,:};
    
        X = (X)';
  end
  toc/500
