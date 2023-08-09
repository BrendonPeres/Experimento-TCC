clear
clc

rng(128397218); % Garantir mesma semente entre os testes
iteracoes = 1000;
signalNoiseRatio_v = 0:2:50;

teste_v = struct("rotulo","", ...
    "quantidadeSubportadora",[], ...
    "tamanhoCanal_v",[], ...
    "tamanhoPrefixoCiclico_v",[], ...
    "signalNoiseRatio_v",[], ...
    "configSubportadoraDado",struct("metodo", "", ...
                    "grau", "", ...
                    "localizacao_v", []), ...
    "configSubportadoraPiloto",struct("metodo_v",[], ...
            "grau_v",[], ...
            "razaoPilotoDado_v",[], ...
            "localizacao_v",[], ... % preenchido em tempo de execução
            "rotacao_v",[]));

%% Cenários

% teste_v(1) é para comparar com o script original. Os mesmos parâmetros
% são dados para o simular adaptado e para o simular minimamente alterado
teste_v(1).rotulo = "BPSK(0º)";
teste_v(1).quantidadeSubportadora = 64;
teste_v(1).tamanhoCanal_v = 4;
teste_v(1).tamanhoPrefixoCiclico_v = ceil(teste_v(1).quantidadeSubportadora/4);
teste_v(1).signalNoiseRatio_v = signalNoiseRatio_v;
teste_v(1).configSubportadoraPiloto.intervaloEntrePilotos = 5;
teste_v(1).configSubportadoraPiloto.localizacao_v = [1:teste_v(1).configSubportadoraPiloto.intervaloEntrePilotos:64];
quantidadePilotos= numel(teste_v(1).configSubportadoraPiloto.localizacao_v);
teste_v(1).configSubportadoraPiloto.metodo_v = repmat("psk",[1 quantidadePilotos]);
teste_v(1).configSubportadoraPiloto.grau_v = repmat(2,[1 quantidadePilotos]);
teste_v(1).configSubportadoraPiloto.razaoPilotoDado_v = repmat(1,[1 quantidadePilotos]);
rotacao_= repmat(0,[1 quantidadePilotos]);
%rotacao_(2:2:12) = repmat(pi/4,[1 ceil(quantidadePilotos)]);
teste_v(1).configSubportadoraPiloto.rotacao_v = rotacao_;
teste_v(1).configSubportadoraDado.localizacao_v = setxor(1:teste_v(1).quantidadeSubportadora,teste_v(1).configSubportadoraPiloto.localizacao_v);
teste_v(1).configSubportadoraDado.metodo = "psk";
teste_v(1).configSubportadoraDado.grau = 2;

% USUÁRIO, ALTERAR A PARTIR DAQUI

teste_v(2).rotulo = "BPSK(135º),BPSK(45º),BPSK(135º)...";
teste_v(2).quantidadeSubportadora = 64;
teste_v(2).tamanhoCanal_v = 4:4:40;
teste_v(2).tamanhoPrefixoCiclico_v = ... 
    ones(1,numel(teste_v(2).tamanhoCanal_v))*ceil(teste_v(2).quantidadeSubportadora/4);
teste_v(2).signalNoiseRatio_v = signalNoiseRatio_v;
teste_v(2).configSubportadoraPiloto.intervaloEntrePilotos = 5;
teste_v(2).configSubportadoraPiloto.localizacao_v = [1:teste_v(2).configSubportadoraPiloto.intervaloEntrePilotos:teste_v(2).quantidadeSubportadora];
quantidadePilotos= numel(teste_v(2).configSubportadoraPiloto.localizacao_v);
teste_v(2).configSubportadoraPiloto.metodo_v = repmat("psk",[1 quantidadePilotos]);
teste_v(2).configSubportadoraPiloto.grau_v = repmat(2,[1 quantidadePilotos]);
teste_v(2).configSubportadoraPiloto.razaoPilotoDado_v = repmat(1,[1 quantidadePilotos]);
rotacao_= repmat(3*pi/4,[1 quantidadePilotos]);
rotacao_(2:2:12) = repmat(pi/4,[1 floor(quantidadePilotos/2)]);
teste_v(2).configSubportadoraPiloto.rotacao_v = rotacao_;
teste_v(2).configSubportadoraDado.localizacao_v = setxor(1:teste_v(2).quantidadeSubportadora,teste_v(2).configSubportadoraPiloto.localizacao_v);
teste_v(2).configSubportadoraDado.metodo = "psk";
teste_v(2).configSubportadoraDado.grau = 2;

teste_v(3).rotulo = "brendooon";
teste_v(3).quantidadeSubportadora = 64;
teste_v(3).tamanhoCanal_v = 4:4:40;
teste_v(3).tamanhoPrefixoCiclico_v = ... 
    ones(1,numel(teste_v(3).tamanhoCanal_v))*ceil(teste_v(3).quantidadeSubportadora/4);
teste_v(3).signalNoiseRatio_v = signalNoiseRatio_v;
teste_v(3).configSubportadoraPiloto.intervaloEntrePilotos = 5;
teste_v(3).configSubportadoraPiloto.localizacao_v = [1:teste_v(3).configSubportadoraPiloto.intervaloEntrePilotos:teste_v(3).quantidadeSubportadora];
quantidadePilotos= numel(teste_v(3).configSubportadoraPiloto.localizacao_v);
teste_v(3).configSubportadoraPiloto.metodo_v = repmat("psk",[1 quantidadePilotos]);
teste_v(3).configSubportadoraPiloto.grau_v = repmat(2,[1 quantidadePilotos]);
teste_v(3).configSubportadoraPiloto.razaoPilotoDado_v = repmat(1,[1 quantidadePilotos]);
rotacao_= repmat(3*pi/4,[1 quantidadePilotos]);
rotacao_(2:2:12) = repmat(pi/4,[1 floor(quantidadePilotos/2)]);
teste_v(3).configSubportadoraPiloto.rotacao_v = rotacao_;
teste_v(3).configSubportadoraDado.localizacao_v = setxor(1:teste_v(3).quantidadeSubportadora,teste_v(3).configSubportadoraPiloto.localizacao_v);
teste_v(3).configSubportadoraDado.metodo = "psk";
teste_v(3).configSubportadoraDado.grau = 2;

teste_v(4).rotulo = "BPSKXesque...";
teste_v(4).quantidadeSubportadora = 64;
teste_v(4).tamanhoCanal_v = 4:4:40;
teste_v(4).tamanhoPrefixoCiclico_v = ... 
    ones(1,numel(teste_v(4).tamanhoCanal_v))*ceil(teste_v(4).quantidadeSubportadora/4);
teste_v(4).signalNoiseRatio_v = signalNoiseRatio_v;
teste_v(4).configSubportadoraPiloto.intervaloEntrePilotos = 5;
teste_v(4).configSubportadoraPiloto.localizacao_v = [1:teste_v(4).configSubportadoraPiloto.intervaloEntrePilotos:teste_v(4).quantidadeSubportadora];
quantidadePilotos= numel(teste_v(4).configSubportadoraPiloto.localizacao_v);
teste_v(4).configSubportadoraPiloto.metodo_v = repmat("psk",[1 quantidadePilotos]);
teste_v(4).configSubportadoraPiloto.grau_v = repmat(2,[1 quantidadePilotos]);
teste_v(4).configSubportadoraPiloto.razaoPilotoDado_v = repmat(1,[1 quantidadePilotos]);
rotacao_= repmat(3*pi/4,[1 quantidadePilotos]);
rotacao_(2:2:12) = repmat(pi/4,[1 floor(quantidadePilotos/2)]);
teste_v(4).configSubportadoraPiloto.rotacao_v = rotacao_;
teste_v(4).configSubportadoraDado.localizacao_v = setxor(1:teste_v(4).quantidadeSubportadora,teste_v(4).configSubportadoraPiloto.localizacao_v);
teste_v(4).configSubportadoraDado.metodo = "psk";
teste_v(4).configSubportadoraDado.grau = 2;
 
teste_v(5).rotulo = "BPSK(0º)";
teste_v(5).quantidadeSubportadora = 256;
teste_v(5).tamanhoCanal_v = 4:4:40;
teste_v(5).tamanhoPrefixoCiclico_v = ... 
    ones(1,numel(teste_v(5).tamanhoCanal_v))*ceil(teste_v(5).quantidadeSubportadora/4);
teste_v(5).signalNoiseRatio_v = signalNoiseRatio_v;
teste_v(5).configSubportadoraPiloto.intervaloEntrePilotos = 8;
teste_v(5).configSubportadoraPiloto.localizacao_v = [1:teste_v(5).configSubportadoraPiloto.intervaloEntrePilotos:teste_v(5).quantidadeSubportadora];
quantidadePilotos= numel(teste_v(5).configSubportadoraPiloto.localizacao_v);
teste_v(5).configSubportadoraPiloto.metodo_v = repmat("psk",[1 quantidadePilotos]);
teste_v(5).configSubportadoraPiloto.grau_v = repmat(2,[1 quantidadePilotos]);
teste_v(5).configSubportadoraPiloto.razaoPilotoDado_v = repmat(1,[1 quantidadePilotos]);
rotacao_= repmat(0,[1 quantidadePilotos]);
%rotacao_(2:2:12) = repmat(pi/4,[1 ceil(quantidadePilotos)]);
teste_v(5).configSubportadoraPiloto.rotacao_v = rotacao_;
teste_v(5).configSubportadoraDado.localizacao_v = setxor(1:teste_v(5).quantidadeSubportadora,teste_v(5).configSubportadoraPiloto.localizacao_v);
teste_v(5).configSubportadoraDado.metodo = "psk";
teste_v(5).configSubportadoraDado.grau = 2;

teste_v(6).rotulo = "BPSK(135º),BPSK(45º),BPSK(135º)...";
teste_v(6).quantidadeSubportadora = 256;
teste_v(6).tamanhoCanal_v = 4:4:40;
teste_v(6).tamanhoPrefixoCiclico_v = ... 
    ones(1,numel(teste_v(6).tamanhoCanal_v))*ceil(teste_v(6).quantidadeSubportadora/4);
teste_v(6).signalNoiseRatio_v = signalNoiseRatio_v;
teste_v(6).configSubportadoraPiloto.intervaloEntrePilotos = 8;
teste_v(6).configSubportadoraPiloto.localizacao_v = [1:teste_v(6).configSubportadoraPiloto.intervaloEntrePilotos:teste_v(6).quantidadeSubportadora];
quantidadePilotos= numel(teste_v(6).configSubportadoraPiloto.localizacao_v);
teste_v(6).configSubportadoraPiloto.metodo_v = repmat("psk",[1 quantidadePilotos]);
teste_v(6).configSubportadoraPiloto.grau_v = repmat(2,[1 quantidadePilotos]);
teste_v(6).configSubportadoraPiloto.razaoPilotoDado_v = repmat(1,[1 quantidadePilotos]);
rotacao_= repmat(3*pi/4,[1 quantidadePilotos]);
rotacao_(2:2:32) = repmat(pi/4,[1 floor(quantidadePilotos/2)]);
teste_v(6).configSubportadoraPiloto.rotacao_v = rotacao_;
teste_v(6).configSubportadoraDado.localizacao_v = setxor(1:teste_v(6).quantidadeSubportadora,teste_v(6).configSubportadoraPiloto.localizacao_v);
teste_v(6).configSubportadoraDado.metodo = "psk";
teste_v(6).configSubportadoraDado.grau = 2;


%% Simulações: NÃO ALTERAR

% simular todos os teste_v
simular(teste_v, iteracoes);

% simular usando o script oficial minimamente alterado para que esse script
% seja automatizado
simularOriginal(teste_v(1).quantidadeSubportadora, ...
    teste_v(1).configSubportadoraPiloto.intervaloEntrePilotos, ...
    teste_v(1).tamanhoPrefixoCiclico_v(1), ...
    teste_v(1).tamanhoCanal_v(1), ...
    iteracoes, ...
    teste_v(1).signalNoiseRatio_v);

%% Desenho dos gráficos
desenharGraficos();
desenharScriptOriginalXAdaptado(teste_v(1).quantidadeSubportadora, ...
    teste_v(1).configSubportadoraPiloto.intervaloEntrePilotos, ...
    teste_v(1).tamanhoCanal_v(1), ...
    iteracoes);