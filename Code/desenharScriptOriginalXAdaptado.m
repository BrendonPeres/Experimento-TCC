function desenharScriptOriginalXAdaptado(quantidadeSubportadora,intervaloSubportadora,tamanhoCanal,iteracoes)
    fig = figure("visible","off");
    set(fig,'color',[1 1 1]);          
    
    tabela = readtable("../Saida/Script Original x Script Adaptado/Script Original.txt");
    semilogy(tabela.snr,tabela.bErr,"-*");
    hold on;
    tabela = readtable(strcat("../Saida/Tabelas/i",num2str(iteracoes),"/N",num2str(quantidadeSubportadora),"/I",num2str(intervaloSubportadora),"/BPSK(0º)/L",num2str(tamanhoCanal),".txt"));
    semilogy(tabela.snr,tabela.bErr,"-*");

    legenda = legend(["Script Original" "Script Adaptado"],"location","northeast");
    set(legenda.BoxFace, 'ColorType','truecoloralpha', 'ColorData',uint8(255*[1.;1.;1.;0.3]));
    xlabel('SNR em dB'); ylabel('BER');
    title("Script Original x Script Adaptado",strcat("BPSK(0º),i=",num2str(iteracoes),",N=",num2str(quantidadeSubportadora),",I=",num2str(intervaloSubportadora),",L=",num2str(tamanhoCanal)));
    saveas(fig,"../Saida/Script Original x Script Adaptado/Script Original x Script Adaptado","png");
    hold off;
end