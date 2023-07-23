clear
clc

dado = struct("metodo", "qam", ...
                    "grau", 4);

piloto = struct("metodo",[], ...
            "grau",[], ...
            "razaoPilotoDado",[], ...
            "localizacao",[], ...
            "rotacao",[]);

piloto(1).metodo = ["qam" "qam" "qam" "qam"];
piloto(1).grau = [4 4 4 4];
piloto(1).razaoPilotoDado = [1 1 1 1];
piloto(1).rotacao = [0 0 0 0];
descricaoTeste(1) = "4x qam(4)";

%% Usuário, alterações a partir desta linha. As modulações aceitas são: dpsk, pam, psk, qam.
piloto(2).metodo = repmat("psk",[1 128]);
piloto(2).grau = repmat(2,[1 128]);
piloto(2).razaoPilotoDado = repmat(1,[1 128]);
piloto(2).rotacao = repmat(0,[1 128]);
descricaoTeste(2) = "bpsk(0º)";

piloto(3).metodo = repmat("psk",[1 128]);
piloto(3).grau = repmat(2,[1 128]);
piloto(3).razaoPilotoDado = repmat(1,[1 128]);
piloto(3).rotacao = [repmat(0,[1 32]) repmat(pi/6,[1 32]) repmat(pi/3,[1 32]) repmat(pi/2,[1 32])];
descricaoTeste(3) = "bpsk(0º),bpsk(30º),bpsk(60º),bpsk(90º)";

piloto(4).metodo = repmat("psk",[1 128]);
piloto(4).grau = repmat(2,[1 128]);
piloto(4).razaoPilotoDado = repmat(1,[1 128]);
piloto(4).rotacao = [repmat(pi/2,[1 32]) repmat(4*pi/6,[1 32]) repmat(5*pi/6,[1 32]) repmat(pi,[1 32])];
descricaoTeste(4) = "bpsk(90º),bpsk(120º),bpsk(150º),bpsk(180º)";

piloto(5).metodo = repmat("psk",[1 128]);
piloto(5).grau = repmat(2,[1 128]);
piloto(5).razaoPilotoDado = repmat(1,[1 128]);
piloto(5).rotacao = [repmat(pi,[1 32]) repmat(7*pi/6,[1 32]) repmat(8*pi/6,[1 32]) repmat(9*pi/6,[1 32])];
descricaoTeste(5) = "bpsk(180º),bpsk(210º),bpsk(240º),bpsk(270º)";

piloto(6).metodo = repmat("psk",[1 128]);
piloto(6).grau = repmat(2,[1 128]);
piloto(6).razaoPilotoDado = repmat(1,[1 128]);
piloto(6).rotacao = [repmat(9*pi/6,[1 32]) repmat(10*pi/6,[1 32]) repmat(11*pi/6,[1 32]) repmat(12*pi/6,[1 32])];
descricaoTeste(6) = "bpsk(270º),bpsk(300º),bpsk(330º),bpsk(360º)";


% piloto(n)... Quantas pilotos quiser avaliar 

quantidadePortadora = 256;
tamanhoPrefixoCiclico = ceil(quantidadePortadora/4); % prefixo ciclico ou intervalo de guarda
tamanhoCanal = 16;
iteracoes = 1000;
signalnoiseRatio_v = [-20:2:28];

%% Simulações: NÃO ALTERAR
% simulação das diferentes disposições de portadoras pelo code adaptado
simular(dado,piloto,descricaoTeste,quantidadePortadora,tamanhoPrefixoCiclico,tamanhoCanal,iteracoes,signalnoiseRatio_v);
simularOriginal(quantidadePortadora,length(piloto(1).grau),tamanhoPrefixoCiclico,tamanhoCanal,iteracoes,signalnoiseRatio_v);

%% Desenho dos gráficos
desenharGrafico([descricaoTeste(2) descricaoTeste(3) descricaoTeste(4) descricaoTeste(5) descricaoTeste(6)] ,"Comparativo de diferentes designs de portadoras","northeast","fig1");
desenharGrafico([descricaoTeste(1) "originalOutput"],"Código Adaptado x Código Original","southeast","fig2");