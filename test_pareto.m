clear all;
close all;
clc;

load('lamdaDataset/hashCodes/filenames.mat');
load('lamdaDataset/hashCodes/hashCodes_64.mat');
load('lamdaDataset/hashCodes/targets.mat');

N = 2000;           % Number of samples in the Lamda Dataset
data = hashCodes_64; % Binary features (Hash codes) N x NumberHasBits
queryIndex1 = 600;
queryIndex2 = 1659;

q1 = data(queryIndex1,:);         % q1 & q2 are query pairs in the loop
q2 = data(queryIndex2,:);
q1_rep = repmat(q1,N,1); % Make query matrix size to the same as data matrix size
q2_rep = repmat(q2,N,1);      
xor_data_q1new = xor(data, q1_rep); % xor of data and query matrices
xor_data_q2new = xor(data, q2_rep);       
hamming_dist1 = sum(xor_data_q1new,2); % sum up rows to get hamming distances
hamming_dist2 = sum(xor_data_q2new,2); 
n_hamming_dist1 = mat2gray(hamming_dist1);
n_hamming_dist2 = mat2gray(hamming_dist2);
        
X = zeros(2,N);
X(1,:) = n_hamming_dist1;
X(2,:) = n_hamming_dist2;
    
X = (X)';
[K,L] = size(unique(X,'rows')) % The number of PPs = K

pf=[];

input=X;

front_level = 4;
for k=1:front_level  % Number of fronts 

   
   
pop_input = [];
temp_pf = [];
membership = [];
temp_input = [];
index = [];
temp_pf = [];



    for i = 1:size(input,1)           

    
        pop_input = repmat(input(i,:),size(input,1),1); 
        
       % if( pop_input(1,1) < 1000 )   
            temp_input = input;
            temp_input(i,:) = ones(1,size(input,2))*1000;  % O satırı kendisi ile kıyaslama         
            index = pop_input >= temp_input; % pop edilen mevcut satırı, satır satır X ile kıyasla, 
                                             % büyükse 1 ,değilse 0 döndür, index 2 sütunlu binary vector   
            
            if(sum(index(:,:),2) < size(input,2)) % index in satırları toplamı 2 den küçük mü, yani her iki 
                                                  % koordinat için pop_input, X ten büyük mü                                                 
                                                  
                temp_pf(end+1,:)=input(i,:); % eğer öyle ise temp_pf'a index i değil , ilgili input u ekle 
            else
                continue; % aksi halde döngüde bir sonraki kısma geç.
            end
               
            
        %end
                         
    end
    
  
    
    membership = ismember(X, temp_pf,'rows'); 
    membership_indexes{k,:} = find(membership); 
    pf{k,1}(:,:) = X(membership_indexes{k,:},:);
    
    pf_idx{k,1}(:,:) = [pf{k,1}(:,:) , membership_indexes{k,:}(:,1)]; 
    pf_idx{k,1}(:,:) = sortrows( pf_idx{k,1}(:,:),1);    
      
    input = setdiff(input,pf{k,1} ,'rows');
end
    
    
