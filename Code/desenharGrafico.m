function desenharGraficos(pastaPai)
    % Desenha gráficos a partir dos arquivos gerados.
    titulo = "Comparativo de desempenho";
    % nomePastaSaida = [nomePastas(1) + " x " + extractAfter(nomePastas(2),"-")];
    % caminho4graf = strcat("/MATLAB Drive/ExperimentoTCC/Saida/",nomePastaSaida,"/");
    % mkdir(caminho4graf);
    % 
    pastas = dir(pastaPai);
    pastas = pastas.name;
    caminho = strcat("../",pastaPai,"/");
    for (pasta = dir(pastaPai)) % iteracoes
        caminho1 = strcat("../",pastaPai,"/",pasta.name,"/");
        for (pasta = dir(caminho1)) % N
            caminho2 = strcat(caminho1,pasta,"/");
            for (pasta = dir(caminho2)) % I
                caminho3 = strcat(caminho2,pasta,"/");
                fig = figure("visible","off");
                set(fig,'color',[1 1 1]);
                axis = struct("x",[],"y",[]);
                
                quantidadeLs = numel(dir(caminho3))
              
                for (idx = 1:quantidadeLs)
                    pastas = dir(caminho3);
                    for (j = 3:numel(pastas)) % acessar as pastas, fazer levantamento delas, e plotar todas que tiverem (entra ploeta-volta), e salvar na pasta plots (ao lado das dos tipos)
                        tabela = readtable(strcat(caminho3,pastas{idx}.name,"/"));
                        axis(j).x = tbl.snr;
                        axis(j).y = tbl.bErr;
                        semilogy(tbl.snr,tbl.bErr,"-*")
                        if (j == 1)
                            hold on;
                        end
                    end
                end
            end
        end
    end
end
    %     idx2select = logical(axis(2).y < axis(1).y);
    %     plot(axis(2).x(idx2select), axis(2).y(idx2select),'go', 'LineWidth', 1.5, 'MarkerSize', 8);
    %     hold off;
    % 
    %     for (i = 1:numel(nomePastas))
    %     caminho(i) = strcat("../Saida/",nomePastas(i),"/");
    %     aux = dir(strcat(caminho(i),"/*.txt"));
    %     nomeArquivos{i} = string({aux.name});
    % end    
    % fig = figure("visible","off");
    % set(fig,'color',[1 1 1]);
    % axis = struct("x",[],"y",[]);
    % for (i = 1:numel(nomeArquivos{1}))
    %     subtitulo = extractBefore(nomeArquivos{1}(i),".");
    %     subtitulo = split(subtitulo,"-");
    %     subtitulo = strcat(subtitulo(2),",",subtitulo(3),",",subtitulo(4),",",subtitulo(5));
    %     for (j = 1:2)
    %         tbl = readtable(strcat(caminho(j),nomeArquivos{j}(i)));
    %         axis(j).x = tbl.snr;
    %         axis(j).y = tbl.bErr;
    %         semilogy(tbl.snr,tbl.bErr,"-*")
    %         if (j == 1)
    %             hold on;
    %         end
    %     end
    %     % idx2select = logical(axis(2).y < axis(1).y);
    %     % plot(axis(2).x(idx2select), axis(2).y(idx2select),'go', 'LineWidth', 1.5, 'MarkerSize', 8);
    %     hold off;
    %     % legenda = legend(extractAfter(nomePastas,"-"),"location","northeast");
    %     % set(legenda.BoxFace, 'ColorType','truecoloralpha', 'ColorData',uint8(255*[1.;1.;1.;0.3]));
    %     % xlabel('SNR em dB'); ylabel('BER');
    %     title(titulo,subtitulo);
    %     saveas(fig,strcat(caminho4graf,subtitulo),"png");
    % end
    %     tbl = readtable(strcat("../Output/",nomeArquivos(i),".txt"));
    %     axis(i).x = tbl.snr;
    %     axis(i).y = tbl.bErr;
    %     semilogy(tbl.snr,tbl.bErr,"-*");
    %     if (i==1)
    %         hold on;
    %     end
    % end
    % idx2select = logical(axis(2).y < axis(1).y);
    % 
    % %plot(axis(2).x(idx2select), axis(2).y(idx2select),'go', 'LineWidth', 1.5, 'MarkerSize', 8);
    % hold off;
    % 
    % legenda = legend(nomeArquivos,"location",posicao);
    % set(legenda.BoxFace, 'ColorType','truecoloralpha', 'ColorData',uint8(255*[1.;1.;1.;0.3]));
    % xlabel('SNR em dB'); ylabel('BER');
    % title(titulo,subtitulo);
    % %title('Código Adaptado x Código Original, com L=4', 'Units', 'normalized', 'Position', [0.465, 1.02]);
    % saveas(fig,strcat("../Output/",nomeArquivoSaida),"png");
end