clear all;
clc;

x=linspace(0,350,1);

load('n_DCG_EMR_mean_512');
plot(n_DCG_mean);
hold on


load('n_DCG_EMR_mean_256');
plot(n_DCG_mean);
hold on

load('n_DCG_EMR_mean_128');
plot(n_DCG_mean);
hold on

load('n_DCG_DMQR_mean_512');
plot(n_DCG_mean);
hold on

load('n_DCG_DMQR_mean_256');
plot(n_DCG_mean);
hold on

load('n_DCG_DMQR_mean_128');
plot(n_DCG_mean);
hold on

ylabel('Mean Value of nDCG')
xlabel('Number of Retrived Items on the Fronts. From middle to the left and rigth tails') 

legend({'512 bits EMR','256 bits EMR','128 bits EMR','512 bits DMQR','256 bits DMQR','128 bits DMQR'  },'Location','southwest')