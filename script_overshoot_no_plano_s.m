wn = 1;
xis = [0: .01 : 1 ];       %vetor de xis variando de 0 a 1 a cada 0,01.

tr = zeros(size(xis));     %vetor para guardar os tempos de subida
tr0 = zeros(size(xis));    %vetor para guardar os tempos de subida
tr1 = zeros(size(xis));    %vetor para guardar os tempos de subida
tr2 = zeros(size(xis));    %vetor para guardar os tempos de subida
tr3 = zeros(size(xis));    %vetor para guardar os tempos de subida

Ts = [0:.0001:5]/wn;       % vetor de instantes de simula��o (depende de wn)
                           % wn maior, sistema mais r�pido, simula por menos tempo.
                           % wn menor, sistema mais lento, simula por mais temp
for c = 1:size(xis,2) 

    xi = xis(1, c);                        % pega um xi do vetor de xis
   sys = tf([wn^2],[1 2*xi*wn wn^2]);     % cria uma FT de 2a. ordem
   [Y, T] = step(sys, Ts);                % simula a resposta ao degrau
   p1=find(Y>=0.1);                       % pega o �ndice do vetor onde a sa�da chega a 10%
   p2=find(Y>=0.9);                       % pega o �ndice do vetor onde a sa�da chega a 90%
   tr(1,c) = (T(p2(1))-T(p1(1)))*wn;      % calcula o tempo de subida e multiplica por wn.

   %Pega o tempo de 90%, subtrai o tempo de 10% e multiplica por wn.

   tr0(1,c) = 1.6;                        % Aproxima��o de grau zero (constante)
   tr1(1,c) = (0.65+2*xi);                % Aproxima��o de 1o. grau. (reta)
   tr2(1,c) = (1.1 - 0.08*xi + 2.3*xi^2); % Approxima��o de 2o. grau
   tr3(1,c) = (1 + xi-0.4*xi^2+1.8*xi^3); % Appr. de 3o. grau
end

figure                             %Cria uma nova figura para mostrar o tr simulado.  
plot(xis, tr,'k', 'LineWidth',2)   %tr simulado - preto

% Coloca t�tulos de eixos
xlabel('\fontsize{15} \xi')
ylabel('\fontsize{15} t_r . \omega_n','HorizontalAlignment','right',...
    'Rotation',0);

figure                             %cria uma nova figura para mostrar o tr simulado e os calculados.
hold on                                  %permite que os gr�ficos a seguir apare�am sobrepostos
plot(xis, tr,'k--', 'LineWidth',2)       %tr simulado - preto
plot(xis, tr0,'b:', 'LineWidth',2)       %grau 0 - azul
plot(xis, tr1,'m:', 'LineWidth',2)       %1o. grau - magenta
plot(xis, tr2,'g:', 'LineWidth',2)       %2o. grau - verde
plot(xis, tr3,'r:', 'LineWidth',2)       %3o. grau - vermelho

% Coloca t�tulos de eixos
xlabel('\fontsize{15} \xi')
ylabel('\fontsize{15} t_r . \omega_n','HorizontalAlignment','right',...
    'Rotation',0);

hold off

