%Affichage du jeu
function afficher_position(position)

M            = position.M;
Coul(   1,:) = [0.85 0.80 0.80];
Coul(   2,:) = [0.90 0.90 0.90];
Coul(   4,:) = [0.97 0.90 0.70];
Coul( 128,:) = [0.88 0.80 0.60];
Coul(   8,:) = [0.97 0.70 0.40];
Coul(  16,:) = [0.97 0.60 0.30];
Coul(  32,:) = [0.97 0.30 0.20];
Coul(  64,:) = [1.00 0.00 0.00];
Coul( 128,:) = [0.90 0.80 0.42];
Coul( 256,:) = [0.85 0.76 0.40];
Coul( 512,:) = [0.85 0.76 0.40];
Coul(1024,:) = [0.90 0.76 0.40];
Coul(2048,:) = [0.97 0.60 0.30];
Coul(4096,:) = [0.10 0.10 0.10];
%figure(1)
hold on
rectangle('Position',[-.05 -.05 4.1 4.1],'Curvature',0.05,'FaceColor', ...
    [0.55 0.5 0.5],'EdgeColor', ...
    [0.55 0.5 0.5])

for i = 1 : 4
    for j = 1 : 4
        n = M(i,j);
        
        if n == 0
            n = 1;
        end
            
        rectangle('Position',[.1+j-1 4.1-i .8 .8],'Curvature',0.05, ...
            'FaceColor', Coul(n,:),'EdgeColor', Coul(n,:))
        
        if n <= 1
        elseif n <= 4
            text(j-.6,5-i-.55,num2str(n),'Color','k','FontWeight','bold', ...
                'FontSize',30);
        elseif n <= 8
            text(j-.6,5-i-.55,num2str(n),'Color','w','FontWeight','bold',...
                'FontSize',30);
        elseif n <= 64
            text(j-.67,5-i-.55,num2str(n),'Color','w','FontWeight','bold',...
                'FontSize',30);
        elseif n <= 512
            text(j-.75,5-i-.55,num2str(n),'Color','w','FontWeight','bold',...
                'FontSize',30);
        elseif n <= 4096
            text(j-.86,5-i-.55,num2str(n),'Color','w','FontWeight','bold',...
                'FontSize',30);
        end 
    end
end

axis equal
set(gca,'visible','off');

end
