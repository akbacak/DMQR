clear all;
clc;

x=linspace(0,350,1);


load('Evaluation_Revision/streetsDataset/DMQR/streets_2d_16_DMQR_n_DCG_mean');
plot(n_DCG_mean, '--g', 'LineWidth',3); 
hold on

load('Evaluation_Revision/streetsDataset/DMQR/streets_2d_32_DMQR_n_DCG_mean');
plot(n_DCG_mean,'-k', 'MarkerSize',18, 'LineWidth',2); 
hold on

load('Evaluation_Revision/streetsDataset/DMQR/streets_2d_64_DMQR_n_DCG_mean');
plot(n_DCG_mean,'-.b', 'MarkerSize',18, 'MarkerFaceColor',[0 0 1], 'LineWidth',3);
hold on

load('Evaluation_Revision/streetsDataset/DMQR/streets_2d_128_DMQR_n_DCG_mean');
plot(n_DCG_mean,'-+r',  'MarkerSize',16, 'LineWidth',3');
hold on

load('Evaluation_Revision/streetsDataset/DMQR/streets_2d_256_DMQR_n_DCG_mean');
plot(n_DCG_mean,'--b', 'MarkerSize',18, 'MarkerFaceColor',[0 0 1], 'LineWidth',3);
hold on

load('Evaluation_Revision/streetsDataset/DMQR/streets_2d_512_DMQR_n_DCG_mean');
plot(n_DCG_mean,'sr',  'MarkerSize',6, 'LineWidth',3');
hold on


set(gca,'FontSize',46);


%title('Average values of nDCG scores along 10 Pareto fronts' ,'FontSize', 32)

ylabel('Average nDCG scores.' ,'FontSize', 38)
xlabel('Maximum size of Pareto front.' ,'FontSize', 38) 

legend({' 16-bit', '32-bit',' 64-bit', '128-bit', '256-bit', '512-bit', },'Location','southwest' ,'FontSize', 38)

