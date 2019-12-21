function [bestposition, note] = minmaxAlphaBeta(position, depth,alpha, beta, max)
    % lancer avec la ligne suivante dans le main : [bestPosition,note] = minmaxAlphaBeta(position, 4,-intmax,intmax, 1)

    liste_coups = fournir_coups(position, max);
    nbCoups = size(liste_coups,2);
	
	% si c'est la derniere node
    if depth == 0 || nbCoups == 0
        bestposition = position;
        note = fournir_note(position);
		
	% si c'est le joueur, on maximise
    elseif max
        note = -intmax;
        for i = 1 : nbCoups
            [tmppos, tmpnote] = minmaxAlphaBeta(liste_coups(i), depth-1,alpha, beta, 0);
            if tmpnote > note
                bestposition = liste_coups(i);
                note = tmpnote;
            end
            %alpha est maximiser avec la note
            if alpha<note
                alpha = note;
            end
            if alpha>=beta
                break;
            end
        end
	
	% sinon, c'est l'ordinateur et on fait la moyenne
    else
        note = 0;
        for i = 1 : nbCoups
            [tmppos, tmpnote] = minmaxAlphaBeta(liste_coups(i), depth-1,alpha, beta, 1);
            note = note + tmpnote;
            bestposition = tmppos;
            %beta est minimiser avec la note
            if beta>note
                beta = note;
            end
            if alpha>=beta
                break;
            end 
            
        end
        note = note / nbCoups;
    end
end

