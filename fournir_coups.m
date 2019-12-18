% Utilisé pour calculer les coups possible, et seulement pour ca, ne
% modifie en rien position
function liste_coups = fournir_coups(position,trait)


liste_coups = [];
%note        = fournir_note(position);

%if note ~= -1
    if trait
        for fleche = ['g','d','h','b']
            [coup,note] = glisse(position,fleche);
            disp(fleche);
            disp(note);
            
            if ~isempty(find(coup.M ~= position.M))
                liste_coups = [liste_coups,coup];
            end
        end
    else %Génère des possibilités selon l'apparition des 2/4
        for i = 1 : 4
            for j = 1 : 4
                if position.M(i,j) == 0
                    for n = [2,4]
                        position.M(i,j) = n;
                        liste_coups     = [liste_coups,position];
                    end
                    
                    position.M(i,j) = 0;
                end
            end
        end
    end
%end

liste_coups = liste_coups(randperm(length(liste_coups)));

end
