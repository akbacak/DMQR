clear all;
clc;

x=linspace(0,160,1);

load('DMQR_512_mean_nDCG_10_fronts');
plot(n_DCG_mean_fronts(1,:),'-.k*');
hold on

clear;
load('DMQR_512_mean_nDCG_10_fronts');
plot(n_DCG_mean_fronts(5,:),'-bo');
hold on

clear;
load('DMQR_512_mean_nDCG_10_fronts');
plot(n_DCG_mean_fronts(10,:),'--rs');
hold on




title('nDCG Averages of Fronts of DMQR Algorithm. 512 Bits Hash Code Used ')

ylabel('Mean Value of nDCG')
xlabel('Number of Retrived Items on the Fronts. From middle to the left and rigth tails') 

legend({'Front 1','Front 5','Front 10'},'Location','southwest')

hold off;