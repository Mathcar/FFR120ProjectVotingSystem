function [counts,statistics,individuals] = RunOne(individuals,interactionMatrix,partiesList, proportionAffected,mediaEffectScalar,transferEffect,threshold,ruralInteraction,nRural,nTimeSteps, countInterval)
    time = 1;
    nCounts = fix(nTimeSteps/countInterval);
    counts = zeros(nCounts,length(partiesList));
    statistics = zeros(2,nCounts);
    
    counts(time,:) = CountVotes(individuals, partiesList);
    statistics(:,time) = CalcStatistics(individuals);
    
    while( time < (nTimeSteps))
        
        time = time + 1;
        
        [ selectedIndex1, selectedIndex2 ] = Selection(interactionMatrix, nRural, ruralInteraction);
        individual1 = individuals(:,selectedIndex1);
        individual2 =  individuals(:,selectedIndex2);
        
        [ newOpinion1, newOpinion2, newCertainty1, newCertainty2 ] = OpinionTransfer2( individual1, individual2, transferEffect,threshold );
        individuals(3,selectedIndex1)= newOpinion1;
        individuals(3,selectedIndex2)= newOpinion2;
        individuals(4,selectedIndex1)= newCertainty1;
        individuals(4,selectedIndex2)= newCertainty2;
        
        individuals = Media(individuals, proportionAffected, mediaEffectScalar);
        
        if(mod(time, countInterval)==0)
            returnIndex = fix(time/countInterval);
            counts(returnIndex,:) = CountVotes(individuals, partiesList);
            statistics(:,returnIndex) = CalcStatistics(individuals);
        end
    end
    
end