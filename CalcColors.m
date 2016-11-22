function colors = CalcColors(partiesList)
    nColors = size(colormap, 1);
    baseColors = colormap;
    
    colorIndices = floor((nColors-1)*partiesList) + 1;
    
    colors = baseColors(colorIndices, :);
end