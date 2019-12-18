function note = fournir_note(position)

note = 0;
% penalité si trop de cases non vide
 for i = 1 : 4
        for j = 1 : 4
            if position.M(i,j) == 0
                note = note + 1;
            end
        end
            
 end

% plus grande valeur dans un coin et decroissant sur les bords
% VErifier plus grande valeur est dans un coin, une seule fois
% Quand trouvee, il faut vérifier qu'il y a de la décroissance dans sa
% ligne/colonne en notant la succession des valeurs (ratio?)

%avantage si cases adjacentes egales
for i = 1 : 4
    for j = 1 : 4
        if i-1 >= 1 && position.M(i-1,j) == position.M(i,j)
            note = note + 1;
        end
        if j+1 <= 4 && position.M(i,j+1) == position.M(i,j)
            note = note + 1;
        end
        if i+1 <= 4 && position.M(i+1,j) == position.M(i,j)
            note = note + 1;
        end
        if j-1 >= 1 && position.M(i,j-1) == position.M(i,j)
            note = note + 1;
        end
    end
end

