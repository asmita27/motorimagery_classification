%% FOR CUE1 & CUE 2 - FOR CLASS 1 AND CLASS 2
%feature extraction from time analysis
% for channel 1 and channel 2 correlation 
% ALPHA RANGE (8-13 HZ) = 12-21 Signals  
% BETA RANGE (14-30 HZ) = 22-47 Signals
% THETA RANGE (4-7 HZ) = 7-11 Signals 
%{
zc = squeeze(filtereddata(5, 8, 13, a_data.cue1(724:1500,2,:)));
[~,imax]=max(zc);
x0=zc(imax);

inds=find(diff(sign(zc))); %find indices of sign change
zerocrosses=(zc(inds+1)+zc(inds))/2; %in between grid points

ind1=find(zerocrosses<x0,1,'last');
ind2=find(zerocrosses>x0,1,'first');

first_cross=zerocrosses(ind1);
second_cross=zerocrosses(ind2);
%}

feature.feature12.extracted12.f1 = concatenatedtimefeature(a_c1data.tsquared_c1data.beta,a_c2data.tsquared_c2data.beta,724,1500,1);
feature.feature12.extracted12.f2 = concatenatedtimefeature(a_c1data.tsquared_c1data.beta,a_c2data.tsquared_c2data.beta,724,1500,2);
feature.feature12.extracted12.f3 = concatenatedtimefeature(a_c1data.tsquared_c1data.alpha,a_c2data.tsquared_c2data.alpha,724,1500,4);
feature.feature12.extracted12.f4= concatenatedtimefeature(a_c1data.tsquared_c1data.beta,a_c2data.tsquared_c2data.beta,724,1500,8);
feature.feature12.extracted12.f5 = concatenatedtimefeature(a_c1data.tsquared_c1data.alpha,a_c2data.tsquared_c2data.alpha,724,1500,8);

feature.feature12.variance12.feature1 = extractedVariance(feature.feature12.extracted12.f1);
feature.feature12.variance12.feature2 = extractedVariance(feature.feature12.extracted12.f2);
feature.feature12.variance12.feature3 = extractedVariance(feature.feature12.extracted12.f3);
feature.feature12.variance12.feature4 = extractedVariance(feature.feature12.extracted12.f4);
feature.feature12.variance12.feature5 = extractedVariance(feature.feature12.extracted12.f5);

feature.feature12.mean12.feature1 = extracted_mean(a_c1data.tsquared_c1data.beta,a_c2data.tsquared_c2data.beta,724,1500,1);
feature.feature12.mean12.feature2 = extracted_mean(a_c1data.tsquared_c1data.beta,a_c2data.tsquared_c2data.beta,724,1500,2);
feature.feature12.mean12.feature3 = extracted_mean(a_c1data.tsquared_c1data.alpha,a_c2data.tsquared_c2data.alpha,724,1500,4);
feature.feature12.mean12.feature4 = extracted_mean(a_c1data.tsquared_c1data.beta,a_c2data.tsquared_c2data.beta,724,1500,8);
feature.feature12.mean12.feature5 = extracted_mean(a_c1data.tsquared_c1data.alpha,a_c2data.tsquared_c2data.alpha,724,1500,8);

feature.feature12.peak12.feature1 = extractedPeaks(feature.feature12.extracted12.f1);
feature.feature12.peak12.feature2 = extractedPeaks(feature.feature12.extracted12.f2);
feature.feature12.peak12.feature3 = extractedPeaks(feature.feature12.extracted12.f3);
feature.feature12.peak12.feature4 = extractedPeaks(feature.feature12.extracted12.f4);
feature.feature12.peak12.feature5 = extractedPeaks(feature.feature12.extracted12.f5);

feature.feature12.TMean12.feature1 = extractedTotalMean(feature.feature12.extracted12.f1);
feature.feature12.TMean12.feature2 = extractedTotalMean(feature.feature12.extracted12.f2);
feature.feature12.TMean12.feature3 = extractedTotalMean(feature.feature12.extracted12.f3);
feature.feature12.TMean12.feature4 = extractedTotalMean(feature.feature12.extracted12.f4);
feature.feature12.TMean12.feature5 = extractedTotalMean(feature.feature12.extracted12.f5);


feature.feature12.finalvector12 = horzcat(feature.feature12.variance12.feature1,feature.feature12.variance12.feature2,feature.feature12.variance12.feature3,feature.feature12.variance12.feature4,feature.feature12.variance12.feature5,feature.feature12.mean12.feature1,feature.feature12.mean12.feature2,feature.feature12.mean12.feature3,feature.feature12.mean12.feature4,feature.feature12.mean12.feature5,feature.feature12.peak12.feature1,feature.feature12.peak12.feature2,feature.feature12.peak12.feature3,feature.feature12.peak12.feature4,feature.feature12.peak12.feature5,feature.feature12.TMean12.feature1,feature.feature12.TMean12.feature2,feature.feature12.TMean12.feature3,feature.feature12.TMean12.feature4,feature.feature12.TMean12.feature5);

feature.feature12.labelvector1 = zeros(1,length(a_c1data.tsquared_c1data.beta(1,1,:)));
feature.feature12.labelvector2 = ones(1,length(a_c2data.tsquared_c2data.beta(1,1,:)));
feature.feature12.labelvector12 = cat (2, feature.feature12.labelvector1, feature.feature12.labelvector2);

feature.feature12.ldl12 = fitcdiscr(feature.feature12.finalvector12, feature.feature12.labelvector12, 'discrimtype', 'diaglinear');
feature.feature12.svm12 = fitcsvm(feature.feature12.finalvector12, feature.feature12.labelvector12, 'Standardize',true);

[feature.feature12.ldaK_mean30, feature.feature12.ldaStd_data30] = cross_val(feature.feature12.ldl12,30);
[feature.feature12.svmK_mean30, feature.feature12.svmStd_data30] = cross_val(feature.feature12.svm12,30);

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
% data1 and data2 are combined 
% data 3 
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