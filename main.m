position.M = [2,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
afficher_position(position);
fleche = 'a'; % Valeur de base inutile, juste pour entrer dans la boucle
trait = 0;
while fleche ~= 's'
    %G�n�rateur de nouvelles cases
    liste_coups = fournir_coups(position,trait);
    [line,col] = size(liste_coups);
    if col == 0
        break;
    end
    i = randi(col);
    position = liste_coups(i);
    afficher_position(position);
    
    %Calcul des coups possible du joueur
    trait = ~trait;
    liste_coups = fournir_coups(position,trait);
    
    %Application du coup du joueur
    fleche = pressee();
    position = glisse(position, fleche);
    afficher_position(position);
    trait = ~trait;
end

disp("GAME TERMINEE")