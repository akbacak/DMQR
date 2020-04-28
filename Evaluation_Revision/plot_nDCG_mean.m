clear all;
clc;

x=linspace(0,350,1);


load('Evaluation_Revision/lamdaDataset/DMQR/5d_16_DMQR_n_DCG_mean');
plot(n_DCG_mean, '-.k', 'LineWidth',3); 
hold on

load('Evaluation_Revision/lamdaDataset/DMQR/5d_32_DMQR_n_DCG_mean');
plot(n_DCG_mean,'-r', 'MarkerSize',18, 'LineWidth',4); 
hold on

load('Evaluation_Revision/lamdaDataset/DMQR/5d_64_DMQR_n_DCG_mean');
plot(n_DCG_mean,'-b', 'MarkerSize',8, 'MarkerFaceColor',[0 0 1], 'LineWidth',3);
hold on

load('Evaluation_Revision/lamdaDataset/DMQR/5d_128_DMQR_n_DCG_mean');
plot(n_DCG_mean,'-gd',  'MarkerSize',10, 'MarkerFaceColor',[0 1 0], 'LineWidth',1');
hold on

load('Evaluation_Revision/lamdaDataset/DMQR/5d_256_DMQR_n_DCG_mean');
plot(n_DCG_mean,'-bo', 'MarkerSize',10, 'MarkerFaceColor',[0 0 1], 'LineWidth',1);
hold on

load('Evaluation_Revision/lamdaDataset/DMQR/5d_512_DMQR_n_DCG_mean');
plot(n_DCG_mean,'-rs',  'MarkerSize',10, 'MarkerFaceColor',[1 0 0],  'LineWidth',1');
hold on


set(gca,'FontSize',46);


%title('Average values of nDCG scores along 10 Pareto fronts' ,'FontSize', 32)

ylabel('Average nDCG scores.' ,'FontSize', 38)
xlabel('Maximum size of Pareto front.' ,'FontSize', 38) 

legend({' 16-bit', '32-bit',' 64-bit', '128-bit', '256-bit', '512-bit', },'Location','southwest' ,'FontSize', 38)

