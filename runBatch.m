%-------------------FFR120, Voting system, Main--------------------------%
tic
data = load('1Cities10Parties.mat');
individuals = data.individuals;
interactionMatrix = data.interactionMatrix;
n =size(individuals,2);
percentRural = 40;
% Timesteps
nTimeSteps = 1.5e6;
% OpinionTransfer
transferEffect = .1;
ruralInteraction = .05;
interactionThreshold = 0.1;
% Parties
nParties = 10;
minDistance = .5;
% Media
proportionAffected = .001;
mediaEffectScalarList = [0.163 0.164 0.165];
%mediaEffectScalarList = [0.163];
nRural = floor(percentRural/100 * n);
%partiesList = data.partiesList;
%nParties = length(partiesList);
partiesList = Parties(nParties, minDistance);
%-------------------------------------------------------------------------
nSweeps = length(mediaEffectScalarList);
% Plotting
sweepParameterName = '$M_{\mathrm{limit}}$';
sweepParameterFilePrefix = 'Me';
countInterval = 1000;
nTrials = 3;
textOpts = {'Interpreter','LaTex','FontSize',14};


nCounts = fix(nTimeSteps/countInterval);
individualMatrix = zeros(4,n,nTrials,nSweeps);
countsMatrix = zeros(nCounts,nParties,nTrials,nSweeps);
statMat = zeros(2,nCounts,nTrials,nSweeps);
confidenceThreshold = 0.2;
t = linspace(1, nTimeSteps, nCounts);
convergenceThreshold = 0.646;
tConvergenceList = zeros(nTrials,nSweeps);


for iSweep = 1:nSweeps
    mediaEffectScalar = mediaEffectScalarList(iSweep)
    
    % plotting
    figure(iSweep);
    for iTrial =1:nTrials
        [counts, statistics,finalIndividuals] = RunOne(individuals,interactionMatrix,partiesList, proportionAffected,...
            mediaEffectScalar,transferEffect,confidenceThreshold,interactionThreshold,ruralInteraction,nRural,nTimeSteps,countInterval);
        % plotting
        [~ , winnerId] = max(counts(end,:));
        winnerFraction = counts(:,winnerId)/1000;
        tConvergenceIndex = find(winnerFraction>convergenceThreshold,1,'first');
        tConvergenceList(iTrial,iSweep) = t(tConvergenceIndex);%(tConvergenceIndex-1)*countInterval + 1;
        plot(t,winnerFraction,'DisplayName',num2str(iTrial))
        hold on
        plot(tConvergenceList(iTrial,iSweep),winnerFraction(tConvergenceIndex),'*')
        
        countsMatrix(:,:,iTrial,iSweep) = counts;
        statMat(:,:,iTrial,iSweep) = statistics;
        individualMatrix(:,:,iTrial,iSweep) = finalIndividuals;
    end
    
    % plotting
    hold off
    axis([1 nTimeSteps 0 1])
    xlabel('Time',textOpts{:});
    ylabel('Fraction of support',textOpts{:});
    title([sweepParameterName ' = ' num2str(mediaEffectScalar)], textOpts{:})
end
toc

% save pdf and fig
PrintFigures(sweepParameterFilePrefix, mediaEffectScalarList)
% dump data
DATE_FORMAT = 'yy-mm-dd_HH.MM.SS';
dumpFileName = ['all_data_' datestr(datetime(),DATE_FORMAT) '.mat'];
save(dumpFileName)