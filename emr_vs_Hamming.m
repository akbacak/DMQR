%
% Usage:
%
%      See: http://www.zjucadcg.cn/dengcai/Data/ReproduceExp.html#EMR
%
%Reference:
%
%	 Bin Xu, Jiajun Bu, Chun Chen, Deng Cai, Xiaofei He, Wei Liu, Jiebo
%	 Luo, "Efficient Manifold Ranking for Image Retrieval",in Proceeding of
%	 the 34th International ACM SIGIR Conference on Research and
%	 Development in Information Retrieval (SIGIR), 2011, pp. 525-534.  
%
%   version 2.0 --Feb./2012 
%   version 1.0 --Sep./2010 
%
%   Written by Bin Xu (binxu986 AT gmail.com)
%              Deng Cai (dengcai AT gmail.com)



load('lamdaDataset/hashCodes/hashCodes_64.mat');
data = hashCodes_64;

tic
for m = 1:100
opts.p=1000; 	% the number of landmarks picked (default 1000)
opts.r=2;  	% the number of nearest landmarks for representation (default 5)
opts.a=0.99; 	% weight in manifold ranking, score = (I - aS)^(-1)y, default  0.99
kmMaxIter = 5;
kmNumRep = 1;

nSmp =size(data,1); % Number of samples in the newddb so nSmp=549.
 
[dump,landmarks]=litekmeans(data,opts.p,'MaxIter',kmMaxIter,'Replicates',kmNumRep); 

D = EuDist2(data,landmarks);
dump = zeros(nSmp,opts.r); % dump was a 549x1 vector, but after this it is 549x2 vector !


dump = zeros(nSmp,opts.r);
idx = dump;

for i = 1:opts.r
    [dump(:,i),idx(:,i)] = min(D,[],2);
    temp = (idx(:,i)-1)*nSmp+[1:nSmp]';
    D(temp) = 1e100;
end

dump = bsxfun(@rdivide,dump,dump(:,opts.r));
dump = 0.75 * (1 - dump.^2);
Gsdx = dump;
Gidx = repmat([1:nSmp]',1,opts.r);
Gjdx = idx;
Z=sparse(Gidx(:),Gjdx(:),Gsdx(:),nSmp,opts.p);

model.Z = Z';		%********************************************


% Efficient Ranking
feaSum = full(sum(Z,1));
D = Z*feaSum';
D = max(D, 1e-12);
D = D.^(-.5);
H = spdiags(D,0,nSmp,nSmp)*Z;

C = speye(opts.p);
A = H'*H-(1/opts.a)*C;

% yo construction , for queries its 1 for rest its 0, should get index of the each query!
% below we choose as 1 and three !  manually !!


queryIndex1 = 1;
queryIndex2 = 3;
q1 = data(queryIndex1,:); % first query itself 1x48 matrix
q2 = data(queryIndex2,:); % second query itself 1x48 matrix

y1 = zeros(nSmp,1);
y1(queryIndex1) = 1; % make the value 1 for only query1 rest is the same
y2 = zeros(nSmp,1);
y2(queryIndex2) = 1;

simEMR1 = EMRscore(H ,A, y1);
simEMR2 = EMRscore(H ,A, y2);
    dist_1 = 1-simEMR1;
    dist_2 = 1-simEMR2;

end
toc/100



% Edited by Enver Akbacak
% Codes below calculates pareto points by hamming distances
%

tic

for n=1:100
q1 = data(1,:);
q2 = data(3,:);
N = 2000;  q1new = repmat(q1,N,1);
    q2new = repmat(q2,N,1);
    dist_1 = xor(data, q1new);
    dist_2 = xor(data, q2new);
    dist1 = sum(dist_1,2);
    dist2 = sum(dist_2,2);
end
toc/100



