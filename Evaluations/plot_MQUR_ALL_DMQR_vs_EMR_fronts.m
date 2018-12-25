clear all;
clc;

x=linspace(0,160,1);

load('MQUR_ALL_fronts_mean_EMR_512');
plot(MQUR_ALL_fronts_mean(1,:),'-y');
hold on

load('MQUR_ALL_fronts_mean_EMR_512');
plot(MQUR_ALL_fronts_mean(2,:),'g');
hold on

load('MQUR_ALL_fronts_mean_EMR_512');
plot(MQUR_ALL_fronts_mean(3,:),'b');
hold on

load('MQUR_ALL_fronts_mean_DMQR_512');
plot(MQUR_ALL_fronts_mean(1,:),'k');
hold on

load('MQUR_ALL_fronts_mean_DMQR_512');
plot(MQUR_ALL_fronts_mean(2,:),'r');
hold on

load('MQUR_ALL_fronts_mean_DMQR_512');
plot(MQUR_ALL_fronts_mean(3,:),'m');
hold on



title('MQUR Averages of First 3 Fronts. 512 Bits Hash Codes was used ')

ylabel('Mean Value of MQUR Scores')
xlabel('Number of Retrived Items on the Fronts. From middle to the left and rigth tails') 

legend({'EMR 1st Front','EMR 2nd Front','EMR 3rd Front','DMQR 1st Front','DMQR 2nd Front','DMQR 3rd Front'  },'Location','southwest')

hold off;