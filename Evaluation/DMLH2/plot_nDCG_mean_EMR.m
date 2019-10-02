clear all;
clc;

x=linspace(0,350,1);

load('Evaluation/DMLH2/EMR/nDCG/512_mean_nDCG');
plot(n_DCG_mean,'-k*');
hold on


load('Evaluation/DMLH2/EMR/nDCG/256_mean_nDCG');
plot(n_DCG_mean,'-rx');
hold on

load('Evaluation/DMLH2/EMR/nDCG/128_mean_nDCG');
plot(n_DCG_mean,'-b+');
hold on

load('Evaluation/DMLH2/EMR/nDCG/64_mean_nDCG');
plot(n_DCG_mean,'-go');
hold on







title('nDCG averages of the first 10 pareto fronts.' ,'FontSize', 24)

ylabel('Mean Value of nDCGs' ,'FontSize', 24)
xlabel('Number of Retrived Items on the Fronts. From middle to the left and to the rigth tails' ,'FontSize', 24) 

legend({'512 bits EMR', '256 bits EMR', '128 bits EMR', '64 bits EMR'},'Location','southwest' ,'FontSize', 24)


