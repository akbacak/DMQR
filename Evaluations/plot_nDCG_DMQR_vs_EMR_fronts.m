clear all;
clc;

x=linspace(0,160,1);

load('n_DCG_EMR_mean_fronts_512');
plot(n_DCG_mean_fronts(1,:),'-y');
hold on

load('n_DCG_EMR_mean_fronts_512');
plot(n_DCG_mean_fronts(2,:),'g');
hold on

load('n_DCG_EMR_mean_fronts_512');
plot(n_DCG_mean_fronts(3,:),'b');
hold on

load('n_DCG_DMQR_mean_fronts_512');
plot(n_DCG_mean_fronts(1,:),'k');
hold on

load('n_DCG_DMQR_mean_fronts_512');
plot(n_DCG_mean_fronts(2,:),'r');
hold on

load('n_DCG_DMQR_mean_fronts_512');
plot(n_DCG_mean_fronts(3,:),'m');
hold on

title('Averages of First 3 Fronts. 512 Bits Hash Codes was used ')

ylabel('Mean Value of nDCG')
xlabel('Number of Retrived Items on the Fronts. From middle to the left and rigth tails') 

legend({'EMR 1st Front','EMR 2nd Front','EMR 3rd Front','DMQR 1st Front','DMQR 2nd Front','DMQR 3rd Front'  },'Location','southwest')

hold off;