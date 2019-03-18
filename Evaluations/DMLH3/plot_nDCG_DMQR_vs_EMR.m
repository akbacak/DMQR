clear all;
clc;

x=linspace(0,350,1);

load('EMR_512_mean_nDCG_all');
plot(n_DCG_mean,'-.k*');
hold on

load('EMR_256_mean_nDCG_all');
plot(n_DCG_mean,'--go'); 
hold on



load('DMQR_512_mean_nDCG_all');
plot(n_DCG_mean,'-.bx');
hold on

load('DMQR_256_mean_nDCG_all');
plot(n_DCG_mean,':rs');
hold on


title('nDCG Averages of All Pareto Fronts.')

ylabel('Mean Value of nDCGs')
xlabel('Number of Retrived Items on the Fronts. From middle to the left and to the rigth tails') 

legend({'512 bits EMR','256 bits EMR','512 bits DMQR','256 bits DMQR'},'Location','southwest')

hold off;