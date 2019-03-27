clear all;
clc;

x=linspace(0,350,1);



load('Evaluation/DMLH2/EMR/nDCG/64_mean_nDCG');
plot(n_DCG_mean,'-.gx');
hold on


load('Evaluation/DMLH2/EMR/nDCG/128_mean_nDCG');
plot(n_DCG_mean,'--ro');
hold on

load('Evaluation/DMLH2/EMR/nDCG/256_mean_nDCG');
plot(n_DCG_mean,'-.b*');
hold on

load('Evaluation/DMLH2/EMR/nDCG/512_mean_nDCG');
plot(n_DCG_mean,'-.kx');
hold on




title('nDCG averages of first 10 pareto fronts.')

ylabel('Mean Value of nDCGs')
xlabel('Number of Retrived Items on the Fronts. From middle to the left and to the rigth tails') 

legend({'64 bits EMR', '128 bits EMR', '256 bits EMR', '512 bits EMR'},'Location','southwest')


