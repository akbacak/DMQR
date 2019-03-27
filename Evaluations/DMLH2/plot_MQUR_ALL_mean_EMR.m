clear all;
clc;

x=linspace(0,350,1);



load('Evaluation/DMLH2/EMR/MQUR/64_mean_MQUR_ALL');
plot(MQUR_ALL_mean,'-.gx');
hold on


load('Evaluation/DMLH2/EMR/MQUR/128_mean_MQUR_ALL');
plot(MQUR_ALL_mean,'--ro');
hold on

load('Evaluation/DMLH2/EMR/MQUR/256_mean_MQUR_ALL');
plot(MQUR_ALL_mean,'-.b*');
hold on

load('Evaluation/DMLH2/EMR/MQUR/512_mean_MQUR_ALL');
plot(MQUR_ALL_mean,'-.kx');
hold on




title('MQUR average of the first 10 pareto fronts.')

ylabel('Mean Value of MQUR Scores')
xlabel('Number of Retrived Items on the Fronts. From middle to the left and to the rigth tails') 

legend({'64 bits EMR', '128 bits EMR', '256 bits EMR', '512 bits EMR'},'Location','southwest')


