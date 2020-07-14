%% correlation13 - FOR CLASS 1 AND CLASS 3
%feature extraction from time analysis
% ALPHA RANGE (8-13 HZ) = 12-21 Signals  
% BETA RANGE (14-30 HZ) = 22-47 Signals
% THETA RANGE (4-7 HZ) = 7-11 Signals 
feature.feature13.extracted13.f1 = concatenatedtimefeature(a_c2data.tsquared_c2data.beta,a_c3data.tsquared_c3data.beta,724,1500,1);
feature.feature13.extracted13.f2 = concatenatedtimefeature(a_c2data.tsquared_c2data.theta,a_c3data.tsquared_c3data.theta,724,1500,1);
feature.feature13.extracted13.f3 = concatenatedtimefeature(a_c2data.tsquared_c2data.beta,a_c3data.tsquared_c3data.beta,724,1500,4);

feature.feature13.variance13.feature1 = extractedVariance(feature.feature13.extracted13.f1);
feature.feature13.variance13.feature2 = extractedVariance(feature.feature13.extracted13.f2);
feature.feature13.variance13.feature3 = extractedVariance(feature.feature13.extracted13.f3);

feature.feature13.mean13.feature1 = extracted_mean(a_c2data.tsquared_c2data.beta,a_c3data.tsquared_c3data.beta,724,1500,1);
feature.feature13.mean13.feature2 = extracted_mean(a_c2data.tsquared_c2data.theta,a_c3data.tsquared_c3data.theta,724,1500,1);
feature.feature13.mean13.feature3 = extracted_mean(a_c2data.tsquared_c2data.beta,a_c3data.tsquared_c3data.beta,724,1500,4);

feature.feature13.peak13.feature1 = extractedPeaks(feature.feature13.extracted13.f1);
feature.feature13.peak13.feature2 = extractedPeaks(feature.feature13.extracted13.f2);
feature.feature13.peak13.feature3 = extractedPeaks(feature.feature13.extracted13.f3);

feature.feature13.TMean13.feature1 = extractedTotalMean(feature.feature13.extracted13.f1);
feature.feature13.TMean13.feature2 = extractedTotalMean(feature.feature13.extracted13.f2);
feature.feature13.TMean13.feature3 = extractedTotalMean(feature.feature13.extracted13.f3);


feature.feature13.finalvector13 = horzcat(feature.feature13.variance13.feature1,feature.feature13.variance13.feature2,feature.feature13.variance13.feature3,feature.feature13.mean13.feature1,feature.feature13.mean13.feature2,feature.feature13.mean13.feature3,feature.feature13.peak13.feature1,feature.feature13.peak13.feature2,feature.feature13.peak13.feature3,feature.feature13.TMean13.feature1,feature.feature13.TMean13.feature2,feature.feature13.TMean13.feature3);

feature.feature13.labelvector1 = zeros(1,length(a_c2data.tsquared_c2data.beta(1,1,:)));
feature.feature13.labelvector2 = ones(1,length(a_c3data.tsquared_c3data.beta(1,1,:)));
feature.feature13.labelvector = cat (2, feature.feature13.labelvector1, feature.feature13.labelvector2);

feature.feature13.ldl13 = fitcdiscr(feature.feature13.finalvector13, feature.feature13.labelvector, 'discrimtype', 'diaglinear');
feature.feature13.svm13 = fitcsvm(feature.feature13.finalvector13, feature.feature13.labelvector, 'Standardize',true);

[feature.feature13.ldaK_mean30, feature.feature13.ldaStd_data30] = cross_val(feature.feature13.ldl13,30);
[feature.feature13.svmK_mean30, feature.feature13.svmStd_data30] = cross_val(feature.feature13.svm13,30);



%% Extraction of features 

% mean of the data 

%zcd = dsp.ZeroCrossingDetector
%zcdOut = zcd(a_c1data.tsquared_c1data.alpha(724:1500,1,1)) 

%% FOR CUE1 & CUE 2
%feature extraction from time analysis
function[finaldata] = concatenatedtimefeature(data1,data2,timestart,timeend,channel)
b = featureextract(data1,channel, timestart, timeend);
c = featureextract(data2,channel, timestart, timeend);
final_data = cat(2,b,c);
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
  function[finaldata] = extracted_mean(data1,data2, timestart,timeend,channel) 
a = featureextract(data1,channel, timestart, timeend);
D = extractedMean(a);
c = featureextract(data2,channel, timestart, timeend);
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