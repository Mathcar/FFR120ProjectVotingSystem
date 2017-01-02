%-------------------FFR120, Voting system, Main--------------------------%
% This script loads some individuals from a file. 
% Output of this script:
%   Plot of parties evolution over time
% Individuals
percentRural = 40;
n = 1e3; 
nCitiesList = 1;
citySize = .5;
% Timesteps
nTimeSteps = 3e6;
plotInterval = 2.5e3;
% OpinionTransfer
transferEffect = .1;
ruralInteraction = .05;
threshold = .1;
% Parties
nPartiesList = [10];
minDistance = .5;
% Media
proportionAffected = .001;
mediaEffectScalarList = linspace(.164, .164, 1);

for k = 1:length(nCitiesList)
    
    nCities = nCitiesList(k);

    for i = 1:length(nPartiesList)

        nParties = nPartiesList(i);

        for j = 1:length(mediaEffectScalarList)

            mediaEffectScalar = mediaEffectScalarList(j);
            fprintf('nParties = %d, mediaEffectScalar = %.0d \n', nParties, ...
                mediaEffectScalar)

            nRural = floor(percentRural/100 * n);
            partiesList = Parties(nParties, minDistance);
            load('oskarfr_plotta_parties_binary.mat');

            [figHandle, plotHandle] = InitPlot(individuals, partiesList, nTimeSteps);

            title(sprintf('nCities = %d, nParties = %d, mediaEffect = %.3f, proportion affected by media: %.0d', ...
                nCities, nParties, mediaEffectScalar, proportionAffected))

            time = 0;

            while( time < nTimeSteps)

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

                if( mod(time, plotInterval) == 0)
                    UpdatePlot(individuals, partiesList, figHandle, plotHandle, time)
                end
            end
            
            %axis([0 3e6 0 1]);

            saveas(gcf, sprintf('part_nParties_%d_mediaE_%.2d_nC_%d.png', ...
                nParties, mediaEffectScalar, nCities));

        end

        close all;

    end
    
end