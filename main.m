position.M = [2,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
position.note = -1;
fleche = 'a'; % Valeur de base inutile, juste pour entrer dans la boucle
trait = 0;
while fleche ~= 's'
    %Générateur de nouvelles cases
    liste_coups = fournir_coups(position,trait);
    [line,col] = size(liste_coups);
    if col == 0
        break;
    end
    i = randi(col);
    position = liste_coups(i);
    afficher_position(position);
    
    %Calcul des coups possibles du joueur
    trait = ~trait;
    liste_coups = fournir_coups(position,trait);
    
    %Application du coup du joueur
    fleche = pressee();
    position = glisse(position, fleche);
    position = fournir_note(position);
    disp(position.M);
    disp(position.note);
    afficher_position(position);
    trait = ~trait;
end

disp("GAME TERMINEE");