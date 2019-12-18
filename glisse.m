%Modifie la matrice position selon la fleche
function [position, note] = glisse(position,fleche)

note = 0;
M = position.M;

if     fleche == 'g'
    M = rot90(M);
elseif fleche == 'h'
    M = rot90(rot90(M));
elseif fleche == 'd'
    M = rot90(rot90(rot90(M)));
end 

for j = 1 : 4
    imax = 4;
    
    for i = 3 :-1: 1
        if M(i,j) ~= 0
            ii = i;
            
            while ii < imax
                ii = ii + 1;
                
                if M(ii,j) == M(ii-1,j)
                    M(ii,j)   = M(ii,j)*2;
                    note = note + M(ii,j);
                    M(ii-1,j) = 0;
                    imax      = ii - 1;
                elseif M(ii,j) == 0
                    M(ii,j)   = M(ii-1,j);
                    M(ii-1,j) = 0;
                else
                    imax      = ii - 1;
                end
            end            
        end
    end
end

if     fleche == 'g'
    M = rot90(rot90(rot90(M)));
elseif fleche == 'h'
    M = rot90(rot90(M));
elseif fleche == 'd'
    M = rot90(M);
end 

position.M = M;

end
