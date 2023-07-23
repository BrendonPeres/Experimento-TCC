function desenharGrafico(nomeArquivos,titulo,posicao,nomeArquivoSaida)
    % Desenha gráficos a partir dos arquivos gerados.
    fig = figure('visible','off');
    set(fig,'color',[1 1 1]);
    hold on;
    
    for (nomeArquivo = nomeArquivos)
        caminho = strcat("../Output/",nomeArquivo,".txt"); 
        tabela = readtable(caminho);
        semilogy(tabela.snr,tabela.bErr,"-*");
    end

    legenda = legend(nomeArquivos,"location",posicao);
    set(legenda.BoxFace, 'ColorType','truecoloralpha', 'ColorData',uint8(255*[1.;1.;1.;0.3]));
    xlabel('SNR em dB'); ylabel('BER');
    title(titulo);
    hold off;
    saveas(fig,strcat("../Output/",nomeArquivoSaida),"png");

end