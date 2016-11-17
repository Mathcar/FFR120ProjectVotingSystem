function [] = PlotIndividualsSimple(individuals)
%PLOTINDIVIDUALSSIMPLE Plot individuals using colors
%
%   Inputs:
%       Individuals
%
%   Outputs:
%       Plot


    pointsize = 8;
    scatter(individuals(1,:), individuals(2,:), ...
        pointsize, individuals(4,:), 'filled');
    colorbar;

end

