function simular(dado,testesPiloto,descricaoTeste,quantidadePortadora,tamanhoPrefixoCiclico,tamanhoCanal,iteracoes,signalnoiseRatio_v)
% Simulação das disposições de piloto pelo code adaptado.

    % matriz ifft
    F = exp(2*pi*sqrt(-1)/quantidadePortadora .* meshgrid([0:quantidadePortadora-1],[0:quantidadePortadora-1])...
        .* repmat([0:quantidadePortadora-1]',[1,quantidadePortadora]));

    for (idxTeste = 1:length(testesPiloto))
        
        piloto = testesPiloto(idxTeste);
        piloto.localizacao = [1:ceil(quantidadePortadora/length(piloto.grau)):quantidadePortadora];
        dado.localizacao = setxor(1:quantidadePortadora,piloto.localizacao);
        tamanhoPrefixoCiclico = quantidadePortadora/4; % prefixo ciclico ou intervalo de guarda
    
        for (i = 1:length(signalnoiseRatio_v))
            snr = signalnoiseRatio_v(i);
            for (iteracao = [1:iteracoes])
                % freq: Y=X.H + w=0
                % coeficiente de canal randomicos
                h(1:tamanhoCanal,1) = random('Normal',0,1,tamanhoCanal,1) + j * random('Normal',0,1,tamanhoCanal,1);  
                h = h./sum(abs(h));    % normalizacao
        
                [dadoModulado,bitsDadosEsperados] = modular(dado,piloto); % já com Ep
                dadoModulado = dadoModulado';
                dadoModuladoIfft = ifft(dadoModulado,quantidadePortadora);
                dadoModuladoIfftGi = [dadoModuladoIfft(quantidadePortadora - tamanhoPrefixoCiclico + 1 : quantidadePortadora); dadoModuladoIfft];
                
                % MEIO/CANAL
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
        snr = signalnoiseRatio_v';
        bErr = mean(bErr,2);
        writetable(table(snr,bErr),strcat("../Output/",descricaoTeste(idxTeste),".txt"));
    end      
end               