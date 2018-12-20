for ll=1:l
    for jj=1:j
        [RR(ll,jj) , CC(ll,jj)] = size(n_DCG{ll,jj}); % Find size of each matrix in the n_DCG array
        
    end
end
max_RR = max(CC(:)); % Find max size of n_DCG row

for ll=1:l
    for jj=1:j
        n_DCG_zp{ll,jj}(1,:) =  [ n_DCG{ll,jj}(1,:) ,(zeros(1 ,max_RR - CC(ll,jj) ))]; % Zero padding of all elements  in the n_DCG
        
    end
end


n_DCG_zp_mean =[];

for jj=1:j
    n_DCG_zp_sum  =0;
    for ll=1:l
           
            n_DCG_zp_sum =  n_DCG_zp_sum  + n_DCG_zp{ll,jj}(1,:) ;
           
    end
    n_DCG_zp_mean(end+1,:) =  n_DCG_zp_sum/ll;
    
end
