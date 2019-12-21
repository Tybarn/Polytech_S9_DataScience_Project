% Timer temps d'execution
tstart = tic;

% Init de la grille
position.M = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
position.score = 0;

% Boucle de jeu
fleche = 'a'; % Valeur de base inutile, juste pour entrer dans la boucle
while fleche ~= 's'
    % Générateur de nouvelles cases
    liste_coups = fournir_coups(position,0);
    [line,col] = size(liste_coups);
    if col == 0
        break;
    end
    i = randi(col);
    position = liste_coups(i);
    
    % --------- PARTIE JOUEUR REEL ---------
    %afficher_position(position);
    %fleche = pressee();
    %position = glisse(position, fleche);
    %afficher_position(position);
    
    % --------- PARTIE IA = JOUEUR ---------
    [bestPosition,note] = minmax(position, 3, 1); %Calcul du prochain coup de l'IA
    position = glisse(position, bestPosition.direction);
    %afficher_position(position);
end

% Affichage final
afficher_position(position);
disp("GAME TERMINEE");
disp("temps (secondes): ");
disp(toc(tstart)); % calcul temps d'execution
disp("score : ");
disp(position.score);
disp("plus grande valeur: ");
disp(max(position.M(:)));
pause(15); % Pour laisser le temps a matlab d'afficher la matrice