position.M = [0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0];
trait = false;
fleche = 'h';
while fleche ~= 's'
    afficher_position(position);
    
    liste_coups = fournir_coups(position,trait);
    trait = ~trait;
    if trait
        fleche = pressee();
    end
    display(position.M);
end