%% correlation132 - FOR CLASS 1,3 AND CLASS 2
%feature extraction from time analysis
% ALPHA RANGE (8-13 HZ) = 12-21 Signals  
% BETA RANGE (14-30 HZ) = 22-47 Signals
% THETA RANGE (4-7 HZ) = 7-11 Signals 
feature.feature132.extracted132.f1 = concatenatedtimefeature(a_c1data.tsquared_c1data.theta,a_c3data.tsquared_c3data.theta,a_c2data.tsquared_c2data.theta,724,1500,1);
feature.feature132.extracted132.f2 = concatenatedtimefeature(a_c1data.tsquared_c1data.beta,a_c3data.tsquared_c3data.beta,a_c2data.tsquared_c2data.beta,724,1500,1);
feature.feature132.extracted132.f3 = concatenatedtimefeature(a_c1data.tsquared_c1data.beta,a_c3data.tsquared_c3data.beta,a_c2data.tsquared_c2data.beta,724,1500,4);

feature.feature132.variance132.feature1 = extractedVariance(feature.feature132.extracted132.f1);
feature.feature132.variance132.feature2 = extractedVariance(feature.feature132.extracted132.f2);
feature.feature132.variance132.feature3 = extractedVariance(feature.feature132.extracted132.f3);

feature.feature132.mean132.feature1 = extracted_mean(a_c1data.tsquared_c1data.theta,a_c3data.tsquared_c3data.theta,a_c2data.tsquared_c2data.theta,724,1500,1);
feature.feature132.mean132.feature2 = extracted_mean(a_c1data.tsquared_c1data.beta,a_c3data.tsquared_c3data.beta,a_c2data.tsquared_c2data.beta,724,1500,1);
feature.feature132.mean132.feature3 = extracted_mean(a_c1data.tsquared_c1data.beta,a_c3data.tsquared_c3data.beta,a_c2data.tsquared_c2data.beta,724,1500,4);

feature.feature132.peak132.feature1 = extractedPeaks(feature.feature132.extracted132.f1);
feature.feature132.peak132.feature2 = extractedPeaks(feature.feature132.extracted132.f2);
feature.feature132.peak132.feature3 = extractedPeaks(feature.feature132.extracted132.f3);

feature.feature132.TMean132.feature1 = extractedTotalMean(feature.feature132.extracted132.f1);
feature.feature132.TMean132.feature2 = extractedTotalMean(feature.feature132.extracted132.f2);
feature.feature132.TMean132.feature3 = extractedTotalMean(feature.feature132.extracted132.f3);

feature.feature132.finalvector132 = horzcat(feature.feature132.variance132.feature1,feature.feature132.variance132.feature2,feature.feature132.variance132.feature3,feature.feature132.mean132.feature1,feature.feature132.mean132.feature2,feature.feature132.mean132.feature3,feature.feature132.peak132.feature1,feature.feature132.peak132.feature2,feature.feature132.peak132.feature3,feature.feature132.TMean132.feature1,feature.feature132.TMean132.feature2,feature.feature132.TMean132.feature3);

feature.feature132.labelvector13 = zeros(1,length(a_c1data.tsquared_c1data.beta(1,1,:))+ length(a_c3data.tsquared_c3data.beta(1,1,:)));
feature.feature132.labelvector2 = ones(1,length(a_c2data.tsquared_c2data.beta(1,1,:)));
feature.feature132.labelvector132 = cat (2, feature.feature132.labelvector13, feature.feature132.labelvector2);
feature.feature132.ldl132 = fitcdiscr(feature.feature132.finalvector132, feature.feature132.labelvector132, 'discrimtype', 'diaglinear');
feature.feature132.svm132 = fitcsvm(feature.feature132.finalvector132, feature.feature132.labelvector132, 'Standardize',true);

[feature.feature132.ldaK_mean30, feature.feature132.ldaStd_data30] = cross_val(feature.feature132.ldl132,30);
[feature.feature132.svmK_mean30, feature.feature132.svmStd_data30] = cross_val(feature.feature132.svm132,30);




%% Extraction of features 

% mean of the data 

%zcd = dsp.ZeroCrossingDetector
%zcdOut = zcd(a_c1data.tsquared_c1data.alpha(724:1500,1,1)) 

%% FOR CUE1 & CUE 2
%feature extraction from time analysis
function[finaldata] = concatenatedtimefeature(data1,data2,data3,timestart,timeend,channel)
% data1 and data2 are combined 
% data 3 
a = featureextract(data1,channel, timestart, timeend);
b = featureextract(data2,channel, timestart, timeend);
c = featureextract(data3,channel, timestart, timeend);
final_data = cat(2,a,b,c);
finaldata = permute(final_data, [2,1]);
end


function[feature_data] = featureextract(data,channel, timestart, timeend)
%extracting information from squareddata for specific band 
feature_data = squeeze(data(timestart:timeend,channel,:));
%feature_data = var(a);
end

function [feature_vector_variance] = extractedVariance(data1)
featureVec = permute(data1,[2 1]);
v = var(featureVec);
feature_vector_variance = permute(v, [2 1]);
end

function[finaldata] = extracted_mean(data1,data2,data3,timestart,timeend,channel)
% data1 and data2 are combined 
% data 3 
a = featureextract(data1,channel, timestart, timeend);
b = featureextract(data2,channel, timestart, timeend);
C = cat(2,a,b);
D = extractedMean(C);
c = featureextract(data3,channel, timestart, timeend);
E =  extractedMean(c);
final_data = cat(2,D,E);
finaldata = permute(final_data, [2,1]);
end

function [feature_vector_mean] = extractedMean(data1)
feature_vector_mean = mean(data1,1);
end
 
function [feature_vector_peaks] = extractedPeaks(data1)
P1 = permute(data1,[2 1]);
peak = max(P1);
P2 = permute(peak,[2 1]);
extracted_data = mean(data1,2);
feature_vector_peaks = extracted_data - P2;
end


function [feature_vector_mean_together] = extractedTotalMean(data1)
Mean = mean(data1,1);
total_mean = mean(Mean);
FM = mean(data1,2);
feature_vector_mean_together = FM - total_mean;
end

function [filtered_data] = filtereddata(order, lowerLimit, upperLimit,data)
    [b,a] = butter(order,[lowerLimit/250,upperLimit/250], 'bandpass');  
    filtered_data = filtfilt(b,a,data);
end

function [K_mean, Std_data] = cross_val(data1,fold)
cross = crossval(data1, 'kfold', fold)
K = kfoldLoss(cross,'Mode','individual');
K = 1-K;
K_mean = mean(K)*100;
Std_data = std(K)*100;
end