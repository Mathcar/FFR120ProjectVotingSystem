%-------------------FFR120, Voting system, Main--------------------------%
% This script loads some individuals from a file.
% Output of this script:
%   Plot of parties evolution over time
% Individuals
percentRural = 40;
n = 1e3;
nCities = 1;
citySize = .5;
nRural = floor(percentRural/100 * n);
% Timesteps
nTimeSteps = 1e7;
countInterval = ceil(nTimeSteps/10000);
notificationInterval = ceil(nTimeSteps/10);
tStartCounting = ceil(nTimeSteps/100);
victoryThreshold = 0.6;
% OpinionTransfer
transferEffect = .1;
ruralInteraction = .05;
threshold = .1;
% Parties
nParties = 10;
minDistance = .5;
% Media
proportionAffected = .001;
mediaEffectScalarList = linspace(0.1655,0.1665,10);%linspace(.164, .164, 1);
nRealizations = 5;

winnerIndex=zeros(nRealizations,length(mediaEffectScalarList));
tWin = zeros(nRealizations,length(mediaEffectScalarList));
tic
for k = 1:nRealizations
    [individualsInit ,interactionMatrixInit] = GenerateIndividuals(n, nCities, citySize, percentRural);
    partiesList = Parties(nParties, minDistance);
    
    for j = 1:length(mediaEffectScalarList)
        individuals = individualsInit;
        interactionMatrix = interactionMatrixInit;
        
        mediaEffectScalar = mediaEffectScalarList(j);
        fprintf('Current Media effect:%d\n',mediaEffectScalar)
        
        
        time = 0;
        noWinner = true;
        while( (time < nTimeSteps)&&(noWinner) )
            time = time + 1;
            
            [ selectedIndex1, selectedIndex2 ] = Selection(interactionMatrix, ...
                nRural, ruralInteraction);
            individual1 = individuals(:,selectedIndex1);
            individual2 =  individuals(:,selectedIndex2);
            
            [ newOpinion1, newOpinion2, newCertainty1, newCertainty2 ] =  ...
                OpinionTransfer2( individual1, individual2, transferEffect, threshold );
            individuals(3,selectedIndex1)= newOpinion1;
            individuals(3,selectedIndex2)= newOpinion2;
            individuals(4,selectedIndex1)= newCertainty1;
            individuals(4,selectedIndex2)= newCertainty2;
            
            individuals = Media(individuals, proportionAffected, mediaEffectScalar);
            
            if(mod(time,notificationInterval)==0)
                fprintf('%d/%d\n',time,nTimeSteps)
            end
            
            if((mod(time,countInterval)==0)&&(time>tStartCounting))
                counts = CountVotes(individuals, partiesList)/n;
                
                if(any(counts>victoryThreshold))
                    noWinner = false;
                    [~,winnerIndex(k,j)] = max(counts);
                    tWin(k,j)=time;
                end
            end
        end
        
    end
end
toc
%figure
%plot(mediaEffectScalarList,tWin,'o')
tWinMean = mean(tWin,1);
tWinSigma = std(tWin,1);
figure
errorbar(mediaEffectScalarList,tWinMean,tWinSigma)

textOpts = {'Interpreter','LaTex','FontSize',14};

xlabel('$M_{\mathrm{limit}}$',textOpts{:});
ylabel('Convergence Time',textOpts{:});
TITLE_FORMAT = '\\texttt{nCities} = %d, \\texttt{nParties} = %d, proportion affected by media: %1.0e';
title(sprintf(TITLE_FORMAT,nCities,nParties,proportionAffected),textOpts{:})

fig = gcf;
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
set(gca, 'LooseInset', get(gca, 'TightInset'));
set(gca,'TickLabelInterpreter','LaTeX','FontSize',12)


DATE_FORMAT = 'yy-mm-dd_HH.MM.SS';
dumpFileName = ['all_data_' datestr(datetime(),DATE_FORMAT) '.mat'];
save(dumpFileName)
print(['conv_' datestr(datetime(),DATE_FORMAT) '.pdf'], '-dpdf')
savefig(['conv_' datestr(datetime(),DATE_FORMAT) '.fig'])