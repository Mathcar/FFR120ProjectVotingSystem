function counts = CountVotes(individuals, partiesList)
     nParties = length(partiesList);
     bins = 1:nParties;
     opinions = individuals(4,:);
     distances = pdist2(opinions', partiesList);
     [~, votes] = min(distances,[], 2);
     [counts, ~] = hist(votes, bins);
end