function individuals = Media(individuals, proportionAffected)
% MEDIA Media affecting some percentage of all individuals
%
%   Inputs:
%       individuals: All invividuals
%       proportionAffected: The proportion of people which will be affected by
%       the media.
%
%   Outputs:
%       individuals: All individuals
    
    mediaEffectScalar = .2;

    n = size(individuals, 2);
    nAffected = floor(proportionAffected*n);
    indicesAffected = randperm(n, nAffected);
    
    mediaPosition = randi(2)*2 - 3; % media pos either -1 or 1
    mediaEffect = mediaEffectScalar*rand;
    
    for i = 1:nAffected
        
        newOpinion = individuals(4, indicesAffected(i)) + ...
            mediaPosition*mediaEffect;
        
        individuals(4, indicesAffected(i)) = newOpinion - ...
            (newOpinion<0)*newOpinion - (newOpinion>1)*(newOpinion-1);
        
        % newOpinion might become <0 or >1, so it is corrected into the
        % nearest point on [0, 1].
        
    end
    

end

