clear all;
clc;

x=linspace(0,350,1);

load('MQUR_ALL_mean_EMR2_512');
plot(MQUR_ALL_mean,'-b');
hold on


load('MQUR_ALL_mean_EMR2_256');
plot(MQUR_ALL_mean,'r');
hold on




load('MQUR_ALL_mean_DMQR2_512');
plot(MQUR_ALL_mean,'k');
hold on

load('MQUR_ALL_mean_DMQR2_256');
plot(MQUR_ALL_mean,'g');
hold on



title('MQUR Averages of All Fronts ')

ylabel('Mean Value of MQUR Scores')
xlabel('Number of Retrived Items on the Fronts. From middle to the left and rigth tails') 

legend({'512 bits EMR','256 bits EMR','512 bits DMQR','256 bits DMQR'  },'Location','southwest')

hold off;