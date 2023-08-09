function simular(teste_v,iteracoes)
% Simulação das disposições de piloto pelo code adaptado.
    for teste = teste_v
        rotulo = teste.rotulo;
        quantidadeSubportadora = teste.quantidadeSubportadora;
        tamanhoCanal_v = teste.tamanhoCanal_v;
        tamanhoPrefixoCiclico_v = teste.tamanhoPrefixoCiclico_v;
        signalNoiseRatio_v = teste.signalNoiseRatio_v;
        configSubportadoraDado = teste.configSubportadoraDado;
        configSubportadoraPiloto = teste.configSubportadoraPiloto;
        caminho4graf = strcat("../Saida/Tabelas/i",int2str(iteracoes),"/N",int2str(quantidadeSubportadora),"/I",int2str(teste.configSubportadoraPiloto.intervaloEntrePilotos),"/",teste.rotulo,"/");
        mkdir(caminho4graf);
        bErr= zeros(numel(teste.signalNoiseRatio_v),iteracoes);
        % matriz ifft
        F = exp(2*pi*sqrt(-1)/quantidadeSubportadora .* meshgrid(0:quantidadeSubportadora-1,0:quantidadeSubportadora-1)...
            .* repmat([0:quantidadeSubportadora-1]',[1,quantidadeSubportadora]));
        for i = 1:numel(tamanhoCanal_v)
            tamanhoCanal = tamanhoCanal_v(i);
            tamanhoPrefixoCiclico = tamanhoPrefixoCiclico_v(i);
            for indiceSNR = 1:numel(signalNoiseRatio_v)
                snr = signalNoiseRatio_v(indiceSNR)
                for iteracao = 1:iteracoes
                    % freq: Y=X.H + w=0
                    % coeficiente de canal randomicos
                    h(1:tamanhoCanal,1) = random('Normal',0,1,tamanhoCanal,1) + 1i * random('Normal',0,1,tamanhoCanal,1);  
                    h = h./sum(abs(h));    % normalizacao

                    [dadoModulado,bitsDadosEsperados] = modular(configSubportadoraDado,configSubportadoraPiloto); % já com Ep
                    dadoModulado = transpose(dadoModulado);
                    dadoModuladoIfft = ifft(dadoModulado,quantidadeSubportadora);
                    dadoModuladoIfftGi = [dadoModuladoIfft(quantidadeSubportadora - tamanhoPrefixoCiclico + 1 : quantidadeSubportadora); dadoModuladoIfft];

                    % MEIO/CANAL
                    dadoModuladoIfftGiRuido1 = filter(h,1,dadoModuladoIfftGi);

                     % adição ruído awgn (Gaussiano Branco)
                    dadoModuladoIfftGiRuido12 = awgn(dadoModuladoIfftGiRuido1 ...
                            , snr - db(std(dadoModuladoIfftGiRuido1))); % normalization to signal power

                    dadoModuladoIfftRuido = dadoModuladoIfftGiRuido12(tamanhoPrefixoCiclico+1:quantidadeSubportadora+tamanhoPrefixoCiclico);
                    dadoModuladoRuido = fft(dadoModuladoIfftRuido,quantidadeSubportadora);

                    hHats = estimarCanal(dadoModuladoRuido(configSubportadoraPiloto.localizacao_v), ...
                                 dadoModulado(configSubportadoraPiloto.localizacao_v), ...
                                 configSubportadoraPiloto, ...
                                 F, tamanhoCanal);

                    hHat = mean(hHats,2);

                    dadoModuladoRuido = dadoModuladoRuido./(fft(hHat,quantidadeSubportadora));

                    streamBits = demodular(dadoModuladoRuido,configSubportadoraDado,configSubportadoraPiloto);

                    [~, bErr(indiceSNR,iteracao)] = symerr(streamBits(configSubportadoraDado.localizacao_v)',bitsDadosEsperados);
                end
            end
            snr = signalNoiseRatio_v';
            bErr = mean(bErr,2);
            nomeTabela = strcat(caminho4graf,"L",int2str(tamanhoCanal),".txt");
            writetable(table(snr,bErr),nomeTabela);
        end
    end
end
