
%*****************************************************************************************
% Edited by Enver Akbacak, 11/2018
% Marmara University, Istanbul
% akbacakk@gmail.com
%
%
% This code computes indexes of images in which their MQUR score = 1 for
% two query case
   
% function [rtr_idx] = final_retrieval(num_fronts)

%maxFront = num_fronts;

for ll = 1:maxFront
    
    rtr_idx{ll,1} = [];

    
    [v(ll) , k(ll)] = size(MQUR_ALL{1,1}(ll,:)); % k(ll) is the size of column vector of ll th front
    
    for ff = 1:k(ll)
        if  MQUR_ALL{1,1}(ll,ff) == 1    
            
            rtr_idx{ll,:}(end+1,:) = pf_idx{ll,1}( ff , 3);
            %rtr_idx{ll,:}(end+1,:) = pf_idx{ll,1}( ff , :);
        end
          
    end
             
    
end