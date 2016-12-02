%-------------------FFR120, Voting system, Main--------------------------%

load('binaryIndividuals.mat')
n =size(individuals,2);
percentRural = 40; 
% Timesteps
nTimeSteps = 4e1;  
plotInterval = 1e7;
% OpinionTransfer
transferEffect = .1;
ruralInteraction = .05;
% Parties
nParties = 2;
minDistance = .0005;
% Media
proportionAffected = .001;
mediaEffectScalar = 0;
nRural = floor(percentRural/100 * n);
partiesList = Parties(nParties, minDistance);
%-------------------------------------------------------------------------
nTrials = 10; 
individualMatrix = zeros(4,1000,nTrials);
countsMatrix = zeros(nTimeSteps,2,nTrials);
statMat = zeros(2,nTimeSteps,nTrials);
threshold = 0.2;

for iTrial =1:nTrials
[counts, statistics,finalIndividuals] = runMain(individuals,interactionMatrix,partiesList, proportionAffected,...
    mediaEffectScalar,transferEffect,threshold,ruralInteraction,nRural,nTimeSteps,plotInterval);
plot(1:(nTimeSteps),counts(:,1)/1000,'DisplayName',num2str(iTrial))
hold on 

countsMatrix(:,:,iTrial) = counts;
statMat(:,:,iTrial) = statistics; 
individualMatrix(:,:,iTrial) = finalIndividuals;
end