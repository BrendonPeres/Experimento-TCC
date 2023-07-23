function [dadoModulado,bitsNaoPilotos] = modular(dado, piloto) %MatlabDoc:DPSK, PSK, PAM, QAM | Wikipedia:ASK, FSK, PSK, QAM
% Modula todas as portadoras.

    qtdPortadoras = size(dado.localizacao,2) + size(piloto.localizacao,2);
    dadoModulado = zeros(1, qtdPortadoras);
    bitsNaoPilotos = randi(dado.grau - 1,size(dado.localizacao,2),1);

    if (dado.metodo == "dpsk") 
        dadoModulado(dado.localizacao) = dpskmod(bitsNaoPilotos, dado.grau);
    elseif (dado.metodo == "psk")
        dadoModulado(dado.localizacao) = pskmod(bitsNaoPilotos, dado.grau);
    elseif (dado.metodo == "pam")
        dadoModulado(dado.localizacao) = pammod(bitsNaoPilotos, dado.grau);
    elseif (dado.metodo == "qam")
        dadoModulado(dado.localizacao) = qammod(bitsNaoPilotos, dado.grau);
    end
    
    for idx = 1:size(piloto.localizacao,2)
        if (piloto.metodo(idx) == "dpsk")
            dadoModulado(piloto.localizacao(idx)) = dpskmod(randi([0 (piloto.grau(idx) - 1)]), piloto.grau(idx)) * piloto.razaoPilotoDado(idx) * exp(1i*piloto.rotacao(idx));
        elseif (piloto.metodo(idx) == "psk")
            dadoModulado(piloto.localizacao(idx)) = pskmod(randi([0 (piloto.grau(idx) - 1)]), piloto.grau(idx)) * piloto.razaoPilotoDado(idx) * exp(1i*piloto.rotacao(idx));
        elseif (piloto.metodo(idx) == "pam")
            dadoModulado(piloto.localizacao(idx)) = pammod(randi([0 (piloto.grau(idx) - 1)]), piloto.grau(idx)) * piloto.razaoPilotoDado(idx) * exp(1i*piloto.rotacao(idx));
        elseif (piloto.metodo(idx) == "qam")
            dadoModulado(piloto.localizacao(idx)) = qammod(randi([0 (piloto.grau(idx) - 1)]), piloto.grau(idx)) * piloto.razaoPilotoDado(idx) * exp(1i*piloto.rotacao(idx));
        end
    end
    
end