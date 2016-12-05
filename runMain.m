function [counts,statistics,individuals] = runMain(individuals,interactionMatrix,partiesList, proportionAffected,mediaEffectScalar,transferEffect,confidenceThreshold,interactionThreshold,ruralInteraction,nRural,nTimeSteps,plotInterval)

% [figHandle, plotHandle] = InitPlot(individuals, partiesList, nTimeSteps);
time = 1;
counts =zeros(nTimeSteps,length(partiesList));
statistics = zeros(2,nTimeSteps);

counts(time,:) = CountVotes(individuals, partiesList);
statistics(:,time) = CalcStatistics(individuals);

    while( time < (nTimeSteps))

        time = time + 1;

        [ selectedIndex1, selectedIndex2 ] = Selection(interactionMatrix, nRural, ruralInteraction);
        while(abs(individuals(3,selectedIndex1)-individuals(3,selectedIndex2))>interactionThreshold)
            [ selectedIndex1, selectedIndex2 ] = Selection(interactionMatrix, nRural, ruralInteraction);
        end
        individual1 = individuals(:,selectedIndex1);
        individual2 =  individuals(:,selectedIndex2);

        [ newOpinion1, newOpinion2, newCertainty1, newCertainty2 ] = OpinionTransfer2( individual1, individual2, transferEffect,confidenceThreshold );
        individuals(3,selectedIndex1)= newOpinion1;
        individuals(3,selectedIndex2)= newOpinion2;
        individuals(4,selectedIndex1)= newCertainty1;
        individuals(4,selectedIndex2)= newCertainty2;

        individuals = Media(individuals, proportionAffected, mediaEffectScalar);

%         if( mod(time, plotInterval) == 0)
%             UpdatePlot(individuals, partiesList, figHandle, plotHandle, time)
%         end
        
        counts(time,:) = CountVotes(individuals, partiesList);
       statistics(:,time) = CalcStatistics(individuals);
    end

end