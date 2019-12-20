function position = fournir_note(position)
poidsCasesLibres = 1;
poidsLissage = 2;
poidsMonotonie = 5;

noteCasesLibres = 0;
noteLissage = 0;
for i = 1 : 4
    for j = 1 : 4
        % Case libre : les cases vides rapportent des points pour favoriser le non remplissage du plateau de jeu
        if position.M(i,j) == 0
            noteCasesLibres = noteCasesLibres + poidsCasesLibres;
        else
            %Lissage : avantage si cases adjacentes egales
            if i-1 >= 1 && position.M(i-1,j) == position.M(i,j)
                noteLissage = noteLissage + poidsLissage;
            end
            if j+1 <= 4 && position.M(i,j+1) == position.M(i,j)
                noteLissage = noteLissage + poidsLissage;
            end
            if i+1 <= 4 && position.M(i+1,j) == position.M(i,j)
                noteLissage = noteLissage + poidsLissage;
            end
            if j-1 >= 1 && position.M(i,j-1) == position.M(i,j)
                noteLissage = noteLissage + poidsLissage;
            end
        end
    end
end

% Monotonie : plus grande valeur dans un coin et decroissant sur les bords
% Verifier plus grande valeur est dans un coin, une seule fois
bestVal = 0; bestValI = -1; bestValJ = -1;
for i = [1 4]
    for j = [1 4]
        if position.M(i,j) > bestVal
            bestVal = position.M(i,j);
            bestValI = i;
            bestValJ = j;
        end
    end
end
% Quand trouvee, il faut vérifier qu'il y a de la décroissance dans sa ligne/colonne en notant la succession des valeurs
noteColonne = 0;
noteLigne = 0;
if bestVal ~= 0
    if bestValI == 1
        i = 2;
        while i <= 4 && position.M(i, bestValJ) ~= 0
            valActu = log2(position.M(i, bestValJ));
            valPrec = log2(position.M(i-1, bestValJ));
            if valPrec > valActu
                noteColonne = noteColonne + poidsMonotonie * (1/(valPrec - valActu));
            elseif valPrec < valActu
                noteColonne = noteColonne - poidsMonotonie * (1/(valActu - valPrec));
            end
            i = i + 1;
        end
    else
        i = 3;
        while i >= 1 && position.M(i, bestValJ) ~= 0
            valActu = log2(position.M(i, bestValJ));
            valSuiv = log2(position.M(i+1, bestValJ));
            if valSuiv > valActu
                noteColonne = noteColonne + poidsMonotonie * (1/(valSuiv - valActu));
            elseif valSuiv < valActu
                noteColonne = noteColonne - poidsMonotonie * (1/(valActu - valSuiv));
            end
            i = i - 1;
        end
    end
    if bestValJ == 1
        j = 2;
        while j <= 4 && position.M(bestValI, j) ~= 0
            valActu = log2(position.M(bestValI, j));
            valPrec = log2(position.M(bestValI, j-1));
            if valPrec > valActu
                noteLigne = noteLigne + poidsMonotonie * (1/(valPrec - valActu));
            elseif valPrec < valActu
                noteLigne = noteLigne - poidsMonotonie * (1/(valActu - valPrec));
            end
            j = j + 1;
        end
    else
        j = 3;
        while j >= 1 && position.M(bestValI, j) ~= 0
            valActu = log2(position.M(bestValI, j));
            valSuiv = log2(position.M(bestValI, j+1));
            if valSuiv > valActu
                noteLigne = noteLigne + poidsMonotonie * (1/(valSuiv - valActu));
            elseif valSuiv < valActu
                noteLigne = noteLigne - poidsMonotonie * (1/(valActu - valSuiv));
            end
            j = j - 1;
        end
    end
end
noteMonotonie = noteLigne + noteColonne;

position.note = noteCasesLibres + noteLissage + noteMonotonie;
