function UpdatePlot(individuals, partiesList, figHandle, plotHandle, time)
    nIndividuals = size(individuals, 2);
    nParties = length(partiesList);
    nStatistics = 2;
    
    %Map
    set(plotHandle(1), 'XData', individuals(1,:));
    set(plotHandle(1), 'YData', individuals(2,:));
    set(plotHandle(1), 'CData', individuals(4,:));
    
    
    %Popularity bars
    counts = CountVotes(individuals, partiesList);
    for i=1:nParties
        set(plotHandle(1+i), 'YData',counts(i)/nIndividuals)
    end
    barAxis = get(plotHandle(1+1),'parent');
    set(barAxis,'XTick',1:nParties)
    
    %Statistics history
    statistics = CalcStatistics(individuals);
    for i = 1:nStatistics
        addpoints(plotHandle(i+1+nParties), time, statistics(i))
    end
    
    %Popularity history
    for i=1:nParties
        addpoints(plotHandle(1+i+nParties+nStatistics), time ,counts(i)/nIndividuals)
    end
    
    drawnow
end