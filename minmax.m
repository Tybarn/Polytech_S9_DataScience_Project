function [bestposition, note] = minmax(position, depth, max)
    % les matrices de cet etage
    liste_coups = fournir_coups(position, max);
    [nope, nbCoups] = size(liste_coups);
    if depth == 0 || nbCoups == 0
        bestposition = position;
        note = fournir_note(position);
    elseif max
        note = -intmax;
        for i = 1 : nbCoups
            [tmppos, tmpnote] = minmax(liste_coups(i), depth-1, 0);
            if tmpnote > note
                bestposition = liste_coups(i);
                note = tmpnote;
            end
        end
    else
        note = 0;
        for i = 1 : nbCoups
            [tmppos, tmpnote] = minmax(liste_coups(i), depth-1, 1);
            note = note + tmpnote;
            bestposition = tmppos;
        end
        note = note / nbCoups;
    end
end

