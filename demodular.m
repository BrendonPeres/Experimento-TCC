function bits = demodular(dadoModuladoRuidoGauss,dado,piloto)
    qtdPortadoras = size(dado.localizacao,2) + size(piloto.localizacao,2);
    bits = zeros(1, qtdPortadoras);
    
    % dados
    if (dado.metodo == "dpsk") 
        bits(dado.localizacao) = dpskdemod(dadoModuladoRuidoGauss(dado.localizacao), dado.grau);
    elseif (dado.metodo == "psk")
        bits(dado.localizacao) = pskdemod(dadoModuladoRuidoGauss(dado.localizacao), dado.grau);
    elseif (dado.metodo == "pam")
        bits(dado.localizacao) = pamdemod(dadoModuladoRuidoGauss(dado.localizacao), dado.grau);
    elseif (dado.metodo == "qam")
        bits(dado.localizacao) = qamdemod(dadoModuladoRuidoGauss(dado.localizacao), dado.grau);
    end
    
    % pilotos
    for idx = 1:size(piloto.localizacao,2)
        if (piloto.metodo(idx) == "dpsk")
            bits(piloto.localizacao(idx)) = dpskdemod(dadoModuladoRuidoGauss(piloto.localizacao(idx)), piloto.grau(idx));
        elseif (piloto.metodo(idx) == "psk")
            bits(piloto.localizacao(idx)) = pskdemod(dadoModuladoRuidoGauss(piloto.localizacao(idx)), piloto.grau(idx));
        elseif (piloto.metodo(idx) == "pam")
            bits(piloto.localizacao(idx)) = pamdemod(dadoModuladoRuidoGauss(piloto.localizacao(idx)), piloto.grau(idx));
        elseif (piloto.metodo(idx) == "qam")
            bits(piloto.localizacao(idx)) = qamdemod(dadoModuladoRuidoGauss(piloto.localizacao(idx)), piloto.grau(idx));
        end
    end

end