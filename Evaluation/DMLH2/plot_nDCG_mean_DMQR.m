clear all;
clc;

x=linspace(0,350,1);



load('Evaluation/DMLH2/DMQR/nDCG/3_512_mean_nDCG');
plot(n_DCG_mean,'-k*');
hold on

load('Evaluation/DMLH2/DMQR/nDCG/3_256_mean_nDCG');
plot(n_DCG_mean,'-rx');
hold on


load('Evaluation/DMLH2/DMQR/nDCG/3_128_mean_nDCG');
plot(n_DCG_mean,'-b+'); 
hold on


load('Evaluation/DMLH2/DMQR/nDCG/3_64_mean_nDCG');
plot(n_DCG_mean,'-go'); 
hold on




title('nDCG averages of the first 10 pareto fronts.','FontSize', 24 )

ylabel('Mean Value of nDCGs', 'FontSize', 24)
xlabel('Number of Retrived Items on the Fronts. From middle to the left and to the rigth tails', 'FontSize', 24) 

legend({'512 bits DMQIR','256 bits DMQIR','128 bits DMQIR','64 bits DMQIR',  },'Location','southwest', 'FontSize', 24)

