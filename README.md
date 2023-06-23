# Experimento-TCC

1º) Configuração das portadoras de dados pela struct (O código considera que só há um único tipo de portadora de dados

2º) Configuração das portadoras-pilotos pela struct (O código considera mais de um tipo de piloto, tanto em ordem, quanto em método). Os métodos aceitos são: dpsk, pam, psk, qam. 
Ex.: se for usar 10 pilotos, descreva as 10 pilotos na struct, mesmo que haja pilotos idênticas, e na exata sequência que queira elas dispostas.

3º) Definição da relação entre a energia da piloto em comparação a de dados

4º) Executar "main" no matlab, desde que todos os *.m estejam na mesma pasta

5º) Os BERxSNR estarão no "output.txt"

6º - opcional) Plotar o gráfico dele (e de outros se desejar). 
Ex.:

  bpsk = readtable("output_PilotoBPSK.txt");
  qam16 = readtable("output_Piloto16QAM.txt");
  bpskqam16 = readtable("output_PilotoBPSK16QAMalternados.txt");
  bpskqpsk = readtable("output_PilotoBPSKQPSKalternados.txt");

  f1 = figure(1);   
  set(f1,'color',[1 1 1]);
  plot(bpsk.snr_v,bpsk.bErr,'r->');
  hold on
  plot(qam16.snr_v,qam16.bErr,'g->');
  plot(bpskqam16.snr_v,bpskqam16.bErr,'b->');
  plot(bpskqpsk.snr_v,bpskqpsk.bErr,'k->');

  legenda=legend({'PSK(2)','QAM(16)','PSK(2) QAM(16) PSK(2)...','PSK(2) PSK(4) PSK(2)...'},'Location','southwest','FontSize',8);
  set(legenda.BoxFace, 'ColorType','truecoloralpha', 'ColorData',uint8(255*[.5;.5;.5;.8]))

  title("Pilotos com constelações heterogêneas");
  xlabel('SNR em dB');
  ylabel('BER'); 
  hold off
