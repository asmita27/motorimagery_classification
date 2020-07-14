%% RAW SIGNALS

%{
subplot(1,3,1)
plot(a_data.cue1(:,1,5),'b')
title('Raw signal Cue1')

subplot(1,3,2)
plot(a_data.cue2(:,1,5),'y')
title('Raw signal Cue2')

subplot(1,3,3)
plot(a_data.cue3(:,1,5), 'r')
title('Raw signal Cue3')
%}
%% filtered signals
%%
%{
subplot(1,3,1)
plot(a_c1data.tsquared_c1data.alpha(:,1,5),'b')
title('Filtered Cue1')

subplot(1,3,2)
plot(a_c2data.tsquared_c2data.alpha(:,1,5),'y')
title('Filtered Cue2')

subplot(1,3,3)
plot(a_c2data.tsquared_c2data.alpha(:,1,5), 'r')
title('Filtered Cue3')
%}

%% Power Spectrum
%%
%{
subplot(1,3,1)
plot(a_c1data.tsquared_c1data.alpha(:,1,5),'b')
title('Power Cue1')

subplot(1,3,2)
plot(a_c2data.tsquared_c2data.alpha(:,1,5),'y')
title('Power Cue2')

subplot(1,3,3)
plot(a_c2data.tsquared_c2data.alpha(:,1,5), 'r')
title('Power Cue3')
%}
%% Averaged data
%%
%{
subplot(1,3,1)
plot(a_c1data.taverage_c1data.alpha(:,1),'b')
title('averaged Cue1')

subplot(1,3,2)
plot(a_c2data.taverage_c2data.alpha(:,1),'y')
title('averaged Cue2')

subplot(1,3,3)
plot(a_c3data.taverage_c3data.alpha(:,1), 'r')
title('averaged Cue3')
%}


%% Correlation plots
%%
% correlation 388/250 = 1.552
% 7-30Hz(11-47 samples)
%{
clims = [7 30]


subplot(1,3,1)
imagesc(clims,[1 8], correlation_data.cue12_full(:, 15:47));
colormap (parula)
set(gca, 'YDir', 'normal')
yticklabels({'C3','C1','CP1','PO3','C2','C4','CP2','PO4'})
title('Correlation cue 1 and cue 2')
xlabel('frequency')
ylabel('Channels')
colorbar;

subplot(1,3,2)
imagesc(clims,[1 8], correlation_data.cue23_full(:, 15:47));
colormap (parula)
set(gca, 'YDir', 'normal')
yticklabels({'C3','C1','CP1','PO3','C2','C4','CP2','PO4'})
title('Correlation cue 2 and cue 3')
xlabel('frequency')
ylabel('Channels')
colorbar;

subplot(1,3,3)
imagesc(clims,[1 8], correlation_data.cue13_full(:, 15:47));
colormap (parula)
set(gca, 'YDir', 'normal')
yticklabels({'C3','C1','CP1','PO3','C2','C4','CP2','PO4'})
title('Correlation cue 1 and cue 3')
xlabel('frequency')
ylabel('Channels')
colorbar;
%}
%{

subplot(1,3,1)
imagesc(clims,[1 8], correlation_data.cue123_full(:, 15:47));
colormap (parula)
set(gca, 'YDir', 'normal')
yticklabels({'C3','C1','CP1','PO3','C2','C4','CP2','PO4'})
title('Correlation cue 1, 2 and cue 3')
xlabel('frequency')
ylabel('Channels')
colorbar;

subplot(1,3,2)
imagesc(clims,[1 8], correlation_data.cue231_full(:, 15:47));
colormap (parula)
set(gca, 'YDir', 'normal')
yticklabels({'C3','C1','CP1','PO3','C2','C4','CP2','PO4'})
title('Correlation cue 2, 3 and cue 1')
xlabel('frequency')
ylabel('Channels')
colorbar;

subplot(1,3,3)
imagesc(clims,[1 8], correlation_data.cue132_full(:, 15:47));
colormap (parula)
set(gca, 'YDir', 'normal')
yticklabels({'C3','C1','CP1','PO3','C2','C4','CP2','PO4'})
title('Correlation cue 1, 3 and cue 2')
xlabel('frequency')
ylabel('Channels')
colorbar;
%}

%% TOPOGRAPHIES
%%
%{
subplot(2,3,1)
B = permute(a_c1data.window_c1data.alpha(742:1500,:), [2 1]);
topographies(B)
plot_scalpOutline(mnt,'DrawEars',1)
title('Cue1:Alpha');
colorbar;

subplot(2,3,4)
B = permute(a_c1data.window_c1data.beta(742:1500,:), [2 1]);
topographies(B)
plot_scalpOutline(mnt,'DrawEars',1)
title('Cue1:Beta');
colorbar;

subplot(2,3,2)
B = permute(a_c2data.window_c2data.alpha(742:1500,:), [2 1]);
topographies(B)
plot_scalpOutline(mnt,'DrawEars',1)
title('Cue2:Alpha');
colorbar;

subplot(2,3,5)
B = permute(a_c2data.window_c2data.beta(742:1500,:), [2 1]);
topographies(B)
plot_scalpOutline(mnt,'DrawEars',1)
title('Cue2:Beta');
colorbar;

subplot(2,3,3)
B = permute(a_c3data.window_c3data.alpha(742:1500,:), [2 1]);
topographies(B)
plot_scalpOutline(mnt,'DrawEars',1)
title('Cue3:Alpha');
colorbar;

subplot(2,3,6)
B = permute(a_c3data.window_c3data.beta(742:1500,:), [2 1]);
topographies(B)
plot_scalpOutline(mnt,'DrawEars',1)
title('Cue1:Beta');
colorbar;

%}

%% Topographies
%%
%{
subplot(3,3,1)
B = permute(a_c1data.window_c1data.beta(1:700,:), [2 1]);
topographies(B)
plot_scalpOutline(mnt,'DrawEars',1)
title('Cue1:Beta');
caxis([1.5 4*10^14]);
colorbar;

subplot(3,3,2)
B = permute(a_c1data.window_c1data.beta(701:1500,:), [2 1]);
topographies(B)
plot_scalpOutline(mnt,'DrawEars',1)
title('Cue1:Beta');
caxis([1.5 4*10^14]);
colorbar;

subplot(3,3,3)
B = permute(a_c1data.window_c1data.beta(1500:2245,:), [2 1]);
topographies(B)
plot_scalpOutline(mnt,'DrawEars',1)
title('Cue1:Beta');
caxis([1.5 4*10^14]);
colorbar;


subplot(3,3,4)
B = permute(a_c2data.window_c2data.beta(1:700,:), [2 1]);
topographies(B)
plot_scalpOutline(mnt,'DrawEars',1)
title('Cue2:Beta');
caxis([1.5 4*10^14]);
colorbar;

subplot(3,3,5)
B = permute(a_c2data.window_c2data.beta(701:1500,:), [2 1]);
topographies(B)
plot_scalpOutline(mnt,'DrawEars',1)
title('Cue2:Beta');
caxis([1.5 4*10^14]);
colorbar;

subplot(3,3,6)
B = permute(a_c2data.window_c2data.beta(1500:2245,:), [2 1]);
topographies(B)
plot_scalpOutline(mnt,'DrawEars',1)
title('Cue2:Beta');
caxis([1.5 4*10^14]);
colorbar;

subplot(3,3,7)
B = permute(a_c3data.window_c3data.beta(1:700,:), [2 1]);
topographies(B)
plot_scalpOutline(mnt,'DrawEars',1)
title('Cue3:Beta');
caxis([1.5 4*10^14]);
colorbar;

subplot(3,3,8)
B = permute(a_c3data.window_c3data.beta(701:1500,:), [2 1]);
topographies(B)
plot_scalpOutline(mnt,'DrawEars',1)
title('Cue3:Beta');
caxis([1.5 4*10^14]);
colorbar;

subplot(3,3,9)
B = permute(a_c3data.window_c3data.beta(1500:2245,:), [2 1]);
topographies(B)
plot_scalpOutline(mnt,'DrawEars',1)
title('Cue3:Beta');
caxis([1.5 4*10^14]);
colorbar;
%}

%% 
% 


%% CSP PLOTS
%%
%{
gscatter (CSP.data23.lda.data.XCentered(:,1), CSP.data23.lda.data.XCentered(:,2), CSP.data23.lda.data.Y, 'rb', 'o*')
legend('Cue2', 'Cue3')
title('CSP filter for Cue2 and Cue3')
xlabel('1st CSP projection variance' )
ylabel('last CSP projection variance')
%}

%% csp variance plots
%%
%{
% for given other data
subplot(2,1,1)
plot(A(1,:))
hold on
plot(B(1,:))
legend('Left hand','Right hand');

subplot(2,1,2)
plot(A(2,:))
hold on
plot(B(2,:))
legend('Left hand','Right hand');

%}

%% Time and Frequency graphs
%%
    %{
subplot(2,3,1)
    plot(a_c1data.window_c1data.alpha(300:2245,1))
    hold on
    plot(a_c1data.window_c1data.beta(300:2245,1))
    hold off
    title("time plot for Cue1 for electrode C3");
    legend ('alpha', 'beta');
    
    subplot(2,3,4);
    x(:,:) =squeeze(a_c1data.frequencyanalysisc1.full(:,1,300:2245));
    freqFactor = 250/125;
    freqRange = [3 30];
    imagesc([125 2251], freqRange, x(freqRange(1):freqRange(2),:))
    set(gca,'YDir','normal')
    colorbar;
    title("frequency plot for Cue1 electrode C3" );

    subplot(2,3,2)
    plot(a_c2data.window_c2data.alpha(300:2245,1))
    hold on
    plot(a_c2data.window_c2data.beta(300:2245,1))
    hold off
    title("time plot for Cue2 for electrode C3");
    legend ('alpha', 'beta');
    
    subplot(2,3,5);
    x(:,:) =squeeze(a_c2data.frequencyanalysisc2.full(:,1,300:2245));
    freqFactor = 250/125;
    freqRange = [3 30];
    imagesc([125 2251], freqRange, x(freqRange(1):freqRange(2),:))
    set(gca,'YDir','normal')
    colorbar;
    title("frequency plot for Cue2 electrode C3" );
        
    subplot(2,3,3)
    plot(a_c3data.window_c3data.alpha(300:2245,1))
    hold on
    plot(a_c3data.window_c3data.beta(300:2245,1))
    hold off
    title("time plot for Cue3 for electrode C3");
    legend ('alpha', 'beta');
    
    subplot(2,3,6);
    x(:,:) =squeeze(a_c3data.frequencyanalysisc3.full(:,1,300:2245));
    freqFactor = 250/125;
    freqRange = [3 30];
    imagesc([125 2251], freqRange, x(freqRange(1):freqRange(2),:))
    set(gca,'YDir','normal')
    colorbar;
    title("frequency plot for Cue3 electrode C3" );
    %}
%% ELECTRODES GRAPHS
%%
%{
subplot(1,2,1)
plot(a_c1data.window_c1data.alpha(300:2245,1))
hold on 
plot(a_c2data.window_c2data.alpha(300:2245,1))
plot(a_c3data.window_c3data.alpha(300:2245,1))
legend ('Cue 1','Cue 2','Cue 3')
xticks([1 300 600 900 1200 1500 1900])
xticklabels({'300','600','900','1200', '1500', '1800','2100'})
xlabel('Time')
ylabel('Amplitude')
title('Alpha Band for electrode C3')

subplot(1,2,2)
plot(a_c1data.window_c1data.beta(300:2245,1))
hold on 
plot(a_c2data.window_c2data.beta(300:2245,1))
plot(a_c3data.window_c3data.beta(300:2245,1))
legend ('Cue 1','Cue 2','Cue 3')
xticks([1 300 600 900 1200 1500 1900])
xticklabels({'300','600','900','1200', '1500', '1800','2100'})
xlabel('Time')
ylabel('Amplitude')
title('Beta Band for electrode C3')

%}
%% Ipsilateral and contralateral
%%
%{
plot(a_c1data.window_c1data.beta(300:2245,2))
hold on
plot(a_c1data.window_c1data.beta(300:2245,7))
legend('contralateral', 'ipsilateral')
title('Beta band of Cue1')
%}

%% Accuracy plots for SVM AND LDA Cross validation
%%
%{
ctrs = 1:6;
data1 = [55.84 53.39; 54.45 54.27; 50.33 52.24; 63.18 64; 67.08 67.08; 67.77 69.12];
errhigh = [7.99 6.61; 8.15 8.37; 12.18 1.88; 4.51 1.26; 1.27 1.27; 3.66 0.47];
errlow = [7.99 6.61; 8.15 8.37; 12.18 1.88; 4.51 1.26; 1.27 1.27; 3.66 0.47];
a = data1;
hBar = bar(ctrs, data);
set(gca,'XTickLabel',{'C1&2', 'C1&3', 'C2&3', 'C1,2&3', 'C1,3&2', 'C2,3&1'});
for k1 = 1:size(a,2)
    ctr(k1,:) = bsxfun(@plus, hBar(1).XData, [hBar(k1).XOffset]');
    ydt(k1,:) = hBar(k1).YData;
end
hold on
errorbar(ctr, ydt, errhigh', errlow', '^')
legend ('LDA', 'SVM')
xlabel('Cues')
ylabel('Accuracy')
hold off
%}