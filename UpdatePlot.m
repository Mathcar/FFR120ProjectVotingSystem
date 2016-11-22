function UpdatePlot(individuals, partiesList, figHandle, plotHandle, time)
    nIndividuals = size(individuals, 2);
    nParties = length(partiesList);
    nStatistics = 2;
    
    set(plotHandle(1), 'XData', individuals(1,:));
    set(plotHandle(1), 'YData', individuals(2,:));
    set(plotHandle(1), 'CData', individuals(4,:));
    
    counts = CountVotes(individuals, partiesList);
    
    for i=1:nParties
        set(plotHandle(1+i), 'YData',counts(i)/nIndividuals)
    end
    
    statistics = CalcStatistics(individuals);
    for i = 1:nStatistics
        addpoints(plotHandle(i+1+nParties), time, statistics(i))
    end
    
    
    for i=1:nParties
        addpoints(plotHandle(1+i+nParties+nStatistics), time ,counts(i)/nIndividuals)
    end
    
    drawnow
end