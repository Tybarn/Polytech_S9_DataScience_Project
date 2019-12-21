function [bestposition, note] = minmax(position, depth, max)
    % Genere les grilles a noter / fils de ce noeud dans l'arbre
    liste_coups = fournir_coups(position, max);
    [nope, nbCoups] = size(liste_coups);
    % Cas d'une feuille
    if depth == 0 || nbCoups == 0
        bestposition = position;
        note = fournir_note(position);
    % Cas tour du joueur
    elseif max
        note = -intmax;
        for i = 1 : nbCoups
            [tmppos, tmpnote] = minmax(liste_coups(i), depth-1, 0);
            if tmpnote > note
                bestposition = liste_coups(i);
                note = tmpnote;
            end
        end
    % Cas tour de l'ordinateur -> genere les nouvelles valeurs a ajouter
    else
        % Min = moyenne de toutes les possibilités de nouvelles valeurs
        note = 0;
        for i = 1 : nbCoups
            [tmppos, tmpnote] = minmax(liste_coups(i), depth-1, 1);
            note = note + tmpnote;
            bestposition = tmppos;
        end
        note = note / nbCoups;
    end
end

