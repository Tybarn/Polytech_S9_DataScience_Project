function note = fournir_note(position)
    note = casesLibres(position) + maxInCorner(position) + snake(position);
end

%Lissage : avantage si cases adjacentes egales
function note = lissage(position)
    poidsLissage = 10;
    note = 0;
    for i = 1 : 4
        for j = 1 : 4
              if i-1 >= 1 && position.M(i-1,j) == position.M(i,j)
                  note = note + poidsLissage;
              end
              if j+1 <= 4 && position.M(i,j+1) == position.M(i,j)
                  note = note + poidsLissage;
              end
              if i+1 <= 4 && position.M(i+1,j) == position.M(i,j)
                  note = note + poidsLissage;
              end
              if j-1 >= 1 && position.M(i,j-1) == position.M(i,j)
                 note = note + poidsLissage;
              end
        end
    end
end

% Case libre : les cases vides rapportent des points pour favoriser le non remplissage du plateau de jeu
function note = casesLibres(position)
    poidsCasesLibres = 8000;
    note = 0;
    for i = 1 : 4
        for j = 1 : 4
            if position.M(i,j) == 0
                note = note + poidsCasesLibres;
            end
        end
    end
end

% Monotonie : plus grande valeur dans un coin et decroissant sur les bords 
function note = monotomieV1(position)
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
    note = noteLigne + noteColonne;
end

function note = maxInCorner(position)
    note = 0;
    % Plus grande valeur dans le coin en haut à gauche
    [maxValue, linearIndexes] = max(position.M(:));
    if linearIndexes(1) == 1
        note = 65536*(log(maxValue)/log(2));
    end
end

% Structurer grille comme un serpent
function note = snake(position)
    poidsCases = [65536 32768 16384 8192 512 1024 2048 4096 256 128 64 32 2 4 8 16];
    note = 0;
    
    % Chercher à obtenir une structure de serpent dans la grille
    for i = 1 : 4
        for j = 1 : 4
            if position.M(i,j) > 0
                note = note + poidsCases((i-1)*4+j)*log2(position.M(i,j));
            end
        end
    end
    
    for i = 1 : 4
        if mod(i,2) == 1
            for j = 2 : 4
                valPrec = log2(position.M(i,j-1));
                valActu = log2(position.M(i,j));
                if valPrec > valActu
                    note = note + poidsCases((i-1)*4+j) * (1/(valPrec - valActu));
                elseif valPrec < valActu
                    note = note - poidsCases((i-1)*4+j-1) * (1/(valActu - valPrec));
                end
            end
        elseif mod(i,2) == 0
            for j = 3 : -1 : 1
                valPrec = log2(position.M(i,j+1));
                valActu = log2(position.M(i,j));
                if valPrec > valActu
                    note = note + poidsCases((i-1)*4+j) * (1/(valPrec - valActu));
                elseif valPrec < valActu
                    note = note - poidsCases((i-1)*4+j+1) * (1/(valActu - valPrec));
                end
            end
        end
    end
end