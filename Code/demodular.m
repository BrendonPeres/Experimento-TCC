function bits = demodular(dadoModuladoRuidoGauss,configSubportadoraDado,configSubportadoraPiloto)
% Demodulação do código conforme cada tipo de portadora.
    qtdPortadoras = numel(configSubportadoraDado.localizacao_v) + numel(configSubportadoraPiloto.localizacao_v,2);
    bits = zeros(1, qtdPortadoras);
    
    % configSubportadoraDados
    if (configSubportadoraDado.metodo == "dpsk") 
        bits(configSubportadoraDado.localizacao_v) = dpskdemod(dadoModuladoRuidoGauss(configSubportadoraDado.localizacao_v), configSubportadoraDado.grau);
    elseif (configSubportadoraDado.metodo == "psk")
        bits(configSubportadoraDado.localizacao_v) = pskdemod(dadoModuladoRuidoGauss(configSubportadoraDado.localizacao_v), configSubportadoraDado.grau);
    elseif (configSubportadoraDado.metodo == "pam")
        bits(configSubportadoraDado.localizacao_v) = pamdemod(dadoModuladoRuidoGauss(configSubportadoraDado.localizacao_v), configSubportadoraDado.grau);
    elseif (configSubportadoraDado.metodo == "qam")
        bits(configSubportadoraDado.localizacao_v) = qamdemod(dadoModuladoRuidoGauss(configSubportadoraDado.localizacao_v), configSubportadoraDado.grau);
    end
    
    % configSubportadoraPilotos
    for idx = 1:size(configSubportadoraPiloto.localizacao_v,2)
        if (configSubportadoraPiloto.metodo_v(idx) == "dpsk")
            bits(configSubportadoraPiloto.localizacao_v(idx)) = dpskdemod(dadoModuladoRuidoGauss(configSubportadoraPiloto.localizacao_v(idx)), configSubportadoraPiloto.grau_v(idx));
        elseif (configSubportadoraPiloto.metodo_v(idx) == "psk")
            bits(configSubportadoraPiloto.localizacao_v(idx)) = pskdemod(dadoModuladoRuidoGauss(configSubportadoraPiloto.localizacao_v(idx)), configSubportadoraPiloto.grau_v(idx));
        elseif (configSubportadoraPiloto.metodo_v(idx) == "pam")
            bits(configSubportadoraPiloto.localizacao_v(idx)) = pamdemod(dadoModuladoRuidoGauss(configSubportadoraPiloto.localizacao_v(idx)), configSubportadoraPiloto.grau_v(idx));
        elseif (configSubportadoraPiloto.metodo_v(idx) == "qam")
            bits(configSubportadoraPiloto.localizacao_v(idx)) = qamdemod(dadoModuladoRuidoGauss(configSubportadoraPiloto.localizacao_v(idx)), configSubportadoraPiloto.grau_v(idx));
        end
    end

end