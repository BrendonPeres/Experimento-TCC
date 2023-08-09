function desenharGraficos()
    titulo = "Comparativo de desempenho";
    for (nomeArquivo = obterNomeArquivos(strcat("../Saida/Tabelas/"),{'.','..','Graficos'}))
        caminho1 = strcat("../Saida/Tabelas/",nomeArquivo,"/"); % pasta's i
        for (nomeArquivo = obterNomeArquivos(caminho1,{'.','..'}))
            caminho2 = strcat(caminho1,nomeArquivo,"/"); % pasta's N
            for (nomeArquivo = obterNomeArquivos(caminho2,{'.','..'}))
                caminho3 = strcat(caminho2,nomeArquivo,"/"); % pasta's I
                nomePastasConstelacoes = obterNomeArquivos(caminho3,{'.','..'});
                arquivo2plot_v = obterNomeArquivos(strcat(caminho3,"/",nomePastasConstelacoes(1)),{'.','..'});

                fig = figure("visible","off");
                set(fig,'color',[1 1 1]);             
                aux=split(caminho3,"/");
                nomeGrafico = strcat(aux(4),"-",aux(5),"-",aux(6),"-");

                % plotar gráficos
                for (comprimentoCanal = 1:numel(obterNomeArquivos(strcat(caminho3,"/",nomePastasConstelacoes(1)),{'.','..'}))) % i-ésimo arquivo a ser desenhado
                    for (configSubportadorasPiloto = 1:numel(nomePastasConstelacoes)) % desenhar o i-ésimo arquivo da j-ésima configuração de constelacao (pasta)
                        tabela = readtable(strcat(caminho3,nomePastasConstelacoes(configSubportadorasPiloto),"/",arquivo2plot_v(comprimentoCanal)));
                        y{configSubportadorasPiloto} = tabela.bErr;
                        semilogy(tabela.snr,tabela.bErr,"-");
                        if (configSubportadorasPiloto == 1)
                            hold on;
                            x = tabela.snr;
                        end
                    end
                    
                    % plotar marcas de índices realçadoras
                    c = colororder;
                    m = cell2mat(y);
                    [menorValor, color] = min(m,[],2);
                    for (marca = 1:numel(color))
                        plot(x(marca),menorValor(marca),'o','MarkerEdgeColor',c(color(marca),:), 'LineWidth', 1.5, 'MarkerSize', 6);
                    end
                    hold off;
                    nomeGrafico_ = strcat(nomeGrafico,extractBefore(arquivo2plot_v(comprimentoCanal),"."));
                    legenda = legend(nomePastasConstelacoes,"location","northeast");
                    set(legenda.BoxFace, 'ColorType','truecoloralpha', 'ColorData',uint8(255*[1.;1.;1.;0.3]));
                    xlabel('SNR em dB'); ylabel('BER');
                    
                    % gerando subtitulo
                    arr = split(cellstr(nomeGrafico_),'-');
                    arr{1} = strcat(arr{1}(1),'=',arr{1}(1+1:end));
                    arr{2} = strcat(arr{2}(1),'=',arr{2}(1+1:end));
                    arr{3} = strcat(arr{3}(1),'=',arr{3}(1+1:end));
                    arr{4} = strcat(arr{4}(1),'=',arr{4}(1+1:end));
                    subtitulo = strcat(arr{1},',',arr{2},',',arr{3},',',arr{4});
                    title(titulo,subtitulo);

                    % salvar
                    saveas(fig,strcat("../Saida/Graficos/",nomeGrafico_),"png");
                end
            end
        end
    end
end