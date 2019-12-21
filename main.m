tstart = tic;
position.M = [2,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
position.score = 0;
fleche = 'a'; % Valeur de base inutile, juste pour entrer dans la boucle
while fleche ~= 's'
    %Générateur de nouvelles cases
    liste_coups = fournir_coups(position,0);
    [line,col] = size(liste_coups);
    if col == 0
        break;
    end
    i = randi(col);
    position = liste_coups(i);
    %afficher_position(position);
    
    %Calcul du prochain coup de l'IA
    [bestPosition,note] = minmax(position, 4, 1);
    %disp(bestPosition.direction);
    
    %Application du coup du joueur
    %fleche = pressee();
    position = glisse(position, bestPosition.direction);
    %position = glisse(position, fleche);
    %afficher_position(position);
end

disp(position.score);
afficher_position(position);
disp("GAME TERMINEE");
disp("temps (secondes): ");
disp(toc(tstart));
disp("plus grande valeur: ");
disp(max(position.M(:)));
pause(15);