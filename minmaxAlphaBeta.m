function [bestposition, note] = minmaxAlphaBeta(position, depth,alpha, beta, max)
    % lancer avec la ligne suivante dans le main : [bestPosition,note] = minmaxAlphaBeta(position, 4,-intmax,intmax, 1)

    liste_coups = fournir_coups(position, max);
    nbCoups = size(liste_coups,2);
    if depth == 0 || nbCoups == 0
        bestposition = position;
        note = fournir_note(position);
    elseif max
        note = -intmax;
        for i = 1 : nbCoups
            [tmppos, tmpnote] = minmaxAlphaBeta(liste_coups(i), depth-1,alpha, beta, 0);
            if tmpnote > note
                bestposition = liste_coups(i);
                note = tmpnote;
            end
            %alpha
            if alpha<note
                alpha = note;
            end
            %alpha = max(alpha,note);
            if alpha>=beta
                break;
            end
        end
    else
        note = 0;
        for i = 1 : nbCoups
            [tmppos, tmpnote] = minmaxAlphaBeta(liste_coups(i), depth-1,alpha, beta, 1);
            note = note + tmpnote;
            bestposition = tmppos;
            %beta
            if beta>note
                beta = note;
            end
            %beta = (note+beta)/2;
            if alpha>=beta
                break;
            end 
            
        end
        note = note / nbCoups;
    end
end

