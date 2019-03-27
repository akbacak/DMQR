clear all;
clc;

x=linspace(0,350,1);



load('Evaluation/DMLH2/DMQR/MQUR/64_mean_MQUR_ALL');
plot(MQUR_ALL_mean,'-.gx');
hold on


load('Evaluation/DMLH2/DMQR/MQUR/128_mean_MQUR_ALL');
plot(MQUR_ALL_mean,'--ro');
hold on

load('Evaluation/DMLH2/DMQR/MQUR/256_mean_MQUR_ALL');
plot(MQUR_ALL_mean,'-.b*');
hold on

load('Evaluation/DMLH2/DMQR/MQUR/512_mean_MQUR_ALL');
plot(MQUR_ALL_mean,'-.kx');
hold on




title('MQUR average of the first 10 pareto fronts.')

ylabel('Mean Value of MQUR Scores')
xlabel('Number of Retrived Items on the Fronts. From middle to the left and to the rigth tails') 

legend({'64 bits DMQR', '128 bits DMQR', '256 bits DMQR', '512 bits DMQR'},'Location','southwest')


