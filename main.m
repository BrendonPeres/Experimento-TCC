%% PARÂMETROS
% parâmetros dispositivo
dado = struct("metodo", "qam", ...
                    "grau", 4);

piloto = struct("metodo", ["qam" "qam" "qam" "qam"], ...
                "grau", [4 4 4 4], ...
                "razaoPilotoDado", [1 1 1 1]);

quantidadePortadora = 256;
quantidadePiloto = size(piloto.grau,2);
piloto.localizacao = [1:fix(quantidadePortadora/quantidadePiloto):quantidadePortadora];
dado.localizacao = setxor(1:quantidadePortadora,piloto.localizacao);

tamanhoPrefixoCiclico = quantidadePortadora/4; % prefixo ciclico ou intervalo de guarda

% parâmetros canal
tamanhoCanal = 16;

% parâmetros simulação
iteracoes = 500;
snr_v = [-20:2:28];
% matriz fft
F = exp(2*pi*sqrt(-1)/quantidadePortadora .* meshgrid([0:quantidadePortadora-1],[0:quantidadePortadora-1])...
    .* repmat([0:quantidadePortadora-1]',[1,quantidadePortadora]));

for( i = 1 : length(snr_v))
    snr = snr_v(i);
    for (iteracao = [1:iteracoes])
        % freq: Y=X.H + w=0
        % coeficiente de canal randomicos
        h(1:tamanhoCanal,1) = random('Normal',0,1,tamanhoCanal,1) + j * random('Normal',0,1,tamanhoCanal,1);  
        h = h./sum(abs(h));    % normalizacao

        [dadoModulado,bitsDadosEsperados] = modular(dado,piloto); % já com Ep
        dadoModulado = dadoModulado';
        dadoModuladoIfft = ifft(dadoModulado,quantidadePortadora);
        dadoModuladoIfftGi = [dadoModuladoIfft(quantidadePortadora - tamanhoPrefixoCiclico + 1 : quantidadePortadora); dadoModuladoIfft];
        
        %% MEIO/CANAL
        dadoModuladoIfftGiRuido1 = filter(h,1,dadoModuladoIfftGi);
        
        % adição ruído awgn (Gaussiano Branco)
        dadoModuladoIfftGiRuido12 = awgn(dadoModuladoIfftGiRuido1 ...
                , snr - db(std(dadoModuladoIfftGiRuido1))); % normalization to signal power

        dadoModuladoIfftRuido = dadoModuladoIfftGiRuido12(tamanhoPrefixoCiclico+1:quantidadePortadora+tamanhoPrefixoCiclico);
        dadoModuladoRuido = fft(dadoModuladoIfftRuido,quantidadePortadora);

        hHats = estimarCanal(dadoModuladoRuido(piloto.localizacao), ...
                     dadoModulado(piloto.localizacao), ...
                     piloto, ...
                     F, tamanhoCanal);

        hHat = mean(hHats,2);
        dadoModuladoRuido = dadoModuladoRuido./(fft(hHat,quantidadePortadora));

        streamBits = demodular(dadoModuladoRuido,dado,piloto);
        
        [nErr bErr(i,iteracao)] = symerr(streamBits(dado.localizacao)',bitsDadosEsperados);

    end
end

snr_v = snr_v';
bErr = mean(bErr,2);
table(snr_v,bErr);
writetable(table(snr_v,bErr),'output.txt');