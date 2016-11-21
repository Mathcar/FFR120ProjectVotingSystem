function colors = CalcColors(partiesList)
   nColors = size(colormap, 1);
   baseColors = colormap;
   colorIndices = floor(nColors*partiesList*(1-eps)) + 1;
   colors = baseColors(colorIndices, :);
   
end