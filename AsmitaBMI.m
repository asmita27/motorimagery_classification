% @AUTHOR: NEHCHAL AND ASMITA 
% The follwoing code is for Signal processing and classification of EEG
% signals for 8 electrodes and over 1050 trials for 3 classes according to
% uncertainty. 
%The follwoing steps were used for the signal processing which are also
%elaborated further in their function
% STEP 1: DATA PREPARE 
% STEP 2: cue combined data 
% STEP 3: bandpass, filtering and squaring data with 500HZ sampling frequency rate 
% STEP 4: averaging over trials 
% STEP 5: baseline extraction for separate cues 
% STEP 6: TIME ANALYSIS for averaged data   
% STEP 7 : FREQUENCY ANALYSIS
% STEP 8 : CORRELATION 
% STEP 9 : FEATURE VECTORS IN SEPARATE FILE 
% STEP 10 : COMMON SPATIAL PATTERN 

%% eeg and vbot files read

vbot_1 = "201905171246data.DAT";    
eeg_1 = "201905171246data_EnobioData.csv";

vbot_2 = "201905171217data.DAT";
eeg_2= "201905171217data_EnobioData.csv";

vbot_3 = "201905171146data.DAT";
eeg_3= "201905171146data_EnobioData.csv";

vbot_4 = "201905171115data.DAT";
eeg_4 = "201905171115data_EnobioData.csv";

vbot_5 ="201905171044data.DAT";
eeg_5 = "201905171044data_EnobioData.csv";

%% preparation of the data 

a_data1= dataPrepare(vbot_1,eeg_1);
a_data2 = dataPrepare(vbot_2,eeg_2);
a_data3 = dataPrepare(vbot_3,eeg_3);
a_data4 = dataPrepare(vbot_4,eeg_4);
a_data5 = dataPrepare(vbot_5,eeg_5);

%% segregated according to cues

[a_data1.cue1,a_data1.cue2,a_data1.cue3]  = seperateClasses(vbot_1,a_data1.data);
[a_data2.cue1,a_data2.cue2,a_data2.cue3]  = seperateClasses(vbot_2,a_data2.data);
[a_data3.cue1,a_data3.cue2,a_data3.cue3]  = seperateClasses(vbot_3,a_data3.data);
[a_data4.cue1,a_data4.cue2,a_data4.cue3]  = seperateClasses(vbot_4,a_data4.data);
[a_data5.cue1,a_data5.cue2,a_data5.cue3]  = seperateClasses(vbot_5,a_data5.data);

%% Concatenate files 

[a_data.data,a_data.cue1,a_data.cue2,a_data.cue3] = concatenate(a_data1,a_data2);
[a_data.data,a_data.cue1,a_data.cue2,a_data.cue3] = concatenate(a_data,a_data3);
[a_data.data,a_data.cue1,a_data.cue2,a_data.cue3] = concatenate(a_data,a_data4);
[a_data.data,a_data.cue1,a_data.cue2,a_data.cue3] = concatenate(a_data,a_data5);

%% removal artifacts 

a_data.indices_c1 = [17, 21, 77, 84, 275, 276, 277, 285, 286, 287, 288, 289, 290, 291, 293, 300, 302, 305, 306, 308, 309, 310, 311, 314, 315, 316, 317, 318];
a_data.indices_c2 = [10,35,76,86, 114,117, 184,191,208,217,223,226,230,250,277,328,329,331,334,341,342];
a_data.indices_c3 = [12, 86, 117, 131, 191, 193, 196, 238, 242, 243, 244, 246, 256, 269, 283,327, 354, 357, 369, 371];
a_data.cue1(:,:,a_data.indices_c1) = [];
a_data.cue2(:,:,a_data.indices_c2) = [];
a_data.cue3(:,:,a_data.indices_c3) = [];

%% Bandpass and filtering 
%THETA (4-7Hz)
%ALPHA (8-13Hz)
%BETA  (14-30Hz)

%time analysis filtered accoridng to different band and squared
%Cue 1
a_c1data.tsquared_c1data.alpha = squaredData(5, 8, 13,a_data.cue1);
a_c1data.tsquared_c1data.beta = squaredData(5, 14, 30,a_data.cue1);
a_c1data.tsquared_c1data.theta = squaredData(5, 4, 7,a_data.cue1);

%Cue 2
a_c2data.tsquared_c2data.alpha = squaredData(5, 7, 13,a_data.cue2);
a_c2data.tsquared_c2data.beta = squaredData(5, 14, 30,a_data.cue2);
a_c2data.tsquared_c2data.theta = squaredData(5, 4, 7,a_data.cue2);

%Cue 3
a_c3data.tsquared_c3data.alpha = squaredData(5, 8, 14,a_data.cue3);
a_c3data.tsquared_c3data.beta = squaredData(5, 14, 30,a_data.cue3);
a_c3data.tsquared_c3data.theta = squaredData(5, 4, 7,a_data.cue3);

%for all cues from range (0.5-30Hz)
a_c1data.tsquared_c1data.full = squaredData(5, 0.5, 30,a_data.cue1);
a_c2data.tsquared_c2data.full = squaredData(5, 0.5, 30,a_data.cue2);
a_c3data.tsquared_c3data.full = squaredData(5, 0.5, 30,a_data.cue3);


%frequency analysis filtered and squared

a_c1data.fsquared_c1data.full = squaredData(5,0.5,100,a_data.cue1);
a_c1data.fsquared_c1data.scaled = squaredData(5,3,30,a_data.cue1);

a_c2data.fsquared_c2data.full = squaredData(5,0.5,100,a_data.cue2);
a_c2data.fsquared_c2data.scaled = squaredData(5,3,30,a_data.cue2);

a_c3data.fsquared_c3data.full = squaredData(5,0.5,100,a_data.cue3);
a_c3data.fsquared_c3data.scaled = squaredData(5,3,30,a_data.cue3);


%% average over trials 

% for time analysis 


a_c1data.taverage_c1data.alpha = average_overtrials(a_c1data.tsquared_c1data.alpha, 3);
a_c1data.taverage_c1data.beta = average_overtrials(a_c1data.tsquared_c1data.beta, 3);
a_c1data.taverage_c1data.theta = average_overtrials(a_c1data.tsquared_c1data.theta, 3);

a_c2data.taverage_c2data.alpha = average_overtrials(a_c2data.tsquared_c2data.alpha, 3);
a_c2data.taverage_c2data.beta = average_overtrials(a_c2data.tsquared_c2data.beta, 3);
a_c2data.taverage_c2data.theta = average_overtrials(a_c2data.tsquared_c2data.theta, 3);

a_c3data.taverage_c3data.alpha = average_overtrials(a_c3data.tsquared_c3data.alpha, 3);
a_c3data.taverage_c3data.beta = average_overtrials(a_c3data.tsquared_c3data.beta, 3);
a_c3data.taverage_c3data.theta = average_overtrials(a_c3data.tsquared_c3data.theta, 3);

a_c1data.taverage_c1data.scaled = average_overtrials(a_c1data.tsquared_c1data.full,3);
a_c2data.tsquared_c2data.scaled = average_overtrials(a_c2data.tsquared_c2data.full,3);
a_c3data.tsquared_c3data.scaled = average_overtrials(a_c1data.tsquared_c1data.full,3);



% average for frequency analysis 
a_c1data.faverage_c1data.full = average_overtrials(a_c1data.fsquared_c1data.full, 3);
a_c1data.faverage_c1data.scaled = average_overtrials(a_c1data.fsquared_c1data.scaled, 3);

a_c2data.faverage_c2data.full = average_overtrials(a_c2data.fsquared_c2data.full, 3);
a_c2data.faverage_c2data.scaled = average_overtrials(a_c2data.fsquared_c2data.scaled, 3);

a_c3data.faverage_c3data.full = average_overtrials(a_c3data.fsquared_c3data.full, 3);
a_c3data.faverage_c3data.scaled = average_overtrials(a_c3data.fsquared_c3data.scaled, 3);


%% baseline extraction 

[a_data.baseline.One.cue1,a_data.baseline.One.cue2,a_data.baseline.One.cue3] = extractBaseline(vbot_1,eeg_1);
[a_data.baseline.Two.cue1,a_data.baseline.Two.cue2,a_data.baseline.Two.cue3] = extractBaseline(vbot_2,eeg_2);
[a_data.baseline.Three.cue1,a_data.baseline.Three.cue2,a_data.baseline.Three.cue3] = extractBaseline(vbot_3,eeg_3);
[a_data.baseline.Four.cue1,a_data.baseline.Four.cue2,a_data.baseline.Four.cue3] = extractBaseline(vbot_4,eeg_4);
[a_data.baseline.Five.cue1,a_data.baseline.Five.cue2,a_data.baseline.Five.cue3] = extractBaseline(vbot_5,eeg_5);


a_data.finalbaseline.cue1 = concatenateBaseline(a_data.baseline.One.cue1,a_data.baseline.Two.cue1,a_data.baseline.Three.cue1,a_data.baseline.Four.cue1, a_data.baseline.Five.cue1, a_data.indices_c1);
a_data.finalbaseline.cue2= concatenateBaseline(a_data.baseline.One.cue2,a_data.baseline.Two.cue2,a_data.baseline.Three.cue2,a_data.baseline.Four.cue2, a_data.baseline.Five.cue2, a_data.indices_c2);
a_data.finalbaseline.cue3 = concatenateBaseline(a_data.baseline.One.cue3,a_data.baseline.Two.cue3,a_data.baseline.Three.cue3,a_data.baseline.Four.cue3, a_data.baseline.Five.cue3, a_data.indices_c3);




%% WINDOW FOR TIME ANALYSIS 
% ERD/ERS using common baseline 
% one baseline value averaged over trials for all channels 


% for averaged data 
a_c1data.window_c1data.alpha = windowingaveraged(a_c1data.taverage_c1data.alpha,1, 256,a_data.finalbaseline.cue1);
a_c1data.window_c1data.beta = windowingaveraged(a_c1data.taverage_c1data.beta,1, 256,a_data.finalbaseline.cue1);
a_c1data.window_c1data.theta = windowingaveraged(a_c1data.taverage_c1data.theta,1, 256,a_data.finalbaseline.cue1);

a_c2data.window_c2data.alpha = windowingaveraged(a_c2data.taverage_c2data.alpha,1, 256,a_data.finalbaseline.cue2);
a_c2data.window_c2data.beta = windowingaveraged(a_c2data.taverage_c2data.beta,1, 256,a_data.finalbaseline.cue2);
a_c2data.window_c2data.theta = windowingaveraged(a_c2data.taverage_c2data.theta,1, 256,a_data.finalbaseline.cue2);

a_c3data.window_c3data.alpha = windowingaveraged(a_c3data.taverage_c3data.alpha,1, 256,a_data.finalbaseline.cue3);
a_c3data.window_c3data.beta = windowingaveraged(a_c3data.taverage_c3data.beta,1, 256,a_data.finalbaseline.cue3);
a_c3data.window_c3data.theta = windowingaveraged(a_c3data.taverage_c3data.theta,1, 256,a_data.finalbaseline.cue3);

a_c1data.window_c1data.scaled = windowingaveraged(a_c1data.taverage_c1data.scaled,1, 256,a_data.finalbaseline.cue1);
a_c2data.window_c2data.scaled = windowingaveraged(a_c1data.taverage_c1data.scaled,1, 256,a_data.finalbaseline.cue2);
a_c3data.window_c3data.scaled = windowingaveraged(a_c1data.taverage_c1data.scaled,1, 256,a_data.finalbaseline.cue3);
%}

%% WINDOW FOR FREQUENCY ANALYSIS 

%for all trials 

a_c1data.frequencyanalysisc1.full = frequencyanalysis(a_c1data.fsquared_c1data.full ,1 ,256);
a_c1data.frequencyanalysisc1.scaled = frequencyanalysis(a_c1data.fsquared_c1data.scaled ,1 ,256);

a_c2data.frequencyanalysisc2.full = frequencyanalysis(a_c2data.fsquared_c2data.full ,1 ,256);
a_c2data.frequencyanalysisc2.scaled = frequencyanalysis(a_c2data.fsquared_c2data.scaled ,1 ,256);

a_c3data.frequencyanalysisc3.full = frequencyanalysis(a_c3data.fsquared_c3data.full ,1 ,256);
a_c3data.frequencyanalysisc3.scaled = frequencyanalysis(a_c3data.fsquared_c3data.scaled ,1 ,256);



%for averaged data
a_c1data.frequencyanalysisc1.full = frequencyAnalysis(a_c1data.faverage_c1data.full ,1 ,256);
a_c1data.frequencyanalysisc1.scaled = frequencyAnalysis(a_c1data.faverage_c1data.scaled ,1 ,256);

a_c2data.frequencyanalysisc2.full = frequencyAnalysis(a_c2data.faverage_c2data.full ,1 ,256);
a_c2data.frequencyanalysisc2.scaled = frequencyAnalysis(a_c2data.faverage_c2data.scaled ,1 ,256);

a_c3data.frequencyanalysisc3.full = frequencyAnalysis(a_c3data.faverage_c3data.full ,1 ,256);
a_c3data.frequencyanalysisc3.scaled = frequencyAnalysis(a_c3data.faverage_c3data.scaled ,1 ,256);


%% CORRELATION

%One versus one cue (OVO)

correlation_data.cue12_full = correlationanalysis(a_c1data.fsquared_c1data.full, a_c2data.fsquared_c2data.full, 724, 1500);
correlation_data.cue23_full = correlationanalysis(a_c2data.fsquared_c2data.full, a_c3data.fsquared_c3data.full, 724, 1500);
correlation_data.cue13_full = correlationanalysis(a_c1data.fsquared_c1data.full, a_c3data.fsquared_c3data.full, 724, 1500);

%one versus all cue (OVA)

correlation_data.cue123_full = correlationanalysis3(a_c1data.fsquared_c1data.full, a_c2data.fsquared_c2data.full,a_c3data.fsquared_c3data.full, 724, 1500);
correlation_data.cue231_full = correlationanalysis3(a_c2data.fsquared_c2data.full, a_c3data.fsquared_c3data.full,a_c1data.fsquared_c1data.full, 724, 1500);
correlation_data.cue132_full = correlationanalysis3(a_c1data.fsquared_c1data.full, a_c3data.fsquared_c3data.full,a_c1data.fsquared_c1data.full, 724, 1500);


%% COMMON SPATIAL PATTERN 

% for one versus one cue (OVO)
% for two cues

% CSP
[CSP.data12.finaldata1,CSP.data12.finaldata2] = CSP_data2(a_c1data.tsquared_c1data.full, a_c2data.tsquared_c2data.full);
[CSP.data13.finaldata1,CSP.data13.finaldata3] = CSP_data2(a_c1data.tsquared_c1data.full, a_c3data.tsquared_c3data.full);
[CSP.data23.finaldata2,CSP.data23.finaldata3] = CSP_data2(a_c2data.tsquared_c2data.full, a_c3data.tsquared_c3data.full);

% CLASSIFICATION :LDA

CSP.data12.lda.data = csp_LDA(CSP.data12.finaldata1,CSP.data12.finaldata2);
CSP.data13.lda.data = csp_LDA(CSP.data13.finaldata1,CSP.data13.finaldata3);
CSP.data23.lda.data = csp_LDA(CSP.data23.finaldata2,CSP.data23.finaldata3);

%CLASSIFICATION: SVM

CSP.data12.svm.data = csp_SVM(CSP.data12.finaldata1,CSP.data12.finaldata2);
CSP.data13.svm.data = csp_SVM(CSP.data13.finaldata1,CSP.data13.finaldata3);
CSP.data23.svm.data = csp_SVM(CSP.data23.finaldata2,CSP.data23.finaldata3);

%CROSS VALIDATION : K FOLD = 10, 30
[CSP.data12.lda.mean10, CSP.data12.lda.std10]= cross_val(CSP.data12.lda.data,10);
[CSP.data12.lda.mean30, CSP.data12.lda.std30]= cross_val(CSP.data12.lda.data,30);

[CSP.data13.lda.mean10, CSP.data13.lda.std10]= cross_val(CSP.data13.lda.data,10);
[CSP.data13.lda.mean30, CSP.data13.lda.std30]= cross_val(CSP.data13.lda.data,30);

[CSP.data23.lda.mean10, CSP.data23.lda.std10]= cross_val(CSP.data23.lda.data,10);
[CSP.data23.lda.mean30, CSP.data23.lda.std30]= cross_val(CSP.data23.lda.data,30);

[CSP.data12.svm.mean10, CSP.data12.svm.std10]= cross_val(CSP.data12.svm.data,10);
[CSP.data12.svm.mean30, CSP.data12.svm.std30]= cross_val(CSP.data12.svm.data,30);

[CSP.data13.svm.mean10, CSP.data13.svm.std10]= cross_val(CSP.data13.svm.data,10);
[CSP.data13.svm.mean30, CSP.data13.svm.std30]= cross_val(CSP.data13.svm.data,30);

[CSP.data23.svm.mean10, CSP.data23.svm.std10]= cross_val(CSP.data23.svm.data,10);
[CSP.data23.svm.mean30, CSP.data23.svm.std30]= cross_val(CSP.data23.svm.data,30);


% for one versus all (OVA)
% for three cues

%CSP 
[CSP.data123.finaldata12,CSP.data123.finaldata3] = CSP_data3(a_c1data.tsquared_c1data.full, a_c2data.tsquared_c2data.full,a_c3data.tsquared_c3data.full);
[CSP.data132.finaldata13,CSP.data132.finaldata2] = CSP_data3(a_c1data.tsquared_c1data.full, a_c3data.tsquared_c3data.full,a_c2data.tsquared_c2data.full);
[CSP.data231.finaldata23,CSP.data231.finaldata1] = CSP_data3(a_c2data.tsquared_c2data.full, a_c3data.tsquared_c3data.full,a_c1data.tsquared_c1data.full);

%CLASSIFICATION : LDA
CSP.data123.lda.data = csp_LDA(CSP.data123.finaldata12,CSP.data123.finaldata3);
CSP.data132.lda.data = csp_LDA(CSP.data132.finaldata13,CSP.data132.finaldata2);
CSP.data231.lda.data = csp_LDA(CSP.data231.finaldata23,CSP.data231.finaldata1);

% CLASSIFICATION: SVM
CSP.data123.svm.data = csp_SVM(CSP.data123.finaldata12,CSP.data123.finaldata3);
CSP.data132.svm.data = csp_SVM(CSP.data132.finaldata13,CSP.data132.finaldata2);
CSP.data231.svm.data = csp_SVM(CSP.data231.finaldata23,CSP.data231.finaldata1);

%CROSS VALIDATION FOR K = 10,30

[CSP.data123.lda.mean10, CSP.data123.lda.std10]= cross_val(CSP.data123.lda.data,10);
[CSP.data123.lda.mean30, CSP.data123.lda.std30]= cross_val(CSP.data123.lda.data,30);

[CSP.data132.lda.mean10, CSP.data132.lda.std10]= cross_val(CSP.data132.lda.data,10);
[CSP.data132.lda.mean30, CSP.data132.lda.std30]= cross_val(CSP.data132.lda.data,30);

[CSP.data231.lda.mean10, CSP.data231.lda.std10]= cross_val(CSP.data231.lda.data,10);
[CSP.data231.lda.mean30, CSP.data231.lda.std30]= cross_val(CSP.data231.lda.data,30);

[CSP.data123.svm.mean10, CSP.data123.svm.std10]= cross_val(CSP.data123.svm.data,10);
[CSP.data123.svm.mean30, CSP.data123.svm.std30]= cross_val(CSP.data123.svm.data,30);

[CSP.data132.svm.mean10, CSP.data132.svm.std10]= cross_val(CSP.data132.svm.data,10);
[CSP.data132.svm.mean30, CSP.data132.svm.std30]= cross_val(CSP.data132.svm.data,30);

[CSP.data231.svm.mean10, CSP.data231.svm.std10]= cross_val(CSP.data231.svm.data,10);
[CSP.data231.svm.mean30, CSP.data231.svm.std30]= cross_val(CSP.data231.svm.data,30);






%% STEP 1: DATA PREPARE 
%extracting eeg data for 2.5 seconds before the movement start and 2.5 seconds
%after movement start 
%%--------------|---------------|
% 2.5 sec   movement    2.5sec
%storing only that eeg data which has 2500 signals and creating structure 

function [eeg_sequence] = getEegSequence(data, startTime, endTime)
    rows = data.Var1 >= startTime & data.Var1 < endTime;
    eeg_sequence = data(rows,2:9);
end

function[data] = dataPrepare(vbot_file,eeg_file)
vbot = DATAFILE_Read1(vbot_file);
eeg = readtable(eeg_file);
m_O = vbot.TimeLog_MovementStart;
movement_start = int32(m_O*1000);
before_movement = movement_start-(2500); % before movement start 
after_movement = movement_start+(2500); %after movement start 

i=1;
while(i<=length(vbot.Trials))
    
    array = getEegSequence(eeg, before_movement(i), after_movement(i));
    if(height(array)==2500) % only if the data length is 2500 signals 
    data_trials(i).data = array;
    end
    i=i+1;
end

    

%data = zeros(2500,8);

for k=1:length(data_trials)
        data.data(:,:,k) = data_trials(k).data{:,:};
end
end

% concatenating files
function[C1,C2,C3,C4] = concatenate(data1,data2)
A1 = data1.data;
A2 = data1.cue1;
A3 = data1.cue2;
A4 = data1.cue3;

B1 = data2.data;
B2 = data2.cue1;
B3 = data2.cue2;
B4 = data2.cue3;

C1 = cat(3,A1,B1);
C2 = cat(3,A2,B2);
C3 = cat(3,A3,B3);
C4 = cat(3,A4,B4);

end

%% STEP 2: cue combined data 
% extracting time index according to cue information 
% Cue 1 = one possibilty for target 
% Cue 2 = two possibiltiy for target
% Cue 3 = four possibilty for target

function [cue1_data,cue2_data,cue3_data] = seperateClasses(vbot_file,data)
vbot = DATAFILE_Read1(vbot_file);
length1 = length(data(1,1,:));
%clubbing data with labels (cue number i.e 1, 2, 3)
labels=vbot.CueNumber;
labels = labels(1:length1);
% Creating index list of all trial containing specified cue number
c1=find(labels ==1);
c2=find(labels==2);
c3=find(labels ==3);
% for channel 1

cue1_data = data(:,:,c1); 
cue2_data = data(:,:,c2);
cue3_data = data(:,:,c3);
end

%% STEP 3: bandpass, filtering and squaring data with 500HZ sampling frequency rate % Asmita
%i.e. dividing limits by sampling frequency rate /2 using butterworth for
%bandpass and filtfilt for filtering 

function [squared_data] = squaredData(order, lowerLimit, upperLimit,data)
    [b,a] = butter(order,[lowerLimit/250,upperLimit/250], 'bandpass');  
    filtered_data = filtfilt(b,a,data);
    squared_data = filtered_data.^2;
end


%% STEP 4: averaging over trials % Asmita
function [average_data] = average_overtrials(data, dim)
average_data = mean(data,dim);
end 

%% STEP 5: baseline extraction for separate cues

function [b1,b2,b3] = extractBaseline(vbot_file,eeg_file)
vbot = DATAFILE_Read1(vbot_file);
eeg = readtable(eeg_file);
m_O = vbot.TimeLog_MovementStart;
time_Index = int32(m_O*1000);
base_StartTime = time_Index - 2500; 

for i = 1:length(vbot.Trials)
    baseline(i).base = getEegSequence(eeg, base_StartTime(i), time_Index(i));
    
end

base_sequence = zeros(1250,8);

for k=1:length(vbot.Trials)
        base_sequence(:,:,k) = baseline(k).base{:,:};
end

%baseline_average = mean(base_sequence,1);

baseline_data = base_sequence.^2;

[b1,b2,b3] = seperateClasses(vbot_file,baseline_data);

end

function[cat_baseline] = concatenateBaseline(data1,data2,data3, data4, data5, indices)
baseline_final = cat(3,data1,data2);
baseline_final = cat(3,data3,baseline_final);
baseline_final = cat(3,data4,baseline_final);
baseline_final = cat(3,data5,baseline_final);

baseline_final(:,:, indices) = [];
cat_baseline = mean(baseline_final,3);
end

%% STEP 6: TIME ANALYSIS for averaged data % Nehchal  
% calculating moving windowing data for averaged data over trials  
% output = [channels,windows]
% ERD/ERS = data(one window).^2 - baseline.^2/baseline*.^2100;

function [timeSeries_final] = windowingaveraged(data,timestep, windowSize,baseline_data) 
    %iterating over one channel at a time
     
        windowStart = 1;
        windowEnd = windowSize;
        h = 1;       
      
        
        
             while(windowEnd<=length(data)) 
                
                windoweddata(h, :) = mean(data(windowStart:windowEnd,:));  
               % D =  windoweddata(h, :) = mean(data(1:256,:)); 
                timeSeries_final(h,:) = windoweddata(h,:).^2-baseline_data(1,:).^2/baseline_data(1,:).^2*100;
                windowStart = windowStart + timestep;
                windowEnd = windowEnd + timestep; 
                h = h+1;
            
        end

end


%% TIME ANALYSIS FOR EVERY TRAIL

%{
function [timeSeries_final] = windowingaveraged(data,timestep, windowSize)
    % iterating over one channel at a time
     
        windowStart = 1;
        windowEnd = windowSize;
        h = 1;       
        D = zeros(1,8,length(data(1,1,:)));
        
             while(windowEnd<=length(data)) 
                D = mean(data(1:256,:,:))
                windoweddata(h, :, :) = mean(data(windowStart:windowEnd,:,:))
                timeSeries_final(h,:,:) = windoweddata(h,:,:)-D(1,:)/D(1,:)*100;
                windowStart = windowStart + timestep;
                windowEnd = windowEnd + timestep; 
                h = h+1;
            
        end

end
%}
%% STEP 7 : FREQUENCY ANALYSIS %Asmita AND Nehchal
%for every trial 4DIMENSIONAL
% INPUT = [squareddata timestep windowsize]
% output [window/2, channels, trials, windows]
%{
function [fft_data] = frequencyanalysis(data,time_step,window_size)
window_start = 1;
window_end = window_size;
fft_data = zeros(window_size/2,8,length(data(1,1,:)),(length(data(:,1,1)) - 250)/2);
h=1;
while(window_end <= length(data(:,1,:)))
        window = data(window_start:window_end,:,:);
        w = hamming(window_size);
        windowed = window.*w;
        fftw = fft(windowed);
        fftwd = fftw(1:(length(fftw(:,1,1)))/2,:,:);
        magnitude = 20*log10(abs(fftwd));
        fft_data(:,:,:,h) = magnitude;
        window_start = window_start+time_step;
        window_end = window_end+time_step;
        h=h+1;
end

end

%}

% FOR AVERAGED DATA 
%INPUT = [averagedpowereddata timestep windowsize]
%OUTPUT = 3 dimensional array 
% [windowsize/2 channels windows]

function [fft_data] = frequencyAnalysis(data,time_step,window_size)
    window_start = 1;
    window_end = window_size;
    %initializing array 
    fft_data = zeros(window_size/2,8,(length(data(:,1)) - window_size)/2);
    h=1;
    
        % iterating until window_end ~= no fo signal 
        while(window_end <= length(data(:,1))) 
            % 1. taking out signal 
            %data for all channels for one window
             window1 = data(window_start:window_end,:); 
             
             % 2. hamming window
             w = hamming(window_size);
             windowed = window1.*w;
            
             % 3. fft
             fftw = fft(windowed);
             
             %4. magnitude 
             %dividing it into half
             fftwd = fftw(1:(length(fftw))/2,:);
             magnitude = 20*log10(abs(fftwd));
             
             % returning 3 dim array 
             fft_data(:,:,h) = magnitude;
             
             window_start = window_start+time_step;
             window_end = window_end+time_step;
             h=h+1;
        end
        
end


%% STEP 8 : CORRELATION 

%CORRELATION FOR TWO CUES
function[correlation_data] = correlationanalysis(data1, data2, timestart, timeend)
 %This function calculates correlation for one versus one (OVO) approach by
% Input = filtered data 1, data 2
% selected time window start and end 
% Output = correlation
 
% periodograms 
c_data1 = fft_data1(data1,timestart,timeend);
c_data2 = fft_data1(data2, timestart, timeend);

c_data = cat(3, c_data1, c_data2);
c_fdata = permute (c_data, [3,2,1]);

labelvector1 = zeros(length(c_data1(1,1,:)) , 1);
labelvector2 = ones((length(c_data2(1,1,:))), 1);
labelvector = cat(1, labelvector1, labelvector2);
 
for i = 1:8
    correlation_data(:,i) = corr(labelvector(:,1),squeeze(c_fdata(:,i,:))).^2;
end

correlation_data = permute (correlation_data, [2 1]);

end


% CORRELATION FOR 3 CUES
% DATA 1 & DATA 2 ARE COMBINED AND CORRELATED WITH DATA3
function[correlation_data] = correlationanalysis3(data1, data2, data3, timestart, timeend)
% This function calculates correlation for one versus all (OVA) approach by
% combining DATA1 AND DATA2 together treating them as one class 
% DATA3 as class against DATA1 + DATA2
% Input = filtered data 1, data 2, data 3
% selected time window start and end 
% Output = correlation 
% periodograms 
c_data1 = fft_data1(data1,timestart,timeend);
c_data2 = fft_data1(data2, timestart, timeend);
c_data3 = fft_data1(data3, timestart, timeend);

c_data = cat(3, c_data1, c_data2, c_data3);
c_fdata = permute (c_data, [3,2,1]);

labelvector1 = zeros(length(c_data1(1,1,:))+ length(c_data2(1,1,:)) , 1);
labelvector2 = ones((length(c_data3(1,1,:))), 1);
labelvector = cat(1, labelvector1, labelvector2);
 
for i = 1:8
    correlation_data(:,i) = corr(labelvector(:,1),squeeze(c_fdata(:,i,:))).^2;
end
correlation_data = permute(correlation_data, [2 1]);
end


% PERIODOGRAM FOR CORRELATION
function [fft_d] = fft_data1(data1, timestart, timeend)
fft_d1 = data1(timestart:timeend, :, :); %taking out the periodogram from timestart to timened where the desynchronization is visible in the data 
%creating a hamming window for the data
w = hamming(length(fft_d1(:,1,1)));
%mutliplying the hamming window with the data
fft11 = fft_d1.*w;
fft1 = fft(fft11);
fftwd1 = fft1(1:(length(fft1(:,1,1)))/2,:,:);
%taking magnitude of fft
magnitude = 20*log10(abs(fftwd1));

%taking out the ratio of signals in every 1 frequency and then fitting the
%data into 250 nyquist frequency by dividing it frequency calculated 
frequency = length(magnitude(:,1,1))/250;
fft_d = magnitude(:,:,:)./frequency;

end


%% STEP 9 : FEATURE VECTORS IN SEPARATE FILE

%% STEP 10 : COMMON SPATIAL PATTERN  
 
%for two cues

function [csp_data1, csp_data2] = CSP_data2(data1, data2)
 
%Input data:3 dimensional filtered and squared data of the form
% Input = [samples channels trials]
% Output = projected matrix [2*trial no]
 
%Making covaraince matrix for each data set
cov1 = covarianceMatrix(data1);
cov2 = covarianceMatrix(data2);

%average over trials 
covMean_data1 = squeeze(mean(cov1,3));
covMean_data2 = squeeze(mean(cov2,3));

% calculate Eigenvectors (EG), Eigenvalues(EV)
[EG,EV] = eig(covMean_data1,covMean_data2 );

% Sort them either in ascending or descending order
[~,ind] = sort(diag(EV),'descend');
 EG = EG(:,ind);
 
% taking 1st and last column of eigenvectors with min and max variance
spatial_Filters = EG(:, [1 8]);

csp_finaldata1 = zeros(2,1);
csp_finaldata2 = zeros(2,1);

% project the matrix on the spatial filters 
i = 1;
while(i~=size(cov1,3))
    X1 =  spatial_Filters'*data1(:,:,i)';
    Y1 = log(var(X1',1));
    csp_finaldata1(:,:,i)= Y1;
    i = i+1;
end
j = 1;
while(j~=size(cov2,3))
    X2 =  spatial_Filters'*data2(:,:,j)';
    Y2 = log(var(X2',1))
    csp_finaldata2(:,:,j)= Y2;
    j=j+1;
end

% output
csp_data1 = squeeze(csp_finaldata1);
csp_data2= squeeze(csp_finaldata2);
 

end

% FOR 3 CUES 

function [csp_data1, csp_data2] = CSP_data3(data1, data2, data3)
% CSP function for 3 classes for One versus all approach
% data 1 and data 2 are combined together and treated as one class
% data3 is treated as class against data 1 and data 2 for classification 

data1 = cat(3,data1,data2);

% covariance matrices 
cov1 = covarianceMatrix(data1);
cov2 = covarianceMatrix(data3);

% average over trials 
covMean_data1 = squeeze(mean(cov1,3));
covMean_data2 = squeeze(mean(cov2,3));

% EG = Eigenvectors , EV = eigenvalues
[EG,EV] = eig(covMean_data1,covMean_data2 );

% Sort them in descending or ascending order 
[~,ind] = sort(diag(EV),'descend');
 EG = EG(:,ind);

%Spatial filter with 1st and last column
%highest and lowest variance 
spatial_Filters = EG(:, [1 8]);

csp_finaldata1 = zeros(2,1);
csp_finaldata2 = zeros(2,1);

% project the matrix on the spatial filters 
i = 1;
while(i~=size(cov1,3))
    X1 =  spatial_Filters'*data1(:,:,i)';
    Y1 = log(var(X1',1));
    csp_finaldata1(:,:,i)= Y1;
    i = i+1;
end
j = 1;
while(j~=size(cov2,3))
    X2 =  spatial_Filters'*data3(:,:,j)';
    Y2 = log(var(X2',1))
    csp_finaldata2(:,:,j)= Y2;
    j=j+1;
end

csp_data1 = squeeze(csp_finaldata1);
csp_data2= squeeze(csp_finaldata2);
 

end

function [final_data] = covarianceMatrix(data1)
% calculation of covraiance per trial 
i = 1;
while(i~=length(data1(1,1,:)))
    E = data1(:,:,i);
    final_data(:,:,i) = cov(E)./trace(E'*E); 
    i=i+1;
end
end 

% CLASSIFICATION ALGORITHM 

function [classification_data] = csp_LDA(data1,data2)
% classification using LDA for CSP data 
% INPUT = TWO SETS OF DATA TO BE CLASSIFIED in the form [:,Trial]
% OUTPUT = trained model for LDA classification 

C = cat(2,data1,data2);
C = permute(C, [2 1])

labelvector1 =  zeros(length(data1(1,:)),1);
labelvector2 =  ones(length(data2(1,:)),1);
labelvector = cat(1,labelvector1, labelvector2);
classification_data = fitcdiscr(C, labelvector, 'DiscrimType' , 'pseudoquadratic' );

end

function [classification_data] = csp_SVM(data1,data2)
%classification using SVM for CSP data 
% INPUT = TWO SETS OF DATA TO BE CLASSIFIED in the form [:,Trial]
% OUTPUT = trained model for SVM classification 

C = cat(2,data1,data2);
C = permute(C, [2 1])

labelvector1 =  zeros(length(data1(1,:)),1);
labelvector2 =  ones(length(data2(1,:)),1);
labelvector = cat(1,labelvector1, labelvector2);

classification_data = fitcsvm(C, labelvector);

end

% CROSS VALIDATION OF TRAINED MODEL 
function [K_mean, Std_data] = cross_val(model,fold)
% calculation of Cross validation
% INPUT = trained model , no of folds for cross valdation
% Output = mean, standard deviation of the accuracy

cross = crossval(model, 'kfold', fold);
K = kfoldLoss(cross,'Mode','individual');

% Accuracy = 1 - K;
K = 1-K;

K_mean = mean(K)*100;
Std_data = std(K)*100;
end