function UpdatePlot(individuals, partiesList, figHandle, plotHandle)
    nIndividuals = size(individuals, 2);
    nParties = length(partiesList);
    
    set(plotHandle(1), 'XData', individuals(1,:));
    set(plotHandle(1), 'YData', individuals(2,:));
    set(plotHandle(1), 'CData', individuals(4,:));
    
    counts = CountVotes(individuals, partiesList);
    
    for i=1:nParties
        set(plotHandle(1+i), 'YData',counts(i)/nIndividuals)
    end
    drawnow;
end