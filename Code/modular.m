function [configSubportadoraDadoModulado,bitsNaoPilotos] = modular(configSubportadoraDado, configSubportadoraPiloto) %MatlabDoc:DPSK, PSK, PAM, QAM | Wikipedia:ASK, FSK, PSK, QAM
% Modula todas as portadoras.

    qtdSubportadoras = numel(configSubportadoraDado.localizacao_v) + numel(configSubportadoraPiloto.localizacao_v);
    configSubportadoraDadoModulado = zeros(1, qtdSubportadoras);
    bitsNaoPilotos = randi(configSubportadoraDado.grau - 1,numel(configSubportadoraDado.localizacao_v),1);
    if (configSubportadoraDado.metodo == "dpsk") 
        configSubportadoraDadoModulado(configSubportadoraDado.localizacao_v) = dpskmod(bitsNaoPilotos, configSubportadoraDado.grau);
    elseif (configSubportadoraDado.metodo == "psk")
        configSubportadoraDadoModulado(configSubportadoraDado.localizacao_v) = pskmod(bitsNaoPilotos, configSubportadoraDado.grau);
    elseif (configSubportadoraDado.metodo == "pam")
        configSubportadoraDadoModulado(configSubportadoraDado.localizacao_v) = pammod(bitsNaoPilotos, configSubportadoraDado.grau);
    elseif (configSubportadoraDado.metodo == "qam")
        configSubportadoraDadoModulado(configSubportadoraDado.localizacao_v) = qammod(bitsNaoPilotos, configSubportadoraDado.grau);
    end


    for idx = 1:numel(configSubportadoraPiloto.localizacao_v)
        if (configSubportadoraPiloto.metodo_v(idx) == "dpsk")
            configSubportadoraDadoModulado(configSubportadoraPiloto.localizacao_v(idx)) = dpskmod(randi([0 (configSubportadoraPiloto.grau_v(idx) - 1)]), configSubportadoraPiloto.grau_v(idx)) * configSubportadoraPiloto.razaoPilotoDado_v(idx) * exp(1i*configSubportadoraPiloto.rotacao_v(idx));
        elseif (configSubportadoraPiloto.metodo_v(idx) == "psk")
            configSubportadoraDadoModulado(configSubportadoraPiloto.localizacao_v(idx)) = pskmod(randi([0 (configSubportadoraPiloto.grau_v(idx) - 1)]), configSubportadoraPiloto.grau_v(idx)) * configSubportadoraPiloto.razaoPilotoDado_v(idx) * exp(1i*configSubportadoraPiloto.rotacao_v(idx));
        elseif (configSubportadoraPiloto.metodo_v(idx) == "pam")
            configSubportadoraDadoModulado(configSubportadoraPiloto.localizacao_v(idx)) = pammod(randi([0 (configSubportadoraPiloto.grau_v(idx) - 1)]), configSubportadoraPiloto.grau_v(idx)) * configSubportadoraPiloto.razaoPilotoDado_v(idx) * exp(1i*configSubportadoraPiloto.rotacao_v(idx));
        elseif (configSubportadoraPiloto.metodo_v(idx) == "qam")
            configSubportadoraDadoModulado(configSubportadoraPiloto.localizacao_v(idx)) = qammod(randi([0 (configSubportadoraPiloto.grau_v(idx) - 1)]), configSubportadoraPiloto.grau_v(idx)) * configSubportadoraPiloto.razaoPilotoDado_v(idx) * exp(1i*configSubportadoraPiloto.rotacao_v(idx));
        end
    end
    
end