clear
clc

dado = struct("metodo", "qam", ...
                    "grau", 4);

piloto = struct("metodo",[], ...
            "grau",[], ...
            "razaoPilotoDado",[], ...
            "localizacao",[]);

piloto(1).metodo = ["qam" "qam" "qam" "qam"];
piloto(1).grau = [4 4 4 4];
piloto(1).razaoPilotoDado = [1 1 1 1];
descricaoTeste(1) = "qam(4)";

%% Usuário, alterações a partir desta linha. As modulações aceitas são: dpsk, pam, psk, qam.

piloto(2).metodo = ["qam" "psk" "pam" "qam"];
piloto(2).grau = [4 4 4 4];
piloto(2).razaoPilotoDado = [1 1 1 1];
descricaoTeste(2) = "qam(4) | psk(4) | pam(4) | qam(4)";

piloto(3).metodo = ["qam" "psk" "psk" "psk" "psk"];
piloto(3).grau = [4 4 4 8 4];
piloto(3).razaoPilotoDado = [1 1 1 1 1];
descricaoTeste(3) = "qam(4) | psk(4) | psk(4) | psk(4) | psk(4)"
% piloto(n)... Quantas pilotos quiser avaliar 

quantidadePortadora = 256;
tamanhoPrefixoCiclico = quantidadePortadora/4; % prefixo ciclico ou intervalo de guarda
tamanhoCanal = 16;
iteracoes = 1000;
signalnoiseRatio_v = [-20:2:28];

%% Simulações: NÃO ALTERAR
% simulação das diferentes disposições de portadoras pelo code adaptado
simular(dado,piloto,descricaoTeste,quantidadePortadora,tamanhoPrefixoCiclico,tamanhoCanal,iteracoes,signalnoiseRatio_v);
% simulação da QAM(4) disposições de portadoras pelo code original
simularOriginal(quantidadePortadora,length(piloto(1).grau),tamanhoPrefixoCiclico,tamanhoCanal,iteracoes,signalnoiseRatio_v);

%% Desenho dos gráficos
desenharGrafico(descricaoTeste,"Comparativo de diferentes designs de portadoras","northeast","fig1");
desenharGrafico([descricaoTeste(1) "originalOutput"],"Código Adaptado x Código Original","southeast","fig2");
