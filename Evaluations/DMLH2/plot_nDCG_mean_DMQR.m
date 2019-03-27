clear all;
clc;

x=linspace(0,350,1);




load('Evaluation/DMLH2/DMQR/nDCG/64_mean_nDCG');
plot(n_DCG_mean,'--go'); 
hold on


load('Evaluation/DMLH2/DMQR/nDCG/128_mean_nDCG');
plot(n_DCG_mean,'--r+'); 
hold on

load('Evaluation/DMLH2/DMQR/nDCG/256_mean_nDCG');
plot(n_DCG_mean,'-.bx');
hold on

load('Evaluation/DMLH2/DMQR/nDCG/512_mean_nDCG');
plot(n_DCG_mean,'-.k*');
hold on




title('nDCG averages of first 10 pareto fronts.')

ylabel('Mean Value of nDCGs')
xlabel('Number of Retrived Items on the Fronts. From middle to the left and to the rigth tails') 

legend({'64 bits DMQR','128 bits DMQR','256 bits DMQR','512 bits DMQR' },'Location','southwest')


