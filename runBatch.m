%-------------------FFR120, Voting system, Main--------------------------%
tic
load('binaryIndividuals.mat')
n =size(individuals,2);
percentRural = 40;
% Timesteps
nTimeSteps = 4e3;
% OpinionTransfer
transferEffect = .1;
ruralInteraction = .05;
interactionThreshold = 0.3;
% Parties
nParties = 2;
minDistance = .0005;
% Media
proportionAffected = .001;
mediaEffectScalarList = [0 0.3];
nRural = floor(percentRural/100 * n);
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
countsMatrix = zeros(nCounts,2,nTrials,nSweeps);
statMat = zeros(2,nCounts,nTrials,nSweeps);
confidenceThreshold = 0.2;
t = linspace(1, nTimeSteps, nCounts);


for iSweep = 1:nSweeps
    mediaEffectScalar = mediaEffectScalarList(iSweep);
    
    % plotting
    figure(iSweep);
    for iTrial =1:nTrials
        [counts, statistics,finalIndividuals] = RunOne(individuals,interactionMatrix,partiesList, proportionAffected,...
            mediaEffectScalar,transferEffect,confidenceThreshold,interactionThreshold,ruralInteraction,nRural,nTimeSteps,countInterval);
        % plotting
        plot(t,counts(:,1)/1000,'DisplayName',num2str(iTrial))
        hold on
        
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

% save pdf and fig
PrintFigures(sweepParameterFilePrefix, mediaEffectScalarList)
% dump data
DATE_FORMAT = 'yy-mm-dd_HH.MM.SS';
dumpFileName = ['all_data_' datestr(datetime(),DATE_FORMAT) '.mat'];
save(dumpFileName)