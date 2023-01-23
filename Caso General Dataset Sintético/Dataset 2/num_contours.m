function [nLevels, cmap, M] = num_contours(vect)
m = min(vect);
M = max(vect);
if M > 0.9
    if m < 0.1
        nLevels = [0,0.1,0.3,0.5,0.7,0.9];
        
        clr1 = repmat([0.2422 0.1504 0.6603],(1/2)*1000, 1);
        clr2 = repmat([0.2802 0.2764 0.9204], 2*(3000 - 1000), 1);
        clr3 = repmat([0.154 0.5902 0.9218], 2*(5000 - 3000), 1);
        clr4 = repmat([0.1954 0.7765 0.6225], 2*(7000 - 5000), 1);
        clr5 = repmat([0.86 0.7413 0.1587], 2*(9000 - 7000), 1);
        clr6 = repmat([0.9769 0.9839 0.0805], 10000 - 9000 , 1);
        
        cmap = [clr1;clr2;clr3;clr4;clr5;clr6];
        colormap(cmap);
    
    elseif (0.1 <= m) && (m < 0.3)
        nLevels = [0.1,0.3,0.5,0.7,0.9];
        
        clr1 = repmat([0.2802 0.2764 0.9204],(1/2)*(3000 - 1000), 1);
        clr2 = repmat([0.154 0.5902 0.9218], 10*(5000 - 3000), 1);
        clr3 = repmat([0.1954 0.7765 0.6225], 12*(7000 - 5000), 1);
        clr4 = repmat([0.86 0.7413 0.1587], 10*(9000 - 7000) , 1);
        clr5 = repmat([0.9769 0.9839 0.0805], (1/4)*(10000 - 9000) , 1);
        
        cmap = [clr1;clr2;clr3;clr4;clr5];
        colormap(cmap);
    
        
    
    elseif (0.3 <= m) && (m < 0.5)
        nLevels = [0.3,0.5,0.7,0.9];
    
        clr1 = repmat([0.154 0.5902 0.9218], 2*(5000 - 3000), 1);
        clr2 = repmat([0.1954 0.7765 0.6225], 4*(7000 - 5000), 1);
        clr3 = repmat([0.86 0.7413 0.1587], 2*(9000 - 7000) , 1);
        clr4 = repmat([0.9769 0.9839 0.0805], 4*(10000 - 9000) , 1);
        
        cmap = [clr1;clr2;clr3;clr4];
        colormap(cmap);
        
    end
else
    if m < 0.1
        nLevels = [0,0.1,0.3,0.5,0.7,0.9];
        
        clr1 = repmat([0.2422 0.1504 0.6603],1000, 1);
        clr2 = repmat([0.2802 0.2764 0.9204], 5*(3000 - 1000), 1);
        clr3 = repmat([0.154 0.5902 0.9218], 4*(5000 - 3000), 1);
        clr4 = repmat([0.1954 0.7765 0.6225], 3*(7000 - 5000), 1);
        clr5 = repmat([0.86 0.7413 0.1587], 2*(9000 - 7000), 1);
        %clr6 = repmat([0.9769 0.9839 0.0805], 10000 - 9000 , 1);
        
        cmap = [clr1;clr2;clr3;clr4;clr5];%clr6];
        colormap(cmap);
    
    elseif (0.1 <= m) && (m < 0.3)
        nLevels = [0.1,0.3,0.5,0.7,0.9];
        
        clr1 = repmat([0.2802 0.2764 0.9204],(1/2)*(3000 - 1000), 1);
        clr2 = repmat([0.154 0.5902 0.9218], 12*(5000 - 3000), 1);
        clr3 = repmat([0.1954 0.7765 0.6225], 12*(7000 - 5000), 1);
        clr4 = repmat([0.86 0.7413 0.1587], 10*(9000 - 7000) , 1);
        %clr5 = repmat([0.9769 0.9839 0.0805], (1/4)*(10000 - 9000) , 1);
        
        cmap = [clr1;clr2;clr3;clr4];%clr5];
        colormap(cmap);
    
        
    
    elseif (0.3 <= m) && (m < 0.5)
        nLevels = [0.3,0.5,0.7,0.9];
    
        clr1 = repmat([0.154 0.5902 0.9218], 2*(5000 - 3000), 1);
        clr2 = repmat([0.1954 0.7765 0.6225], 4*(7000 - 5000), 1);
        clr3 = repmat([0.86 0.7413 0.1587], 2*(9000 - 7000) , 1);
        clr4 = repmat([0.9769 0.9839 0.0805], 4*(10000 - 9000) , 1);
        
        cmap = [clr1;clr2;clr3;clr4];
        colormap(cmap);
        
    end

end