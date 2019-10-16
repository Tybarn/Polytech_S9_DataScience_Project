fleche = 'h';
position.M = [0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0];
trait = 0;
while fleche <> 's' then
    fleche = pressee();
    liste_coups = fournir_coups(position,trait);
    trait = ~trait;
    afficher_position(position);
end
