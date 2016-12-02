%-------------------FFR120, Voting system, Main--------------------------%

load('binaryIndividuals.mat')
n =size(individuals,2);
percentRural = 40; 
% Timesteps
nTimeSteps = 10;  
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

for iTrial =1:nTrials
[counts, individuals] = runMain(individuals,interactionMatrix,partiesList, proportionAffected,...
    mediaEffectScalar,transferEffect,ruralInteraction,nRural,nTimeSteps,plotInterval);
plot(1:(nTimeSteps+1),counts(:,1)/1000,'DisplayName',num2str(iTrial))
hold on 

individualMatrix(:,:,iTrial) = individuals;
end