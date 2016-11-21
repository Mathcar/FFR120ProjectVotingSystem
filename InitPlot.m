function [figHandle, plotHandle] = InitPlot(individuals, partiesList)
    nIndividuals = size(individuals, 2);
    nParties = length(partiesList);
    nHandles = 1 + nParties;
    
    
    figHandle = figure('units','normalized','position',[.1 .1 .8 .6]);
    
    plotHandle = gobjects(nHandles,1);
    
    subplot(121);
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
    
    
    subplot(122);
    axis([0 nParties+1 0 1]);
    axis square
    title('')
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
    
end