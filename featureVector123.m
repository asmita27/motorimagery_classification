%% correlation123 - FOR CLASS 1,2 AND CLASS 3
%feature extraction from time analysis

% ALPHA RANGE (8-13 HZ) = 12-21 Signals  
% BETA RANGE (14-30 HZ) = 22-47 Signals
% THETA RANGE (4-7 HZ) = 7-11 Signals 
feature.feature123.extracted123.f1 = concatenatedtimefeature(a_c1data.tsquared_c1data.theta,a_c2data.tsquared_c2data.theta,a_c3data.tsquared_c3data.theta,724,1500,1);
feature.feature123.extracted123.f2 = concatenatedtimefeature(a_c1data.tsquared_c1data.alpha,a_c2data.tsquared_c2data.alpha,a_c3data.tsquared_c3data.alpha,724,1500,1);
feature.feature123.extracted123.f3 = concatenatedtimefeature(a_c1data.tsquared_c1data.beta,a_c2data.tsquared_c2data.beta,a_c3data.tsquared_c3data.beta,724,1500,1);
feature.feature123.extracted123.f4 = concatenatedtimefeature(a_c1data.tsquared_c1data.beta,a_c2data.tsquared_c2data.beta,a_c3data.tsquared_c3data.beta,724,1500,4);
feature.feature123.extracted123.f5 = concatenatedtimefeature(a_c1data.tsquared_c1data.alpha,a_c2data.tsquared_c2data.alpha,a_c3data.tsquared_c3data.alpha,724,1500,6);
feature.feature123.extracted123.f6 = concatenatedtimefeature(a_c1data.tsquared_c1data.beta,a_c2data.tsquared_c2data.beta,a_c3data.tsquared_c3data.beta,724,1500,8);


feature.feature123.variance123.feature1 = extractedVariance(feature.feature123.extracted123.f1);
feature.feature123.variance123.feature2 = extractedVariance(feature.feature123.extracted123.f2);
feature.feature123.variance123.feature3 = extractedVariance(feature.feature123.extracted123.f3);
feature.feature123.variance123.feature4 = extractedVariance(feature.feature123.extracted123.f4);
feature.feature123.variance123.feature5 = extractedVariance(feature.feature123.extracted123.f5);
feature.feature123.variance123.feature6 = extractedVariance(feature.feature123.extracted123.f6);

feature.feature123.mean123.feature1 = extracted_mean(a_c1data.tsquared_c1data.theta,a_c2data.tsquared_c2data.theta,a_c3data.tsquared_c3data.theta,724,1500,1);
feature.feature123.mean123.feature2 = extracted_mean(a_c1data.tsquared_c1data.alpha,a_c2data.tsquared_c2data.alpha,a_c3data.tsquared_c3data.alpha,724,1500,1);
feature.feature123.mean123.feature3 = extracted_mean(a_c1data.tsquared_c1data.beta,a_c2data.tsquared_c2data.beta,a_c3data.tsquared_c3data.beta,724,1500,1);
feature.feature123.mean123.feature4 = extracted_mean(a_c1data.tsquared_c1data.beta,a_c2data.tsquared_c2data.beta,a_c3data.tsquared_c3data.beta,724,1500,4);
feature.feature123.mean123.feature5 = extracted_mean(a_c1data.tsquared_c1data.alpha,a_c2data.tsquared_c2data.alpha,a_c3data.tsquared_c3data.alpha,724,1500,6);
feature.feature123.mean123.feature6 = extracted_mean(a_c1data.tsquared_c1data.beta,a_c2data.tsquared_c2data.beta,a_c3data.tsquared_c3data.beta,724,1500,8);

feature.feature123.peak123.feature1 = extractedPeaks(feature.feature123.extracted123.f1);
feature.feature123.peak123.feature2 = extractedPeaks(feature.feature123.extracted123.f2);
feature.feature123.peak123.feature3 = extractedPeaks(feature.feature123.extracted123.f3);
feature.feature123.peak123.feature4 = extractedPeaks(feature.feature123.extracted123.f4);
feature.feature123.peak123.feature5 = extractedPeaks(feature.feature123.extracted123.f5);
feature.feature123.peak123.feature6 = extractedPeaks(feature.feature123.extracted123.f6);


feature.feature123.TMean123.feature1 = extractedTotalMean(feature.feature123.extracted123.f1);
feature.feature123.TMean123.feature2 = extractedTotalMean(feature.feature123.extracted123.f2);
feature.feature123.TMean123.feature3 = extractedTotalMean(feature.feature123.extracted123.f3);
feature.feature123.TMean123.feature4 = extractedTotalMean(feature.feature123.extracted123.f4);
feature.feature123.TMean123.feature5 = extractedTotalMean(feature.feature123.extracted123.f5);
feature.feature123.TMean123.feature6 = extractedTotalMean(feature.feature123.extracted123.f6);

feature.feature123.finalvector123 = horzcat(feature.feature123.variance123.feature1,feature.feature123.variance123.feature2,feature.feature123.variance123.feature3,feature.feature123.variance123.feature4,feature.feature123.variance123.feature5,feature.feature123.variance123.feature6,feature.feature123.mean123.feature1,feature.feature123.mean123.feature2,feature.feature123.mean123.feature3,feature.feature123.mean123.feature4,feature.feature123.mean123.feature5,feature.feature123.mean123.feature6,feature.feature123.peak123.feature1,feature.feature123.peak123.feature2,feature.feature123.peak123.feature3,feature.feature123.peak123.feature4,feature.feature123.peak123.feature5,feature.feature123.peak123.feature6,feature.feature123.TMean123.feature1,feature.feature123.TMean123.feature2,feature.feature123.TMean123.feature3,feature.feature123.TMean123.feature4,feature.feature123.TMean123.feature5,feature.feature123.TMean123.feature6);

feature.feature123.labelvector1 = zeros(1,length(a_c1data.tsquared_c1data.beta(1,1,:))+ length(a_c2data.tsquared_c2data.beta(1,1,:)));
feature.feature123.labelvector2 = ones(1,length(a_c3data.tsquared_c3data.beta(1,1,:)));
feature.feature123.labelvector = cat (2, feature.feature123.labelvector1, feature.feature123.labelvector2);

feature.feature123.ldl123 = fitcdiscr(feature.feature123.finalvector123, feature.feature123.labelvector, 'discrimtype', 'diaglinear');
feature.feature123.svm123 = fitcsvm(feature.feature123.finalvector123, feature.feature123.labelvector, 'Standardize',true);

[feature.feature123.ldaK_mean30, feature.feature123.ldaStd_data30] = cross_val(feature.feature123.ldl123,30);
[feature.feature123.svmK_mean30, feature.feature123.svmStd_data30] = cross_val(feature.feature123.svm123,30);

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