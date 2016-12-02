function counts = CountVotes(individuals, partiesList)
     [counts, ~] = hist(individuals(3,:), partiesList);
end