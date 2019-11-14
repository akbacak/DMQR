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
    %queryIndex1 = queryIndex(1,:); % First element of Query Pair
    %queryIndex2 = queryIndex(2,:); % Second element of Qury Pair
    %queryIndex1 = 543;
    %queryIndex2 = 1717;
    
    
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
                
        maxFront = 10; 
        
        [pf_idx] = pareto_fronts(X, maxFront);   
        
        
        q1_label{l,:} = targets(queryIndex1(:,l), : ); % Label vector of Query 1
        q2_label{l,:} = targets(queryIndex2(:,l), : ); % Label vector of Query 2
        
        b{l,:} = or(q1_label{l,:} , q2_label{l,:});    % beta in the equation 7 
        absolute_b{l,:} = nnz(b{l,:});                 % Number of non-zero elements in the beta, nnz is a Matlab Func.
        
         
        for j  =1:maxFront
            
            Labels{l,j} = targets(pf_idx{j,1}(:,3),:);
                                     
            [R(l,j) , C(l,j)] = size(Labels{l,j});        
            
              
           
            
            switch (mod(R(l,j) ,2) == 1)
                case 1
                     e_left(l,j) = (round(R(l,j) / 2) - 1) ;  
                     e_rigth(l,j)= (round(R(l,j) / 2)    ) ;
                case 0
                     e_left(l,j)  =  R(l,j) / 2 ;
                     e_rigth(l,j) =  R(l,j) / 2 ;
            end
            
            
           
            % ALL MQUR scores for each query pairs,  each front X Number of retrieved items               
            for e = 1:R(l,j)               
                MQUR_ALL{l,:}(j,e) =  nnz( and(Labels{l,j}(e,:) , b{l,:} ) ) /  absolute_b{l,:};
                                           
            end 
        end
    end