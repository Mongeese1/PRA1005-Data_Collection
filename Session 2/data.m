pkg load io
pkg load windows

filename = 'group_data_2021.xls';
[NUM, TXT, RAW]= xlsread(filename);

n_m = length(find(NUM(:,1)==1));
n_f = length(find(NUM(:,1)==2));
n_l = length(find(NUM(:,2)==1));
n_r = length(find(NUM(:,2)==2));

Mean_times(:,1) = mean(NUM(:,3:6),2);
Mean_times(:,2) = mean(NUM(:,7:10),2);
Mean_times(:,3) = mean(NUM(:,11:14),2);
Mean_times(:,4) = mean(NUM(:,15:18),2);
overall_Mean_Times = mean(NUM(:,3:18),2);
Mean_times = Mean_times./overall_Mean_Times
size(Mean_times)

Intereference(:,1) = Mean_times(:,2) - Mean_times(:,1);
Intereference(:,2) = Mean_times(:,4) - Mean_times(:,3);

Int_diff = Intereference(:,1) - Intereference(:,2);

##subplot(2,2,1)
[n,xout] = hist(Int_diff,25);
f1 = figure;
figure(f1);
plot(xout,n/sum(n),'r')
hold on
plot([mean(Int_diff) mean(Int_diff)], [0 max(n/sum(n))],'c')
title('full data')
xlabel('Int_diff')
ylabel('proportion')
legend([{'data'},{'mean'}])

pkg load statistics

[H,P_c,CI,STATS] = ttest(Int_diff,0)
df_Interference = STATS.df
tstat_Interference = STATS.tstat
p_Interference = P_c


lh = Int_diff(find(NUM(:,2)==1),:);
rh = Int_diff(find(NUM(:,2)==2),:);

f2 = figure;

figure(f2)

##subplot(2,2,2)
bar([1 2] , [mean(lh) mean(rh)]);
hold on
errorbar([1,2],[mean(lh) mean(rh)],[std(lh) std(rh)], 'c.')
set(gca, 'xticklabel',[{'left'},{'right'}])

[H, P , CI, Stats] = ttest2(lh,rh)
df_dom_hand = Stats.df
tstat_dom_hand = Stats.tstat
p_dom_hand = P


m = mean(NUM(find(NUM(:,2)==1),3:18),2);
f = mean(NUM(find(NUM(:,2)==2),3:18),2);
f3 = figure;
figure(f3)
bar([1 2], [mean(m) mean(f)]);
hold on
errorbar([1,2],[mean(m) mean(f)],[std(m) std(f)], 'c.')
set(gca, 'xticklabel',[{'m'},{'f'}])
[H, P , CI, Stats] = ttest2(m,f)
df_sex = Stats.df
tstat_sex = Stats.tstat
p_sex = P
H