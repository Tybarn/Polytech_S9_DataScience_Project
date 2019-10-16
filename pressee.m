function fleche = pressee()

fleche = '';

while isempty(fleche)
    k     = waitforbuttonpress;
    value = double(get(gcf,'CurrentCharacter'));
    
    if     value == 28
        fleche = 'g';
    elseif value == 29
        fleche = 'd';
    elseif value == 30
        fleche = 'h';
    elseif value == 31
        fleche = 'b';
    elseif value == 115 % s pour stop
        disp('Fin de la partie')
        return
    end
end

end
