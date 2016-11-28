function [figHandle, plotHandle] = InitPlot(individuals, partiesList, nTimeSteps)
    nIndividuals = size(individuals, 2);
    nParties = length(partiesList);
    nStatistics = 2;
    nHandles = 1 + nParties + nStatistics + nParties;
    figHandle = figure('units','normalized','position',[.1 .1 .8 .6]);
    plotHandle = gobjects(nHandles,1);
    
    %Map
    subplot(121)
    caxis([0 1])
    colorbar
    axis([0 1 0 1]);
    axis square
    title('')
    xlabel('x')
    ylabel('y')
    hold on
    plotHandle(1) = scatter(individuals(1, :), individuals(2, :), 20, individuals(4, :), 'filled');
    hold off
    
    %Popularity bars
    subplot(322)
    axis([0 nParties+1 0 1])
    title('')
    set(gca, 'XTick', 1:nParties)
    xlabel('Party')
    ylabel('Fraction of supporters')
    
    counts = CountVotes(individuals, partiesList);
    partyColors = CalcColors(partiesList);
    
    hold on
    for i=1:nParties
        plotHandle(i+1) = bar(i, counts(i)/nIndividuals);
        set(plotHandle(i+1), 'FaceColor', partyColors(i, :))
    end
    hold off
    
    %Statistics history
    subplot(324);
    axis([0 nTimeSteps 0 1]);
    title('')
    xlabel('Time')
    ylabel('')
    
    statistics = CalcStatistics(individuals);
    statisticsColors = {'b', 'r'};
    statisticsLabels = {'Mean', 'Variance'};
    
    for i = 1:nStatistics
        plotHandle(i+1+nParties) = animatedline('color', statisticsColors{i});
        addpoints(plotHandle(i+1+nParties), 0, statistics(i))
    end
    legend(statisticsLabels{:})
    
    %Popularity history
    subplot(326);
    axis([0 nTimeSteps 0 1]);
    title('')
    xlabel('Time')
    ylabel('Fraction of supporters')
    
    hold on
    for i=1:nParties
        plotHandle(i+1+nParties + nStatistics) = animatedline('color', partyColors(i, :));
        addpoints(plotHandle(i+1+nParties + nStatistics), 0, counts(i)/nIndividuals)
    end
    hold off
    
    drawnow
end